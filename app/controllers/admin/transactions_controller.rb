class Admin::TransactionsController < ApplicationController
  before_filter :authenticate_user! # check user_signed_in?
  before_filter :team #retrieve team
  before_filter :can_access?
	  before_filter :autho_google_chart, :only => [:viewers, :load_chart, :viewers_filter]
  before_filter :authenticate_user!, :only => [:subscribers, :game_purchases]
  layout "team_layout"

  def subscribers
    subcribers = current_user.get_subscriber_for_this_year(@team.id, false)
    games = current_user.get_subscriber_for_this_year(@team.id, true)
    @total_raise = (subcribers[:fees] + games[:fees]).round
    @array_data = GoogleVisualr::DataTable.new
    @array_data.new_column('string', 'Year' )
    @array_data.new_column('number', 'Rate')
    @data = current_user.get_subscriber_for_this_year(@team.id)
    # Add Rows and Values
    @array_data.add_rows(@data[:table_data])
    option = { width: 780, height: 300, lineWidth:4, pointSize:8, colors:['#147C1C'] }
    @chart = GoogleVisualr::Interactive::LineChart.new(@array_data, option)
  end

  # Load total raise by time of subcribers and single game
  def load_data_for_select
    time = params[:time_select].to_i
    case time
    when User::THIS_YEAR
      data = current_user.get_subscriber_for_this_year(@team.id, params[:individual])
      @total_raise = data[:fees].round
      render :partial => "total_raise", :locals => {:total_raise => @total_raise}
    when User::THIS_MONTH
      data = current_user.get_subscriber_for_this_month(@team.id, params[:individual])
      @total_raise = data[:fees].round
      render :partial => "total_raise", :locals => {:total_raise => @total_raise}
    when User::INCEPTION
      data = current_user.get_subscriber_for_this_year(@team.id, params[:individual])
      @total_raise = data[:fees].round
      render :partial => "total_raise", :locals => {:total_raise => @total_raise}
    when User::PERIOD
      data = current_user.get_subscriber_for_this_month(@team.id, params[:individual])
      @total_raise = data[:fees].round
      render :partial => "total_raise", :locals => {:total_raise => @total_raise}
    else
      data = current_user.load_data_for_distance_time(@team.id, params[:from_date], params[:end_date], params[:individual])
      @array_data = GoogleVisualr::DataTable.new
      @array_data.new_column('string', 'Date' )
      @array_data.new_column('number', 'Rate')
      @array_data.add_rows(data[:table_data])
      option = { width: 780, height: 300, lineWidth:4, pointSize:8, colors:['#147C1C'] }
      @chart = GoogleVisualr::Interactive::LineChart.new(@array_data, option)
      respond_to do |format|
        format.js
      end
    end

  end
  def game_purchases
    subcribers = current_user.get_subscriber_for_this_year(@team.id, false)
    games = current_user.get_subscriber_for_this_year(@team.id, true)
    @total_raise = (subcribers[:fees] + games[:fees]).round

    @array_data = GoogleVisualr::DataTable.new
    @array_data.new_column('string', 'Year' )
    @array_data.new_column('number', 'Rate')
    @data = current_user.get_subscriber_for_this_year(@team.id, true)
    # Add Rows and Values
    @array_data.add_rows(@data[:table_data])
    option = { width: 780, height: 300, lineWidth:4, pointSize:8, colors:['#147C1C'] }
    @chart = GoogleVisualr::Interactive::LineChart.new(@array_data, option)
  end

  #----------------------------------------------------------------------------------------
  #           SHOW VIEWERS OF PAGE
  #  Description:
  #                 -  date is static now (must change later)
  #                 -  get data from google analytics and draw chart
  #                 -  Exits class (in /model) define what data to get
  #                 -  get total money from Order table for this team
  #
  #         GEM USE     gem Garb: get data from google analytics,
  #                     gem google_visualr to draw chart
  #
  #----------------------------------------------------------------------------------------

  # change this to Order.find(team_id) ---->later work
  # -------------------
  def viewers
    subcribers = current_user.get_subscriber_for_this_year(@team.id, false)
    games = current_user.get_subscriber_for_this_year(@team.id, true)
    @total_raise = (subcribers[:fees] + games[:fees]).round
    @array_data = GoogleVisualr::DataTable.new()
    option = { width: 780, height: 300, lineWidth:4, pointSize:8, colors:['#147C1C'] }

    @array_data.new_column('string','Month')
    @array_data.new_column('number','Views')
    # Query the result from google server
    output = DateAnalytic.results(@profile, :filters => {:pagePath.contains => admin_team_path(@team)},
      :start_date => Date.today.beginning_of_month, :end_date => Date.today.end_of_month)
    output.each { |s|
      day  = s.date[6..7].to_s
      month = s.date[4..5].to_s
      @array_data.add_row([day,s.pageviews.to_i])
    }
    @chart = GoogleVisualr::Interactive::LineChart.new(@array_data, option)
  end

  #----------------------------------AJAX load ---------------------------------
  # (not use anymore)
  #     Description:
  #           - Get data from google after config
  #           - Gererate chart
  #
  #-----------------------------------------------------------------------------

  def load_chart
    puts "-------------------------------------LOADCHART"
    option = { width: 780, height: 300, lineWidth:4, pointSize:8, colors:['#147C1C'] }
    path   = admin_team_path(@team)
    start_date = @team.created_at
    end_date = Date.today
    @array_data = GoogleVisualr::DataTable.new()
    #-----AJAX request----------------------------------------------------------

    choose = params[:time_select].to_i

    start_date = Date.today
    end_date   = Date.today
    today      = Date.today
    output     = nil

    case choose
    when User::INCEPTION
      start_date = @team.created_at
      @array_data.new_column('string','Month')
      # Query the result from google server
      output = MonthAnalytic.results(@profile, :filters => {:pagePath.contains => path},
        :start_date => start_date,:end_date => end_date)
      @array_data.new_column('number','Views')

      output.each { |s|
        @array_data.add_row([Date::MONTHNAMES[s.month.to_i],s.pageviews.to_i])
      }
    when User::THIS_YEAR
      start_date = Date.new(today.year,1,1)
      @array_data.new_column('string','Month')
      # Query the result from google server
      output = MonthAnalytic.results(@profile, :filters => {:pagePath.contains => path},
        :start_date => start_date,:end_date => end_date)
      @array_data.new_column('number','Views')

      output.each { |s|
        @array_data.add_row([Date::MONTHNAMES[s.month.to_i],s.pageviews.to_i])
      }
    when User::THIS_MONTH
      start_date = Date.new(today.year,today.month,1)
      @array_data.new_column('string','Date')
      # Query the result from google server
      output = DateAnalytic.results(@profile, :filters => {:pagePath.contains => path},
        :start_date => start_date,:end_date => end_date)
      @array_data.new_column('number','Views')

      output.each { |s|
        year = s.date[0..3].to_i
        month = s.date[4..5].to_i
        day  = s.date[6..7].to_i
        @array_data.add_row([Date.new(year,month, day).to_s,s.pageviews.to_i])
      }
    when User::PERIOD
      #TODO
    else
      #TODO
    end

    puts "------------------",@array_data.inspect
    @chart = GoogleVisualr::Interactive::LineChart.new(@array_data, option)
    render :partial => "chart_subscribers"
  end

  #----------------------------------FILTER-------------------------------------
  #   Description:
  #        get viewers from from_date to end_day
  #   Add filter condition <------Later work!            TODO
  #-----------------------------------------------------------------------------
  def viewers_filter
    option = { width: 780, height: 300, lineWidth:4, pointSize:8, colors:['#147C1C'] }
    path   = admin_team_path(@team)
    start_date = params["from_date"].to_date

    end_date = params["end_date"].to_date
    if !start_date || !end_date
      flash[:notice] = failure_message
      return
    end
    if start_date>end_date
      flash[:notice] = failure_message #<--------Change
      return
    end
    @array_data = GoogleVisualr::DataTable.new()
    @array_data.new_column('string','Date')
    @array_data.new_column('number','Views')
    output = DateAnalytic.results(@profile, :filters => {:pagePath.contains => path},
      :start_date => start_date,:end_date => end_date)
    output.each { |s|
      day  = s.date[6..7].to_s
      month = s.date[4..5].to_s
      @array_data.add_row([day,s.pageviews.to_i])
    }

    @chart = GoogleVisualr::Interactive::LineChart.new(@array_data, option)
    respond_to do |format|
      format.js
    end

  end


  def cancellations

  end
  #--------------------------SEND CHART TO EMAIL------------------------------------
  #   Description:
  #               - call mail action in mailers directory
  #               - send request to draw a google chart (url)
  #               - params: total_raise, email, chart_url, last_action
  #---------------------------------------------------------------------------------
  def send_mail_report
    total_raise = params[:total_raise]
    email = params[:email]
    chart_url = params[:chart_url]
    last_action = params[:last_action]
    GoogleAnalyticsMailer.report_mail(team, email, total_raise,chart_url,last_action).deliver()
    direct_page = "/admin/teams/"+@team.slug+"/"+last_action

    redirect_to direct_page
  end

  # Load total raise by time for viewers
  def load_total_raise_by_time
    time = params[:time_select].to_i
    case time
    when User::THIS_YEAR
      subcribers = current_user.get_subscriber_for_this_year(@team.id, false)
      games = current_user.get_subscriber_for_this_year(@team.id, true)
      @total_raise = (subcribers[:fees] + games[:fees]).round
      render :partial => "total_raise", :locals => {:total_raise => @total_raise}
    when User::THIS_MONTH
      subcribers = current_user.get_subscriber_for_this_month(@team.id, false)
      games = current_user.get_subscriber_for_this_month(@team.id, true)
      @total_raise = (subcribers[:fees] + games[:fees]).round
      render :partial => "total_raise", :locals => {:total_raise => @total_raise}
    when User::INCEPTION
      subcribers = current_user.get_subscriber_for_this_year(@team.id, false)
      games = current_user.get_subscriber_for_this_year(@team.id, true)
      @total_raise = (subcribers[:fees] + games[:fees]).round
      render :partial => "total_raise", :locals => {:total_raise => @total_raise}
    when User::PERIOD
      subcribers = current_user.get_subscriber_for_this_month(@team.id, false)
      games = current_user.get_subscriber_for_this_month(@team.id, true)
      @total_raise = (subcribers[:fees] + games[:fees]).round
      render :partial => "total_raise", :locals => {:total_raise => @total_raise}
    else
      data = current_user.load_data_for_distance_time(@team.id, params[:from_date], params[:end_date], params[:individual])
      @array_data.add_rows(data[:table_data])
      @chart = GoogleVisualr::Interactive::LineChart.new(@array_data, option)
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def failure_message
    "Can't render chart, please check input again!"
  end
  def team
    @team = Team.find_by_slug(params[:team_id].to_s)
  end
  def autho_google_chart
    #--------------------------ACCOUNT AND APP ID--------------------------------------
    # tpldev.teamzoom@gmail.com","teamzoom1234", app id = UA-34084113-1
    #
    # You must change the property id and set path (or IP) for your website.
    #                https://www.google.com/analytics/web
    # Later work:
    #       Add fiter to the query like this
    #       :filter => {hostname.contains=>"teamzoom.com"}
    # More information about query look for http://ga-dev-tools.appspot.com/explorer/
    #   and gem rack-google_analytics
    # ---------------------------------------------------------------------------------
    Garb::Session.login("tztest2013@gmail.com","Ryantz23!")
    @profile = Garb::Management::Profile.all.detect {|p| p.web_property_id == 'UA-34084113-1'}
    puts 11111111111111111111, @profile.inspect
  end
  def can_access?
    if !current_user||(!current_user.is_manager? && !current_user.is_admin?)
      redirect_to team_path(@team, :pass=>'yes')
    end
  end
end

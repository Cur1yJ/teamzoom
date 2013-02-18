
class OrdersController < ApplicationController

  def new
    @order = Order.new
    @type_payment = params[:individual_game]
    @schedule_id = params[:schedule_id]
  end

  def edit
    @order = Order.find(params[:id].to_s)
  end


  def create
    params[:order][:total_price] = Order::PRICE_MONTH
    params[:order][:individual_game] = false

    @order = current_user.orders.build(params[:order])
    @order.ip_address = request.remote_ip
    unless current_user.team.nil?
      @order.school_id = current_user.team.school.id
    end
    @order.tax = (@order.total_price*Order::PERCENT_TAX)
    respond_to do |format|
      if @order.save
        @response = @order.purchase_recurring
        if @response.success?
          PaymentMailer.monthly_subscription(current_user, @order).deliver
          format.html { render :action => "term_and_service" }
          format.js{ render(:js => "window.location.href = '#{term_and_service_orders_path}'") if params['reload_page'] == 'true' }
        else
          format.html { render :action => "failure" }
          format.js
        end
      else
        format.html { render :action => 'new' }
        format.js
      end
    end
  end

  def payment_game
    params[:order][:total_price] = Order::PRICE_GAME
    params[:order][:individual_game] = true
    @is_purchase = false

    @order = current_user.orders.build(params[:order])
    schedule = Schedule.find(params[:schedule_id].to_s)
    unless current_user.team.nil?
      if [schedule.subteam_home.teamsport.team.id, schedule.subteam_opponent.teamsport.team.id ].include?(current_user.team.id)
        @order.school_id = current_user.team.school.id
      else
        @order.team_id = schedule.subteam_home.teamsport.team.id
      end
    else
      @order.team_id = schedule.subteam_home.teamsport.team.id
    end
    @order.tax = (@order.total_price*Order::PERCENT_TAX)
    @order.ip_address = request.remote_ip
    respond_to do |format|
      if @order.save
        @response = @order.purchase
        PaymentMailer.single_game(current_user, @order).deliver if @response.success?
      end
      format.js
    end
  end

  def cancel
    order = current_user.orders.last
    order.cancel_recurring
    redirect_to root_path
  end
  def confirm

  end

  def failure
  end

  def term_and_service
  end
  def term_of_use
    render :layout => false
  end


end


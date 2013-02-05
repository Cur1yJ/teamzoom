######################################################################
# Change History
######################################################################
# Date-02/01/2013
# Coder- Shrikant Khandare
# Description:Replaced code in initialize method. 
#             Replaced code with use of ternary operator. Separated 
#             existing code in two new methods 
#             1)adminable and 2)managerable
######################################################################

class Ability

  include CanCan::Ability
  
   def adminable
      can :manage, Team
      can [:manage,:administration], User
   end
 
   def managerable(user)
       if user.role =="Manager"
	  can :read, Team
	  cannot [:index,:administration], User
	  cannot :index, Team
       end
   end

   def initialize(user)
	  user ||= User.new 
	  alias_action :update_by_email, :delete_by_email, :to => :administration
	  (user.role =="Admin") ? adminable : managerable(user)
   end

    # if user.role != "Admin"
    #   cannot :index, Team
    # end
    # can :edit Team do |team|
    #     Tema.find(team)
    # end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
 
end

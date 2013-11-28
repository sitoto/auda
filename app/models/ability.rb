class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if !user.blank?
      #cannot :manage , :all
      basic_read_only
    end

    # Define abilities for the passed in user here. For example:
    #
    # user ||= User.new # guest user (not logged in)
    if user.has_role?(:admin)
      can :manage, :all
    elsif user.has_role?(:data_manager)
      can :read, Csvfile
      can :node, Category

      can :manage, Property
      can :manage, Node
      can :manage, Pair
      can :manage, Category
      can :manage, Product
      cannot :destroy, Category

    elsif user.has_role?(:data_editor)
      can :read, Csvfile
      can :read, Property
      can :create, Property
      can :create, Csvfile
      can :read, Pair
      can :create, Pair
      can :doing, Pair
      can :read, Node
      can :draft, Product
      can :read, Product
      can :doing, Product
      can :update, Product do |product|
        product.status == 0
      end
      can :create, Product
      # temp add 
      can :manage, Property
      can :update, Category
      can :read, Category
      can :create, Category
      can :node, Category

    elsif user.has_role?(:data_gather)
      can :read, Category 
      can :read, Csvfile
      can :read, Pair
      can :read, Node
      can :create, Csvfile
      can :create, Pair
      can :node, Category

    end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
  protected
  def basic_read_only
#    can :node, Category
  end
end

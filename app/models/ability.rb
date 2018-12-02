class Ability
  include CanCan::Ability

  def initialize(user)

      user ||= User.new # guest user (not logged in)
      #Admin
      if user.admin?
        can :manage, :all
      #Seller && Buyer
    elsif user.seller? || user.buyer?
          can :manage, Listing, user_id: user.id
          can :read, Listing
          can :manage, Order, buyer_id: user.id
          can :manage, Order, seller_id: user.id
          can :manage, StripeAccount, user_id: user.id
          can :manage, BankAccount, user_id: user.id
          can :manage, User, user_id: user.id

          # can [:read, :update] Order
      #Buyer
          elsif user.buyer?
            can :read, Listing
            can [:create, :read, :edit, :purchases], Order, buyer_id: user.id

      #Guest
          else
            can :read, Listing
            can :create, Order
            can :create, User
          end
        end





      # if user.buyer?
      #   can [:read, :create, :update], Order
      #   cannot [:create, :update, :destroy], Listing
      #   can [:read], Listing


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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
end

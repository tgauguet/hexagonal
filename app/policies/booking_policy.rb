class BookingPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def destroy?
    user.admin?
  end

  def accept?
    user.admin?
  end

  def download?
    user.admin?
  end

end

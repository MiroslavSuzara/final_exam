class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :user

  validates :bid, numericality: {greater_than_or_equal_to: 0}  

  def user_first_name
    user.first_name if user
  end

end

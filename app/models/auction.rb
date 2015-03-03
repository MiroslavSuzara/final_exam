class Auction < ActiveRecord::Base
  validates :title, :details, :ends_on, :reserve_price, presence: true
  validates :reserve_price, numericality: {greater_than_or_equal_to: 0}
  has_many :bids, dependent: :destroy

  belongs_to :user

  def user_first_name
    user.first_name if user
  end

end

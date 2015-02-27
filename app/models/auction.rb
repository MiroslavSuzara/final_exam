class Auction < ActiveRecord::Base
  validates :title, :details, :ends_on, :reserve_price, presence: true
  has_many :bids, dependent: :destroy
end

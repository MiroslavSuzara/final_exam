class Bid < ActiveRecord::Base
  belongs_to :auction
  validates :bid,  numericality: {greater_than_or_equal_to: 0}  
end

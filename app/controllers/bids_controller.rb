class BidsController < ApplicationController
  
  def create
    @auction = Auction.find params[:auction_id]
    @bid = @auction.bids.new params.require(:bid).permit(:bid) 
  end

end

class BidsController < ApplicationController
  
  def index
    @bids = Bid.all
  end

  def create
    @auction = Auction.find params[:auction_id]
    @bid = Bid.new params.require(:bid).permit(:bid) 
    @bid.auction = @auction
    if @bid.save 
      redirect_to @auction, notice: "Bid created."
    else
      flash[:alert] = "Your bid was not created."
      render '/auctions/show'
    end
  end
end

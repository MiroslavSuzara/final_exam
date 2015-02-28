class BidsController < ApplicationController
  
  def index
    @bids = Bid.all
  end

  def create
    @auction = Auction.find params[:auction_id]
    @bid = Bid.new params.require(:bid).permit(:bid) 
    @bid.auction = @auction
    if @bid.bid.to_f >= bid_price(@auction)
      @bid.save 
      redirect_to @auction, notice: "Bid created."
    else
      flash[:alert] = "Your bid was not created."
      render '/auctions/show'
    end
  end
end

  private

  def bid_price(auction)
    if auction.bids.count !=0
      auction.bids.last.bid + 1
    else
      1
    end
  end

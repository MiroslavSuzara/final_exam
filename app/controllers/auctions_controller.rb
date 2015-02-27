class AuctionsController < ApplicationController

  def index
    @auctions = Auction.all
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new params.require(:auction).permit(:title, :details, :ends_on, :reserve_price)
    if @auction.save
      redirect_to @auction
    else
      render :new
    end
  end

  def show
    @auction = Auction.find params[:id]
    @bid = Bid.new
    @bids = @auction.bids.all
  end

  def edit
    @auction = Auction.find params[:id]
  end

  def update
    @auction = Auction.find params[:id]

    if @auction.update params.require(:auction).permit(:title, :details, :ends_on, :reserve_price)
      redirect_to @auction
    else
      render :edit
    end
  end

  def destroy
    @auction = Auction.find params[:id]
    @auction.destroy
    redirect_to auctions_path
  end

end

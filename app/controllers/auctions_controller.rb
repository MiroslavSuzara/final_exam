class AuctionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @auctions = Auction.all
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new params.require(:auction).permit(:title, :details, :ends_on, :reserve_price)
    @reflection.user = current_user     

    if @auction.save
      redirect_to @auction, notice: "Auction created."
    else
      render :new
    end
  end

  def show
    @auction = Auction.find params[:id]
    @bid = Bid.new
    @bids = @auction.bids.all.order("created_at DESC")
        @current_price = @auction.try(:bids).maximum(:bid)
        @current_price = @current_price + 1 if @current_price
        if @current_price && @current_price >= @auction.reserve_price
            @reserve_met = "Reserve Has Been Met"
        else
            @reserve_met = "Reserve Has Not Been Met"
        end
    end
    # if @auction.bids.count != 0
    #   @current_price = @auction.bids.maximum("bid") + 1
    # end
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


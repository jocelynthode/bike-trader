class AuctionsController < ApplicationController
  def index
    @auctions = Auction.all
  end

  def show
    @auction = Auction.find(params[:id])
  end

  def new
    @auction = Auction.new
  end

  def edit
    @auction = Auction.find(params[:id])
  end

  def create
    @auction = Auction.new(auction_params)

    if @auction.save
      redirect_to @auction
    else
      render 'new'
    end
  end

  def update
    @auction = Auction.find(params[:id])

    if @auction.update(auction_params)
      redirect_to @auction
    else
      render 'edit'
    end
  end

  def destroy
    @auction = Auction.find(params[:id])
    @auction.destroy

    redirect_to auctions_path
  end

  private def auction_params
    params.require(:auction).permit(:title, :text, :start, :end)
  end
end

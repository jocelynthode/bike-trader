class AuctionsController < ApplicationController
  def new
  end

  def create
    @auction = Auction.new(auction_params)

    @auction.save
    redirect_to @auction
  end

  def show
    @auction = Auction.find(params[:id])
  end

  private def auction_params
    params.require(:auction).permit(:title, :text, :start, :end)
  end
end

class BidsController < ApplicationController

  def index
    @auction = Auction.find(params[:auction_id])
    redirect_to auction_path(@auction)
  end

  def create
    @auction = Auction.find(params[:auction_id])
    info =  {:user => current_user, :time => DateTime.current}
    @bid = @auction.bids.create(info.merge(bid_params))
    if @bid.save
      redirect_to auction_path(@auction)
    else
      render 'auctions/show'
    end
  end

  private
    def bid_params
      params.require(:bid).permit(:amount, :threshold, :user, :time)
    end
end

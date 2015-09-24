class BidsController < ApplicationController
  def create
    @auction = Auction.find(params[:auction_id])
    info =  {:user => current_user, :time => DateTime.current}
    @bid = @auction.bids.create(info.merge(bid_params))
    redirect_to auction_path(@auction)
  end

  private
    def bid_params
      params.require(:bid).permit(:amount, :threshold, :user, :time)
    end
end

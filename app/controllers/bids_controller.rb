class BidsController < ApplicationController
  before_action :require_permission, only: [:create]
  def index
    @auction = Auction.find(params[:auction_id])
    redirect_to auction_path(@auction)
  end

  def create
    @auction = Auction.find(params[:auction_id])
    current_bid =  if @auction.bids.select(&:persisted?).empty?
                     @auction.minimum_price
                   else
                     @auction.bids.select(&:persisted?).each.max_by(&:amount).amount
                   end
    info =  {:user => current_user, :time => DateTime.current}
    @bid = @auction.bids.build(info.merge(bid_params))

    if @bid.amount > current_bid
      if @bid.save
        redirect_to auction_path(@auction)
      else
        render 'auctions/show'
      end
    else
      @bid.errors.add(:amount, "must be greater than #{current_bid}")
      render 'auctions/show'
    end
  end

  private

    def require_permission
      @auction = Auction.find(params[:auction_id])
      if @auction.ended? || current_user.id == @auction.user_id
        redirect_to auction_path
      end
    end

    def bid_params
      params.require(:bid).permit(:amount, :threshold, :user, :time)
    end
end

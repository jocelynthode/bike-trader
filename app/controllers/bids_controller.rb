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

    @bid = @auction.bids.build(bid_params.merge(info))

    if @bid.amount > current_bid
      if @bid.save
        automatic_bid(@bid)
        if (DateTime.now + 5.minutes) > @auction.end
          @auction.update(end: (DateTime.now + 15.minutes))
        end
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
      if @auction.ended? || current_user == @auction.user
        redirect_to @auction
      end
    end

    def automatic_bid(bid)
      @auction = Auction.find(params[:auction_id])
      #find the highest bids that have a threshold higher than the current highest bid
      bids = Bid.where('threshold > ? AND auction_id = ? AND user_id != ?', bid.amount, params[:auction_id], bid.user_id).having(
          'MAX(amount)').group(:user_id).order(:threshold, time: :desc)

      if bids.length >= 1 && bid.threshold != nil && bids[-1].threshold < bid.threshold
        new_amount = bids[-1].threshold + 1
        new_amount = bid.threshold if new_amount > bid.threshold
        new_bid = @auction.bids.build(user_id: bid.user_id,
                                      amount: new_amount, threshold: bid.threshold,
                                      time: DateTime.now)
        new_bid.save
        return
      end

      if bids.length > 1
        #find the second to max threshold since this is the only one we need to beat
        second_to_max = bids[-2].threshold

        new_amount = bids[-1].threshold == second_to_max ? second_to_max : second_to_max + 1
        new_amount = bids[-1].threshold if new_amount > bids[-1].threshold
      elsif bids.length == 1
        new_amount = bids.first.threshold < bid.amount + 1 ? bids.first.threshold : bid.amount + 1
      else
        return
      end
      new_bid = @auction.bids.build(user_id: bids.first.user_id,
                                    amount: new_amount, threshold: bid.threshold,
                                    time: DateTime.now)
      new_bid.save
    end

    def bid_params
      params.require(:bid).permit(:amount, :threshold, :user, :time)
    end
end

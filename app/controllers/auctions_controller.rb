class AuctionsController < ApplicationController
  before_action :require_permission, only: [:edit, :update, :destroy ]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:q] == nil then
      @auctions = Auction.all
      @search = Auction.search(params[:q])
    else
      @search = Auction.search(params[:q])
      @auctions = @search.result
    end
  end

  def show
    @auction = Auction.find(params[:id])
  end

  def new
    @auction = Auction.new
  end

  def edit
  end

  def create
    @auction = current_user.auctions.new(auction_params)

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
    @auction.destroy

    redirect_to auctions_path
  end

  def require_permission
    @auction = Auction.find(params[:id])
    if current_user != @auction.user
      redirect_to auctions_path
    end
  end

  private def auction_params
    params.require(:auction).permit(:title, :text, :start, :end, :kwh, :mileage, :color, :brand, :avatar)
  end
end

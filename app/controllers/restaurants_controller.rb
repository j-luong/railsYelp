class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    if @restaurant.save
      redirect_to restaurants_path
    else
      render "new"
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if current_user.created_restaurant?(@restaurant)
      @restaurant.update(restaurant_params)
      flash[:notice] = "Restaurant updated successfully"
      redirect_to "/restaurants"
    else
      redirect_to "/restaurants",
      alert: "Cannot update as you did not create this restaurant"
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if current_user.created_restaurant?(@restaurant)
      @restaurant.destroy
      flash[:notice] = "Restaurant deleted successfully"
      redirect_to "/restaurants"
    else
      redirect_to "/restaurants",
      alert: "Cannot delete as you did not create this restaurant"
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :image)
  end
end

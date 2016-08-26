class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build_with_user(review_params, current_user)

    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        redirect_to restaurants_path,
        alert: 'You have already reviewed this restaurant'
      else
        render :new
      end
    end
  end

  def edit
    @review = Review.find(params[:restaurant_id])
  end

  def update
    @review = Review.find(params[:restaurant_id])
    @review.update(review_params)
    flash[:notice] = "Review updated successfully"
    redirect_to "/restaurants"
  end

  def destroy
    @review = Review.find(params[:restaurant_id])
    @review.destroy
    flash[:notice] = "Review deleted successfully"
    redirect_to "/restaurants"
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end

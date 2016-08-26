require "rails_helper"

feature "reviewing" do
  before do
    sign_up
    add_restaurant
  end

  scenario "can see review a restaurant" do
    visit "/restaurants"
    expect(page).to have_link "Review KFC"
  end

  scenario "allows users to enter a restaurant review" do
    visit "/restaurants"
    click_link "Review KFC"
    fill_in "Thoughts", with: "So so"
    select "3", from: "Rating"
    click_button "Leave review"
    click_link "KFC"
    restaurant = Restaurant.find_by(name: "KFC")
    expect(current_path).to eq "/restaurants/#{restaurant.id}"
    expect(page).to have_content "So so"
  end

  scenario "displays an average rating for all reviews" do
    leave_review("So so", "3")
    click_link "Sign out"
    sign_up(user: "hello@bye.com")
    leave_review("Great", "5")
    expect(page).to have_content('Average rating: ★★★★☆')
  end
end

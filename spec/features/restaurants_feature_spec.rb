require "rails_helper"

feature "restaurants" do
  context "no restaurants have been added" do
    scenario "should display a prompt to add a restaurant" do
      visit "/restaurants"
      expect(page).to have_content "No restaurants yet"
    end
  end

  context "viewing restaurants" do
    scenario "lets a user view a restaurant" do
      sign_up
      add_restaurant
      restaurant = Restaurant.where(name: "KFC").first
      click_link "KFC"
      expect(page).to have_content "KFC"
      expect(current_path).to eq "/restaurants/#{restaurant.id}"
    end
  end

  context "user not signed in" do
    scenario "cannot add new restaurant" do
      visit "/restaurants"
      expect(page).not_to have_link "Add a restaurant"
    end

    scenario "cannot edit a restaurant" do
      visit "/restaurants"
      expect(page).not_to have_link "Edit KFC"
    end

    scenario "cannot delete a restaurant" do
      visit "/restaurants"
      expect(page).not_to have_link "Delete KFC"
    end

    scenario "cannot review a restaurant" do
      visit '/restaurants'
      expect(page).not_to have_link "Review KFC"
    end
  end

  context "user has singed in" do
    before do
      sign_up
    end

    scenario "cannot edit/delete another user's restaurant" do
      add_restaurant
      click_link "Sign out"
      sign_up(user: "sus111@hotmail.com")
      expect(page).not_to have_link "Edit KFC"
      expect(page).not_to have_link "Delete KFC"
    end

    scenario "can see link to add a new restaurant" do
      expect(page).to have_link "Add a restaurant"
    end

    scenario "display restaurants" do
      add_restaurant(name: "KFC")
      expect(page).to have_content "KFC"
      expect(page).not_to have_content "No restaurants yet"
    end

    scenario "prompts user to fill out a form, then displays the new restaurant" do
      add_restaurant
      expect(page).to have_content "KFC"
      expect(current_path).to eq "/restaurants"
    end

    scenario "lets a user edit a restaurant" do
      add_restaurant
      restaurant = Restaurant.where(name: "KFC").first
      click_link "Edit KFC"
      fill_in "Name", with: "Kentucky Fried Chicken"
      fill_in "Description", with: "Deep fried goodness"
      click_button "Update Restaurant"
      click_link "Kentucky Fried Chicken"
      expect(page).to have_content "Kentucky Fried Chicken"
      expect(page).to have_content "Deep fried goodness"
      expect(current_path).to eq "/restaurants/#{restaurant.id}"
    end

    scenario "removes a restaurant when delete link is clicked" do
      add_restaurant(name: "KFC", description: "Deep fried goodness")
      click_link "Delete KFC"
      expect(page).not_to have_content "KFC"
      expect(page).to have_content "Restaurant deleted successfully"
    end

    scenario "does not let you enter a name that is too short" do
      add_restaurant(name: "kf")
      expect(page).not_to have_css "h3", text: "kf"
      expect(page).to have_content "error"
    end
  end
end

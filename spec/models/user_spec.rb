require 'rails_helper'

describe User, type: :model do
  it { is_expected.to have_many :reviewed_restaurants}

  # it 'returns true if user has already reviewed a specific restaurant' do
  #   user = User.create(email: "test@test.com", password: "qwerty")
  #   restaurant = Restaurant.create(name: "Moe's Tavern", user_id: user.id)
  #   Review.create(thoughts: 'Great!', user_id: user.id, restaurant_id: restaurant.id)
  #   expect(user.has_reviewed?(restaurant)).to eq(true)
  # end
end

def sign_up(user: "test@example.com", password: "testtest")
  visit("/")
  click_link("Sign up")
  fill_in("Email", with: user)
  fill_in("Password", with: password)
  fill_in("Password confirmation", with: password)
  click_button("Sign up")
end

def add_restaurant(name: "KFC", description: "Yum")
  click_link "Add a restaurant"
  fill_in "Name", with: name
  fill_in "Description", with: description
  click_button "Create Restaurant"
end

def leave_review(thoughts, rating)
  visit("/restaurants")
  click_link "Review KFC"
  fill_in "Thoughts", with: thoughts
  select rating, from: "Rating"
  click_button "Leave review"
end

require 'rails_helper'
include Helpers
describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "count for user's ratings is correct" do
    rating = FactoryGirl.create :rating, beer:beer1, user:user
    user2 = FactoryGirl.create :user, username: "Toinen", password:"Foobar2", password_confirmation: "Foobar2"
    FactoryGirl.create :rating, beer:beer2, user:user2
    visit user_path(user)
    expect(user.ratings.count).to eq(1)
    expect(page).to have_content "Has made 1 rating, average 10"

  end
 
  it "can be deleted by user" do
     rating = FactoryGirl.create :rating, beer:beer1, user:user
     visit user_path(user)
     expect{click_link "delete"}.to change{Rating.count}.from(1).to(0)

  end


end
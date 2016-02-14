require 'rails_helper'
include Helpers
describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "is created with valid name" do
    visit new_beer_path
    fill_in('beer[name]', with:'Kalja')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(2).to(3)
  end

    it "is not created with invalid name" do
    visit new_beer_path

    expect{
      click_button "Create Beer"
    }.to_not change{Beer.count}
      expect(page).to have_content "Name can't be blank"
  end
end
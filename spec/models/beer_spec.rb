require 'rails_helper'

RSpec.describe Beer, type: :model do
	describe "with name and style" do
  it "is saved" do
  	    beer = Beer.create name:"testikalja", style:"testistyle"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end
end
it "is not saved without name" do
beer = Beer.create style:"testistyle"
expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
end
it "is not saved without style" do
beer = Beer.create name:"testikalja"
expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
end
end

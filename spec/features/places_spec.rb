require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "if several are returned by the API, all are shown at the page" do
  	allow(BeermappingApi).to receive(:places_in).with("espoo").and_return(
      [ Place.new( name:"Kruunu", id: 1 ), Place.new(name:"Satulinna", id: 2) ]
    )

    visit places_path
    fill_in('city', with: 'espoo')
    click_button "Search"

    expect(page).to have_content "Kruunu"
    expect(page).to have_content "Satulinna"
  end
  it "if none are returned by the API, message is shown" do
  	allow(BeermappingApi).to receive(:places_in).with("hevonkuusi").and_return(
      []
    )

    visit places_path
    fill_in('city', with: 'hevonkuusi')
    click_button "Search"

    expect(page).to have_content "No locations in hevonkuusi"
  end
end
require 'rails_helper'

feature "User can search for representative by state" do
  scenario "with a valid state" do
    visit "/"
    select "Colorado", from: "stateSelect"
    click_on "Locate Members from the House"
    expect(current_path).to eq("/search")
    url = URI.parse(current_url).to_s
    expect(url).to include("state=CO")
    expect(page).to have_content("7 Results")
    within(".representatives") do
      expect(page).to have_selector(".representative", count: 7)
    end

    # And they should be ordered by seniority from most to least
    # Need to check for this

    within(first('.representative')) do
      expect(page).to have_selector(".name")
      expect(page).to have_selector(".role")
      expect(page).to have_selector(".party")
      expect(page).to have_selector(".district")
    end
  end
end

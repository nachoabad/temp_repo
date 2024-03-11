require 'rails_helper'

RSpec.feature "Visiting the homepage", type: :feature do
  before do
    company1 = FactoryBot.create(:company, name: "Tech Company", industry: "Technology")
    company2 = FactoryBot.create(:company, name: "Health Company", industry: "Healthcare")

    FactoryBot.create(:deal, amount: 100, company: company1)
    FactoryBot.create(:deal, amount: 200, company: company1)
    FactoryBot.create(:deal, amount: 300, company: company2)
    FactoryBot.create(:deal, amount: 400, company: company2)
  end

  scenario 'The visitor can see all companies' do
    visit '/'

    expect(page).to have_text('Tech Company')
    expect(page).to have_text('Health Company')
  end

  scenario 'The visitor can filter by company name' do
    visit '/'
    fill_in 'companyName', with: 'Tech'

    expect(page).to have_text('Tech Company')
    expect(page).not_to have_text('Health Company')
  end

  scenario 'The visitor can filter by minimum deal amount' do
    visit '/'
    fill_in 'minimumDealAmount', with: '500'

    expect(page).not_to have_text('Tech Company')
    expect(page).to have_text('Health Company')
  end

  # TODO: test more scenarios and pagination
end

require 'rails_helper'

RSpec.describe 'Api::V1::CompaniesController', type: :request do
  describe 'GET /api/v1/companies' do
    before do
      company1 = FactoryBot.create(:company, name: "Tech Company", industry: "Technology")
      company2 = FactoryBot.create(:company, name: "Health Company", industry: "Healthcare")

      FactoryBot.create(:deal, amount: 100, company: company1)
      FactoryBot.create(:deal, amount: 200, company: company1)
      FactoryBot.create(:deal, amount: 300, company: company2)
      FactoryBot.create(:deal, amount: 400, company: company2)
    end

    it 'returns all companies without any filter' do
      get '/api/v1/companies'

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['companies'].size).to eq(2)
      expect(json['pagination']['pages']).to eq(1)
    end

    it 'filters companies by name' do
      get '/api/v1/companies', params: { name: 'Tech' }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['companies'].size).to eq(1)
      expect(json['companies'].first['name']).to eq('Tech Company')
    end

    it 'applies pagination correctly' do
      get '/api/v1/companies', params: { items: 1 }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['companies'].size).to eq(1)
      expect(json['pagination']['pages']).to eq(2)
    end
  end
end

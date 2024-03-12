require 'rails_helper'

RSpec.describe CompanyQuery do
  before do
    company1 = FactoryBot.create(:company, name: "Tech Innovations", industry: "Technology", employee_count: 100, deals_count: 50)
    company2 = FactoryBot.create(:company, name: "Health Solutions", industry: "Healthcare", employee_count: 200, deals_count: 80)

    FactoryBot.create(:deal, amount: 100, company: company1)
    FactoryBot.create(:deal, amount: 200, company: company1)
    FactoryBot.create(:deal, amount: 300, company: company2)
    FactoryBot.create(:deal, amount: 400, company: company2)
  end

  let(:scope) { Company.all }

  context 'with no filters' do
    it 'returns all companies' do
      result = described_class.call(scope,{}).to_a
      expect(result.size).to eq(2)
      expect(result.first.name).to eq("Tech Innovations")
      expect(result.second.name).to eq("Health Solutions")
    end

    it 'returns companies with deals amounts sum' do
      result = described_class.call(scope,{}).to_a
      expect(result.first.deals_amounts_sum).to eq(300)
      expect(result.second.deals_amounts_sum).to eq(700)
    end 
  end

  context 'with name filter' do
    it 'returns companies matching the name' do
      result = described_class.call(scope, name: 'tech').to_a
      expect(result.size).to eq(1)
      expect(result.first.name).to eq("Tech Innovations")
    end
  end

  context 'with industry filter' do
    it 'returns companies in the specified industry' do
      result = described_class.call(scope, industry: 'healthcare').to_a
      expect(result.size).to eq(1)
      expect(result.first.industry).to eq("Healthcare")
    end
  end

  context 'with employee count filter' do
    it 'returns companies having employee count greater than or equal to the specified number' do
      result = described_class.call(scope, min_employee: 150).to_a
      expect(result.size).to eq(1)
      expect(result.first.employee_count).to be >= 150
    end
  end

  context 'with deals count filter' do
    it 'returns companies having deals count greater than or equal to the specified number' do
      result = described_class.call(scope, min_deal_amount: 400).to_a
      expect(result.size).to eq(1)
      expect(result.first.deals_amounts_sum).to be >= 400
    end
  end

  context 'with multiple filters' do
    it 'applies all filters correctly' do
      result = described_class.call(scope, name: 'tech', min_employee: 50, min_deal_amount: 40).to_a
      expect(result.count).to eq(1)
      expect(result.first.name).to eq("Tech Innovations")
    end
  end
end

require 'rails_helper'

RSpec.describe CompanyQuery do
  before do
    FactoryBot.create(:company, name: "Tech Innovations", industry: "Technology", employee_count: 100, deals_count: 50)
    FactoryBot.create(:company, name: "Health Solutions", industry: "Healthcare", employee_count: 200, deals_count: 80)
  end

  let(:scope) { Company.all }

  context 'with name filter' do
    it 'returns companies matching the name' do
      result = described_class.call(scope, name: 'tech')
      expect(result.count).to eq(1)
      expect(result.first.name).to eq("Tech Innovations")
    end
  end

  context 'with industry filter' do
    it 'returns companies in the specified industry' do
      result = described_class.call(scope, industry: 'healthcare')
      expect(result.count).to eq(1)
      expect(result.first.industry).to eq("Healthcare")
    end
  end

  context 'with employee count filter' do
    it 'returns companies having employee count greater than or equal to the specified number' do
      result = described_class.call(scope, min_employee: 150)
      expect(result.count).to eq(1)
      expect(result.first.employee_count).to be >= 150
    end
  end

  context 'with deals count filter' do
    it 'returns companies having deals count greater than or equal to the specified number' do
      result = described_class.call(scope, min_deal_amount: 60)
      expect(result.count).to eq(1)
      expect(result.first.deals_count).to be >= 60
    end
  end

  context 'with multiple filters' do
    it 'applies all filters correctly' do
      result = described_class.call(scope, name: 'tech', min_employee: 50, min_deal_amount: 40)
      expect(result.count).to eq(1)
      expect(result.first.name).to eq("Tech Innovations")
    end
  end
end
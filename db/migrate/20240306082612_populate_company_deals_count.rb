class PopulateCompanyDealsCount < ActiveRecord::Migration[7.0]
  def up
    Company.find_each do |company|
      Company.reset_counters(company.id, :deals)
    end
  end
end

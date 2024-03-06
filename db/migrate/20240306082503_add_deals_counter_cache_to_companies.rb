class AddDealsCounterCacheToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :deals_count, :integer, default: 0
  end
end

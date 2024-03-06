class AddIndexesToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_index :companies, :name
    add_index :companies, :industry
    add_index :companies, :employee_count
    add_index :companies, :deals_count
  end
end

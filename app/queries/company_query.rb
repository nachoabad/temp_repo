class CompanyQuery
  def self.call(scope, params)
    scope = scope.select('companies.*, SUM(deals.amount) AS deals_amounts_sum')
              .joins(:deals)
              .group('companies.id')
    scope = scope.where("lower(companies.name) LIKE ?", "#{params[:name].downcase}%") if params[:name].present?
    scope = scope.where("lower(companies.industry) LIKE ?", "#{params[:industry].downcase}%") if params[:industry].present?
    scope = scope.where("companies.employee_count >= ?", params[:min_employee]) if params[:min_employee].present?
    scope = scope.having('SUM(deals.amount) >= ?', params[:min_deal_amount]) if params[:min_deal_amount].present?
    scope
  end
end

class CompanyQuery
  def self.call(scope, params)
    scope = scope.where("lower(name) LIKE ?", "#{params[:name].downcase}%") if params[:name].present?
    scope = scope.where("lower(industry) LIKE ?", "#{params[:industry].downcase}%") if params[:industry].present?
    scope = scope.where("employee_count >= ?", params[:min_employee]) if params[:min_employee].present?
    scope = scope.where("deals_count >= ?", params[:min_deal_amount]) if params[:min_deal_amount].present?
    scope
  end
end
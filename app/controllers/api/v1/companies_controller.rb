class Api::V1::CompaniesController < Api::V1::BaseController
  def index
    companies = CompanyQuery.call(Company.all, params)
    pagination, companies = pagy(companies, items: params[:items] || 2)

    render json: {
      companies: companies.as_json(only: [:name, :industry, :employee_count], methods: [:deals_amounts_sum]),
      pagination: pagy_metadata(pagination)
    }
  end
end

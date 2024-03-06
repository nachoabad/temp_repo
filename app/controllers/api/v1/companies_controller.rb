class Api::V1::CompaniesController < Api::V1::BaseController
  def index
    companies = CompanyQuery.call(Company.all, params)
    pagination, companies = pagy(companies, items: params[:items] || 2)

    render json: { companies: companies, pagination: pagy_metadata(pagination) }
  end
end

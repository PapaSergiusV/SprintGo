class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  # Return worker list of company
  def company_employee_list(company_id)
    roles = Role.where(company_id: company_id)
    workers = []
    User.where(id: roles.pluck(:user_id).uniq).each do |w|
      workers.push(
        id: w.id,
        email: w.email,
        roles: roles.where(user_id: w.id).pluck(:name)
      )
    end
    workers
  end

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

end

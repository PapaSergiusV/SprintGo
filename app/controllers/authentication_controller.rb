class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])
    if command.success?
      render json: {
        auth_token: command.result,
        id: command.user_data.id,
        first_name: command.user_data.first_name,
        last_name: command.user_data.last_name,
        email: command.user_data.email,
        about: command.user_data.about,
        roles: user_roles(command.user_data)
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def signup; end

  private

  def user_roles(user)
    roles = []
    user.roles.each do |role|
      roles.push(
        id: role.id,
        name: role.name,
        company: Company.find(role.company_id).name
      )
    end
    roles
  end
end

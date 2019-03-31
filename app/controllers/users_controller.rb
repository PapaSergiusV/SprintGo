class UsersController < ApplicationController
  def index
    render json: { users: User.all.select(:id, :email) }
  end
end

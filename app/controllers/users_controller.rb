class UsersController < ApplicationController
  def index
    render json: { users: User.all.select(:id, :email,
                                          :first_name, :last_name) }
  end
end

class UsersController < ApplicationController
  def index
    if user
      user = User.all
      render json: user, status: :ok
    else
      render json: {error: 'Users not found'}, status: :not_found
    end
  end

  def show
    if user
      user = User.find(id: params[:id])
      render json: user, status: :ok
    else
      render json: {error: 'User not found'}, status: :not_found
    end

  end

  def create
    if user
    user = User.create(
      username: params[:username],
      password: params[:password],
      gender: params[:gender]
    )
    render json: user, status: :created
    else
      render json: {error: 'User Create failed'}, status: :unprocessable_entity
    end
  end

  def destroy
    if user
      user = User.find(id: params[:id])
      user.destroy
      head :no_content
    else
      render json: {error: 'Cannot delete this user'}, status: :not_found
    end
  end

  def update
    if user
      user = User.find(id: params[:id])
      user.update(
        password: params[:password],
        gender: params[:gender]
      )
      render json: user, status: :accepted
    else
      render json: {error: 'Failed to update'}, status: :not_found
    end
  end
end

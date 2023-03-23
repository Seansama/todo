class UsersController < ApplicationController
  def index
    user = User.all
    if user
      render json: user, status: :ok
    else
      render json: {error: 'Users not found'}, status: :not_found
    end
  end

  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user, status: :ok
    else
      render json: {error: 'User not found'}, status: :not_found
    end

  end

  def create
    user = User.create(
      username: params[:username],
      password: params[:password_digest],
      gender: params[:gender]
    )
    if user.valid?
    render json: user, status: :created
    else
      render json: {error: user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(id: params[:id])
    user.destroy
    if user
      head :no_content
    else
      render json: {error: 'Cannot delete this user'}, status: :not_found
    end
  end

  def update
    user = User.find(id: params[:id])
    user.update(
      password: params[:password_digest],
      gender: params[:gender]
    )
    if user
      render json: user, status: :accepted
    else
      render json: {error: 'Failed to update'}, status: :not_found
    end
  end

  def login
    user = User.find_by(email:params[:email])

    # validate that the user exists
    if user && user.authenticate(params[:password_digest])
      token = encode_token({id: user.id})
      render json: { user: user, token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password'}, status: :unprocessable_entity
    end
  end

end

class ApplicationController < ActionController::API

  def encode_token(payload)
    JWT.encode(payload, "secret")
  end

  def decode_token
    auth_header = request.headers['Authorization']
    if auth_header
      token = auth_header.split('')[1]
      begin
        JWT.decode(token, 'secret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def authorised_user
    decoded_token = decode_token()
    if decoded_token
      user_id = decoded_token[0]['id']
      user = User.find_by(id: user_id)
    else
      render json: {error: 'User not found'}, status: :not_found
    end
  end

  def authorize
    unless authorised_user
      render json: {error: 'Unauthorized access.'}, status: :unauthorized
    end
  end
end

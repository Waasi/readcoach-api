class SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token
  skip_before_action :authenticate_user!
  skip_before_action :after_database_authenticated, only: [:create]
  skip_before_action :authenticate

  def create
    user = User.find_by(email: sign_in_params[:email])

    if user && user.valid_password?(sign_in_params[:password])
      sign_in('user', user)
      user.token = Devise.friendly_token[0,20]
      user.save
      render json: user, status: :created
    else
      render json: { error: 'Invalid email/password combination' },
        status: :unauthorized
    end
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def sign_in_params
    params.require(:session).permit(:email, :password)
  end
end

class RegistrationsController < Devise::RegistrationsController
  skip_before_filter  :verify_authenticity_token
  before_filter :cors

  def create
    build_resource(sign_up_params)
    if resource.valid?
      sign_up(resource_name, resource)
      resource.token = Devise.friendly_token[0,20]
      resource.save
      render json: resource, status: :created
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: resource.errors
    end
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :language)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :age, :language)
  end

  def cors
    response.headers.merge! 'Access-Control-Allow-Origin' => '*', 'Access-Control-Allow-Methods' => 'POST, PUT, GET, DELETE', 'Access-Control-Allow-Headers' => 'Origin, Accept, Content-Type'
  end
end

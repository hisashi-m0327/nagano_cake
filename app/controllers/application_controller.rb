class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_orders_path
    when Customer
      public_customers_path
    else
      root_path
    end
  end

  def after_sign_up_path_for(resource)
    case resource
    when Customer
      customer_path(resource)
    else
      root_path
    end
  end
  
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :postal_code,
      :address,
      :telephone_number
    ])

    devise_parameter_sanitizer.permit(:account_update, keys: [
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :postal_code,
      :address,
      :telephone_number
    ])
  end
end

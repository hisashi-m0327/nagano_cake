# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]


  private

  def customer_state
    customer = Customer.find_by(email: params[:customer][:email])

    return if customer.nil?

    return unless customer.valid_password?(params[:customer][:password])

    if customer.is_active == false
      flash[:alert] = "退会済みのアカウントです。新規登録をお願いします。"
      redirect_to new_customer_registration_path
    end
  end
end


# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  add_breadcrumb '> ホーム', :root_path
  # GET /resource/password/new
  def new
    add_breadcrumb 'パスワードリセット', new_user_password_path
    super
  end

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    set_flash_message! :notice, :send_instructions
    respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  protected

  def after_resetting_password_path_for(resource)
    root_path
  end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end

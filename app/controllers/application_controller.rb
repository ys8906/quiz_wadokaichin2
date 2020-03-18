class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :store_action

  ## エラー表示
  # 参考文献：https://qiita.com/zeppekipanda/items/fb1ea251197003deec12
  rescue_from StandardError, with: :render_500
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    @quiz = QuizWadokaichin.last
    render "errors/404", status: 404
  end

  def render_500
    if exception
      logger.info "Rendering 500 with exception: #{exception.message}  #{$@}"
      notify_slack(500, exception)
    end
    render "errors/500", status: 500, layout: false
  end

  # Devise
  def store_action
    return unless request.get? 
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      store_location_for(:user, request.fullpath)
    end
  end

  protected
    def configure_permitted_parameters
      user_attrs = [ :email, :name, :password, :password_confirmation ]
      devise_parameter_sanitizer.permit :sign_up, keys: user_attrs
      devise_parameter_sanitizer.permit :account_update, keys: user_attrs
      devise_parameter_sanitizer.permit :sign_in, keys: user_attrs
    end
end

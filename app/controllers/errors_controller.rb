class ErrorsController < ApplicationController
  require 'slack-notifier'

  ## 参考文献
  # https://qiita.com/jnchito/items/a6046733dd5683ff35b7
  # https://qiita.com/mr-myself/items/c2f4fb2e5dcee6a336f3#comment-23298b703d75b7d27487
  # https://qiita.com/upinetree/items/273ae574f1c021d24c37
  
  rescue_from StandardError, with: :render_500
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  # initializeは使えなかったため、別メソッドを毎回呼び出す形を取る
  def notify_slack(status, exception)
    notifier = Slack::Notifier.new(Rails.application.credentials.slack[:webhook_url])
    notifier.ping "#{Time.now}: #{status} with exception: #{exception.message}"
  end

  def show
    raise request.env["action_dispatch.exception"]
  end
  
  def render_404(exception = nil)
    render "errors/404", status: 404
  end

  def render_500(exception = nil)
    if exception
      logger.info "Rendering 500 with exception: #{exception.message}  #{$@}"
      notify_slack(500, exception)
    end
    render "errors/500", status: 500
  end

end

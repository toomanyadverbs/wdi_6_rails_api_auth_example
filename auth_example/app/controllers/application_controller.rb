class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :vertify_authenticity_token, if: :json_request?
  force_ssl if: :ssl_configued?

  protected

  def ssl_configured?
    !Rails.env.devleopment?

  end

  def json_request?
    #use if more than json returned:
    #request.format.json?
    request.format = :json
  end
end

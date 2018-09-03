class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def health_check
    render plain: 'Dogfood producer ok'
  end
end

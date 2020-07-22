class DeployController < ActionController::Base
  def index
    render json: ENV['DEPLOY']
  end
end

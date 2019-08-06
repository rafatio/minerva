class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @payments = Payment.all
  end
end

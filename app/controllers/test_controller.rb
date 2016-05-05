class TestController < ApplicationController
  def index
  end
  def invitation
    @team = Team.find(params[:team])
    if current_user!=nil
      redirect_to :root
    end
  end
end

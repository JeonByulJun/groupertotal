class TestController < ApplicationController
  def index
  end
  def invitation
    @team = Team.find(params[:team])
    if !@team.users.include?(current_user)
      redirect_to :root
    end
    if current_user!=nil
      redirect_to :root
    end
  end
end

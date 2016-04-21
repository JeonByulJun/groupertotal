class TeamController < ApplicationController
  before_action :authenticate_user!

  def index
    @team = current_user.teams
    @user = User.all
    if !current_user.teams.first
      redirect_to "/team/newteam"
    end
    
  end
  def create
    team = Team.new(:teamname => params[:teamname])
    team.users << current_user
    team.users << User.where(:id => params[:user_ids])
    @mail=NoticeMailer.invitation(current_user).deliver
    if team.save
      redirect_to :root
    end
  end
  def newteam
    @team = current_user.teams
    @user = User.all
  end
end

class TeamController < ApplicationController
  before_action :authenticate_user!

  def index
    @team = current_user.teams
    @user = User.all
    if !current_user.teams.first
      redirect_to "/team/newteam"
    end
    #@mail=NoticeMailer.invitation(current_user).deliver
    
  end
  def create
    team = Team.new(:teamname => params[:teamname])
    team.users << current_user
    team.users << User.where(:id => params[:user_ids])
    if team.save
      redirect_to :root
    end
  end
  def newteam
    @team = current_user.teams
    @user = User.all
  end
  def addmember
    @team = Team.find(params[:team])
    @user = User.all
  end
  def adding
    @team = Team.find(params[:team])
    @team.users << User.where(:id => params[:user_ids])
    redirect_to :root
  end
  def profile
    @team = current_user.teams
  end
  def profileupdate
    current_user.image=params[:image]
    current_user.save
    redirect_to "/team/profile"
  end
end

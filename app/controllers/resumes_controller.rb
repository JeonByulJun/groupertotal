class ResumesController < ApplicationController
  before_action :authenticate_user!

   def index
      @resumes = Resume.where(:team_id => params[:team])
      @resumenew = Resume.new
      @team = Team.find(params[:team])
      custom_user_authentication_show(@team)
      @chats = current_user.chats.where(:team => params[:team])

   end

   def new
      @resume = Resume.new
   end

   def create
      @resume = Resume.new(resume_params)
      @team = Team.find(params[:resume][:team_id])

      @resume.name="noname"
      if custom_user_authentication_else(@team) && @resume.save
         redirect_to action: 'index', team: params[:resume][:team_id]
      else
         redirect_to action: 'index', team: params[:resume][:team_id]
      end

   end

   def destroy
      @resume = Resume.find(params[:id])
      team = @resume.team_id
      @resume.destroy
      redirect_to action: 'index', team: team#, notice:  "#{@resume.attachment.file.filename} 가 삭제 되었습니다."
   end

   private
      def resume_params
          params.require(:resume).permit(:name, :attachment, :team_id)

      end

end

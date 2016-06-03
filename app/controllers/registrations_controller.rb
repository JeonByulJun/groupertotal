class RegistrationsController < Devise::RegistrationsController
  def new
    @email=params[:email]
    @auth=params[:auth]


    if @email.hash == @auth.to_i
      super
    else
      redirect_to '/test/authfail?email='+@email
    end
  end

  def create
    if params[:user][:password] == params[:user][:password_confirmation] && params[:user][:password].length >= 8
      super
    elsif params[:user][:password] != params[:user][:password_confirmation] && params[:user][:password].length < 8
      flash[:notice] ="password는 8자 이상이여야 되고, 비밀번호 확인이 다릅니다"
      redirect_to action: 'new', email: params[:user][:email], auth: params[:user][:auth]
    elsif params[:user][:password] != params[:user][:password_confirmation]
      flash[:notice] ="비밀번호 확인이 다릅니다"
      redirect_to action: 'new', email: params[:user][:email], auth: params[:user][:auth]
    elsif params[:user][:password].length < 8
      flash[:notice] ="password는 8자 이상이여야 됩니다"
      redirect_to action: 'new', email: params[:user][:email], auth: params[:user][:auth]
    end
  end

  def update
    super
  end
end
#Rails.application.routes.draw do
#  devise_for :users, controllers: {
#    sessions: 'users/sessions'
#  }
#end

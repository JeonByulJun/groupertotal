class RegistrationsController < Devise::RegistrationsController
  def new
    @email=params[:email]
    @auth=params[:auth]


    if @email.hash == @auth.to_i
      super
    else
      redirect_to '/test/authfail'
    end
  end

  def create
    if
      super
    else
      redirect_to :root
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

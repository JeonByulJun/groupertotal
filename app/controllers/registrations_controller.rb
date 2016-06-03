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
    super
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

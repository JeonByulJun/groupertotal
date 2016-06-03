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
    super
  end

  def update
    super
  end
end
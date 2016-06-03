class RegistrationsController < Devise::RegistrationsController
  def new
    @email=params[:email]
    @auth=params[:auth]


    if true
      super
    else
      redirect_to :root
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

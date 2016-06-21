class SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    user = User.find_by_email(params[:user][:email])
    if user == nil
      flash[:notice] = "존재하지 않는 아이디 입니다"
      puts "test"
      redirect_to action: 'new'
    elsif !user.valid_password?(params[:user][:password])
      flash[:notice] = "비밀번호가 틀렸습니다"
      puts "test"

      redirect_to action: 'new'

    else
      super

    end

  end

  def destroy
    super
  end

end

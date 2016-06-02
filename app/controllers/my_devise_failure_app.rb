class MyDeviseFailureApp < Devise::FailureApp
  def respond
    params[:failure_reason] = warden_message
    if http_auth?
      http_auth
    elsif warden_options[:recall]
      recall
    else
      redirect
    end
  end

  def redirect
    store_location!
    if flash[:timedout] && flash[:alert]
      flash.keep(:timedout)
      flash.keep(:alert)
    else
      flash[:alert] = i18n_message
    end
      redirect_to "/test/index"
  end
end 
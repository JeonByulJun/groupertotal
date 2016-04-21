class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.invitation.subject
  #
  def invitation(user)
    @user=user
    mail(to: user.email,
    subject: 'Happy')
  end
end

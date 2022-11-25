class UserMailer < ApplicationMailer

  def welcome_email
    @user = params[:user]
    @doctor = params[:doctor]
    @meeting = params[:meeting]
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
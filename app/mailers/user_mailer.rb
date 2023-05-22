class UserMailer < ApplicationMailer
    default from: 'sayam.bar@bitcanny.com'
    def welcome_email
        @user = params[:user]
        mail(to: @user.email, subject: 'Welcome to Instagram Clone!!')
    end
end

# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'info@getdistilled.io'

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def verify_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Distilled')
  end
end

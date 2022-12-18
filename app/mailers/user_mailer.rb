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
    @token = params[:token]
    mail(to: @user.email, subject: 'Welcome to Distilled')
  end

  def invite_to_workspace
    @user = params[:user]
    @workspace = params[:workspace]
    @added_by = params[:added_by]
    mail(to: @user.email,
         subject: "You have been invited to join #{@workspace.title} by #{@added_by.name.split(' ')[0]}")
  end
end

# frozen_string_literal: true

class GoogleAuthController < ApplicationController
  def auth
    code = params['code']
    res = get_token(code)
    info = get_user_info(res)
    session_token = get_session_token(info)
    redirect_to("#{Rails.configuration.web_app_url}/oauth-gmail?session_token=#{session_token}", allow_other_host: true)
  end

  private

  def get_token(code)
    HTTParty.post('https://oauth2.googleapis.com/token', body: {
      code:,
      client_id: Rails.application.credentials.config[:google_client_id],
      client_secret: Rails.application.credentials.config[:google_client_secret],
      grant_type: 'authorization_code',
      redirect_uri: "#{Rails.configuration.web_api_url}/oauth-google"
    }.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def get_user_info(res)
    HTTParty.get('https://www.googleapis.com/oauth2/v2/userinfo', query: {}, headers: {
                   Authorization: "Bearer #{res['access_token']}"
                 })
  end

  def get_session_token(info)
    user = get_user(info)
    user_session = UserSession.generate_user_session(user:, login_type: 'google')
    user_session.session_id
  endjw

  def get_user(info)
    email = info['email']
    user = User.find_by(email:)
    if user.present?
      user.update!(profile_pic: info['picture'], email_verified: true, invite_status: 'joined')
      user
    else
      User.signup_google(email: info['email'], name: info['name'])
    end
  end
end

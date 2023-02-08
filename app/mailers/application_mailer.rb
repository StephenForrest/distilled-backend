# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'hello@getdistilled.io'
  layout 'mailer'
end

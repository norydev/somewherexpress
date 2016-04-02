class ApplicationMailer < ActionMailer::Base
  default from: "info@somewherexpress.com"
  layout 'mailer'

  add_template_helper(ApplicationHelper)
end

class ApplicationMailer < ActionMailer::Base
  default from: "SomewherExpress <info@somewherexpress.com>"
  layout 'mailer'

  add_template_helper(ApplicationHelper)
end

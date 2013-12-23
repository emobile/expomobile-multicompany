class AttendeeMailer < ActionMailer::Base
  default :from => "no-reply@expomobile.com.mx"
  require "erb"
  
  def send_attendee_id(attendee, attendee_id)
    @attendee = attendee
    @attendee_id = attendee_id
    mail(:to => @attendee.a_email, :subject => t('atten.mail.attendee_id_subject', @attendee_id))
  end

  def send_nip(attendee, nip)
    @attendee = attendee
    @nip = nip.nip
    mail(:to => attendee.a_email, :subject => t('atten.mail.nip_subject', @nip))
  end
  
  def invitation_email(attendee)
    @attendee = attendee
    mail(:to => attendee.a_email, :subject => "#{t("mail_template.invitation").mb_chars.upcase}: #{@attendee.a_name}",  :content_type => "text/html", :body => ERB.new(MailTemplate.find_by_name("invitation_template").content.gsub("&lt;%=", "<%=").gsub("%&gt;", "%>")).result(binding).html_safe)
  end  
  
  def welcome_email(attendee)
    @attendee = attendee
    mail(:to => attendee.a_email, :subject => "#{t("mail_template.welcome").mb_chars.upcase}: #{@attendee.a_name}",  :content_type => "text/html", :body => ERB.new(MailTemplate.find_by_name("welcome_template").content.gsub("&lt;%=", "<%=").gsub("%&gt;", "%>")).result(binding).html_safe)
  end
  
  def acknowledgment_email(attendee)
    @attendee = attendee
    mail(:to => attendee.a_email, :subject => "#{t("mail_template.acknowldgement").mb_chars.upcase}: #{@attendee.a_name}",  :content_type => "text/html", :body => ERB.new(MailTemplate.find_by_name("acknowledgment_template").content.gsub("&lt;%=", "<%=").gsub("%&gt;", "%>")).result(binding).html_safe)
  end
  
  def general_email(attendee)
    @attendee = attendee
    mail(:to => attendee.a_email, :subject => "#{t("mail_template.general").mb_chars.upcase}: #{@attendee.a_name}",  :content_type => "text/html", :body => ERB.new(MailTemplate.find_by_name("general_template").content.gsub("&lt;%=", "<%=").gsub("%&gt;", "%>")).result(binding).html_safe)
  end

end
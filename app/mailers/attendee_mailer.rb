class AttendeeMailer < ActionMailer::Base
  default :from => "no-reply@expomobile.com.mx"
  
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
  
  def welcome_email(attendee)
    @attendee = attendee
    mail(:to => attendee.a_email, :subject => "#{t(:welcome).upcase}: #{@attendee.a_name}")
  end

end
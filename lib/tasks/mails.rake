namespace :mails do
  task :welcome_email, :event_id do |t, args|
    @event = Event.find_by_id(args[:event_id])
    #output = File.open "mail-output.txt", "w"
    #output.puts(Date.today.to_s)
    @event.attendees.each do |attendee|
      #output.puts(@attendee.id)
      if attendee.a_email =~ /\A[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})\z/
        AttendeeMailer.welcome_email(attendee).deliver!
      end
      #output.puts("----------------------------")
      #output.close
    end
  end

  task :acknowledgment_email, :event_id do |t, args|
    @event = Event.find_by_id(args[:event_id])
    #output = File.open "mail-output.txt", "w"
    #output.puts(Date.today.to_s)
    @event.attendees.each do |attendee|
      #output.puts(@attendee.id)
      if attendee.a_email =~ /\A[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})\z/
        AttendeeMailer.acknowledgment_email(attendee).deliver!
      end
      #output.puts("----------------------------")
      #output.close
    end
  end
  
  task :invitation_email, :event_id do |t, args|
    @event = Event.find_by_id(args[:event_id])
    #output = File.open "mail-output.txt", "w"
    #output.puts(Date.today.to_s)
    @event.attendees.each do |attendee|
      #output.puts(@attendee.id)
      attendee = Attendee.find_by_id(1)
      if attendee.a_email =~ /\A[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})\z/
        AttendeeMailer.invitation_email(attendee).deliver!
      end
      #output.puts("----------------------------")
      #output.close
    end
  end
  
  task :general_email, :event_id do |t, args|
    @event = Event.find_by_id(args[:event_id])
    #output = File.open "mail-output.txt", "w"
    #output.puts(Date.today.to_s)
    @event.attendees.each do |attendee|
      #output.puts(@attendee.id)
      attendee = Attendee.find_by_id(1)
      if attendee.a_email =~ /\A[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})\z/
        AttendeeMailer.general_email(attendee).deliver!
      end
      #output.puts("----------------------------")
      #output.close
    end
  end

end
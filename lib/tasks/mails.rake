namespace :mails do
  task :send, [:event_id] => :environment do |t, args|
    @event = Event.find_by_id(args["event_id"])
    #    output = File.open "mail-output.txt", "a"
    #    output.puts(Date.today.to_s)
    @event.attendees.each do |attendee|
      #      output.puts(@attendee.id)
      AttendeeMailer.welcome_email(attendee).deliver!
      if attendee.a_email =~ /\A[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})\z/
      end
      #      output.puts("----------------------------")
      #      output.close
    end
  end
end
$(function() {
   $("#select_event_form").submit(function() {
      return $("#event_id").val() != "";
   });
});
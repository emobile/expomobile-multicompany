$(function() {
    $('input.datetimeRange').datetimeEntry({
        beforeShow: datetimeRange,
        spinnerImage: '/assets/spinnerUpDown.png',
        spinnerSize: [15, 16, 0],
        spinnerBigSize: [30, 32, 0],
        spinnerIncDecOnly: true,
        datetimeFormat: 'D/O/Y H:Ma'
    });

    function datetimeRange(input) {
        return {minDatetime: (input.id == 'face_to_face_end_date' ?
                    $('#face_to_face_start_date').datetimeEntry('getDatetime') : null),
            maxDatetime: (input.id == 'dtFrom' ?
                    $('#face_to_face_end_date').datetimeEntry('getDatetime') : null)};
    }

    $.getJSON(
            "/attendees/get_all_attendee_names",
            function(data) {
                var accentMap = {
                    "Á": "A",
                    "Ä": "A",
                    "á": "a",
                    "ä": "a",
                    "É": "E",
                    "Ë": "E",
                    "é": "e",
                    "ë": "e",
                    "Í": "I",
                    "Ï": "I",
                    "í": "i",
                    "ï": "i",
                    "Ó": "O",
                    "Ö": "O",
                    "ó": "o",
                    "ö": "o",
                    "Ú": "U",
                    "Ü": "U",
                    "ú": "u",
                    "ü": "u"
                };

                var normalize = function(term) {
                    var ret = "";
                    for (var i = 0; i < term.length; i++) {
                        ret += accentMap[ term.charAt(i) ] || term.charAt(i);
                    }
                    return ret;
                };

                $("#app_name").autocomplete({
                    source: function(request, response) {
                        var matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i");
                        response($.grep(data, function(value) {
                            value = value.label || value.value || value;
                            return matcher.test(value) || matcher.test(normalize(value));
                        }));
                    },
                    minLength: 2,
                    autoFocus: true,
                    select: function(e, ui) {
                        $.getJSON(
                                "/attendees/get_attendee_by_name",
                                {a_name: ui.item.value},
                        function(json) {
                            if (json) {
                                $("#app_attendee_id").val(json.attendee_id);
                                $("#app_enterprise").val(json.e_name);
                                $("#app_email").val(json.a_email);
                                $("#app_phone").val(json.e_phone);
                                $("#face_to_face_attendee_id").val(json.id);
                            }
                            else {
                                $("#app_attendee_id").val("");
                                $("#app_enterprise").val("");
                                $("#app_email").val("");
                                $("#app_phone").val("");
                                $("#face_to_face_attendee_id").val("");
                            }
                        });
                    },
                    messages: {}
                });
            }
    );

    $("#face_to_face_int_name").change(function() {
        $.getJSON(
                "/face_to_faces/get_interviewee",
                {name: $(this).val()},
        function(json) {
            if (json) {
                $("#face_to_face_int_contact").val(json.contact);
                $("#face_to_face_int_job").val(json.job);
            }
            else {
                $("#face_to_face_int_contact").val("");
                $("#face_to_face_int_job").val("");
            }
        });
    });
});
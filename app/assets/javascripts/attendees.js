$(function() {
    $("#other_platform").on("change", function() {
        if ($(this).prop("checked")) {
            $("input#attendee_a_platform").css({visibility: "visible"});
        }
        else {
            $("input#attendee_a_platform").css({visibility: "hidden"});
        }
    });

    $("#other_market").on("change", function() {
        if ($(this).prop("checked")) {
            $("input#attendee_a_market_segment").css({visibility: "visible"});
        }
        else {
            $("input#attendee_a_market_segment").css({visibility: "hidden"});
        }
    });

    $.getJSON(
            "attendees/get_all_attendee_names",
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

                $("#search_field").autocomplete({
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
                        $(this).val(ui.item.value);
                        $("#search_form").submit();
                    },
                    messages: {}
                });
            }
    );

    $(".field_with_errors").children("select, textarea, input:not(.other)").css({border: "3px solid #ffb7b7"});
    $(".field_with_errors").children("input[type='checkbox'], input[type='radio']").css({outline: "3px solid #ffb7b7"});
    $(".field_with_errors").each(function() {
        $(this).after($(this).html());
    });
    $(".field_with_errors").remove();
});
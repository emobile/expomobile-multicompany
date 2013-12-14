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
        return {minDatetime: (input.id == 'end_date' ?
                    $('#start_date').datetimeEntry('getDatetime') : null),
            maxDatetime: (input.id == 'dtFrom' ?
                    $('#end_date').datetimeEntry('getDatetime') : null)};
    }

    $("td.schedule").on("click", function() {
        var schedule_id, workshop_id, subgroup_id, hour_id, i;

        workshop_id = $(this).children(".workshop_id").val();
        subgroup_id = $(this).children(".subgroup_id").val();
        hour_id = $(this).children(".hour_id").val();
        schedule_id = $(this).children(".schedule_id").val();
        i = $(this).children(".view_index").val();

        $("#form" + i + " #workshop_id").val(workshop_id);
        $("#form" + i + " #subgroup_id").val(subgroup_id);
        $("#form" + i + " #hour_id").val(hour_id);
        $("#form" + i + " #schedule_id").val(schedule_id);
        $("#form-delete" + i + " #schedule_id_delete").val(schedule_id);

        if ($(this).hasClass("td-selected")) {
            $(this).removeClass("td-selected");
            $("#form" + i + " #schedule_id").val("");
            $("#form-delete" + i + " #schedule_id_delete").val("");
        }
        else {
            $(".td-selected").removeClass("td-selected");
            $(this).addClass("td-selected");
        }
    });

});
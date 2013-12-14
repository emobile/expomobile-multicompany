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
        return {minDatetime: (input.id == 'event_end_date' ?
                    $('#event_start_date').datetimeEntry('getDatetime') : null),
            maxDatetime: (input.id == 'dtFrom' ?
                    $('#event_end_date').datetimeEntry('getDatetime') : null)};
    }
});
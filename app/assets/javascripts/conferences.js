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
        return {minDatetime: (input.id == 'conference_end_date' ?
                    $('#conference_start_date').datetimeEntry('getDatetime') : null),
            maxDatetime: (input.id == 'dtFrom' ?
                    $('#conference_end_date').datetimeEntry('getDatetime') : null)};
    }
});
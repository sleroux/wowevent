class exports.DateUtils
  minuteVals :
    1: '00'
    2: '15'
    3: '30'
    4: '45'  
    
  ampmVals: 
    1: 'AM'
    2: 'PM'
    
  weekdays:
    0: 'Sunday'
    1: 'Monday'
    2: 'Tuesday'
    3: 'Wednesday'
    4: 'Thursday'
    5: 'Friday'
    6: 'Saturday'
    
  months:
    0: 'January'
    1: 'Feburary'
    2: 'March'
    3: 'April'
    4: 'May'
    5: 'June'
    6: 'July'
    7: 'August'
    8: 'September'
    9: 'October'
    10: 'November'
    11: 'Decemeber'
  
  parseDate: (date, hour, minute, ampm) ->
    dateObj = new Date(date)
    hour + ":" + @minuteVals[minute] + " " + @ampmVals[ampm] + " on " + @weekdays[dateObj.getDay()] + ', ' + @months[dateObj.getMonth()] + " " + dateObj.getDate() + ", " + dateObj.getFullYear()
    
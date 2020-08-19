const searchClassFunction = require('./searcher').searchAndOpenClass
var schedule = require('node-schedule')
const moment = require('moment')

const classes = require('./data.json').classes;

function setSchedulerForClasses()
{
    for (var aClass of classes)
    {
        console.log('-----------------------------------')
        console.log(aClass.name)
        days = []
        // Get all the days
        for (var day of aClass.days)
        {
            days.push(parseInt(moment(day, 'dddd').format('d')))
        }
        console.log('Days: ' + aClass.days)
        // Get the time
        const classTime = moment(aClass.time, "hh:mm A").subtract(2, 'minutes')
        console.log('Class is at: ' + classTime.add(2, 'minutes').format('hh:mm A'))

        // Set the schedule
        var rule = new schedule.RecurrenceRule();
        rule.dayOfWeek = days
        rule.hour = parseInt(classTime.format('HH'))
        rule.minute = parseInt(classTime.format('mm'))

        var job = schedule.scheduleJob(rule, searchClassFunction)
    }

    console.log('\nScheduling Done!\n')
}

setSchedulerForClasses()
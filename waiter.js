const searchClassFunction = require('./searcher').searchAndOpenClass
// var schedule = require('node-schedule')
var CronJob = require('cron').CronJob;
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
        console.log('Days: ' + days)
        // Get the time
        const classTime = moment(aClass.time, "hh:mm A")
        console.log('Class is at: ' + classTime.format('hh:mm A'))

        //
        // Set the schedule using node-scheduler
        //
        // var rule = new schedule.RecurrenceRule();
        // rule.dayOfWeek = days
        // rule.hour = parseInt(classTime.format('HH'))
        // rule.minute = parseInt(classTime.subtract(2, 'minutes').format('mm'))
        // var job = schedule.scheduleJob(rule, searchClassFunction)

        //
        // Set the schedule using node-cron
        //
        cronString = classTime.subtract(2, 'minutes').format('mm') + ' '
            + classTime.format('HH') + ' '
            + '* * ' + days
        var job = new CronJob(cronString, searchClassFunction, null, true);
        console.log(job.nextDates().format('llll'))
    }

    // console.log('\nScheduling Done! (using node-scheduler) \n')
    console.log('\nScheduling Done! (using cron) \n')

    searchClassFunction()
}

setSchedulerForClasses()
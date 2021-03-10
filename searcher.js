const moment = require('moment')
const alert = require('alert')
const classes = require('./data.json').classes;
const { execSync, exec } = require('child_process');

const folderURL = "Documents/College Documents/Eighth Semester/"

function printTime(toPrint) {
    console.log(toPrint)
}

function openClass(theClass) {
    console.log('Time for ' + theClass.name)
    if (theClass.openFolder)
        execSync('cd;open "' + folderURL + theClass.code +'"')
    if (theClass.link)
        execSync('open -a /Applications/zoom.us.app ' + theClass.link)
    if (theClass.cmd)
        execSync(theClass.cmd)
    // show an alert
    alert('Time for ' + theClass.name)
}

function searchAndOpenClass()
{
    const currentTime = moment()
    console.log(currentTime.format('[It is] hh:mm A [on] dddd, Do MMMM'))

    let classOpened = false
    // Go through each class
    for (var aClass of classes)
    {
        const classTime = moment(aClass.time, "hh:mm A")
        for (var day of aClass.days)
        {
            if (currentTime.format('dddd') == day)
            {
                // it is the right day, so check time
                timeDifference = currentTime.diff(classTime, 'minutes')
                if ((timeDifference < 0 && timeDifference >= -10) || (timeDifference >= 0 && timeDifference <= aClass.durationMinutes))
                {
                    openClass(aClass)
                    return true
                }
            }
        }
    }
    return false
}

module.exports.searchAndOpenClass = searchAndOpenClass

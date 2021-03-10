//
//  Utility.swift
//  Zoom Scheduler
//
//  Created by Anuj Parakh on 3/7/21.
//

import Foundation

@discardableResult
func shell(_ args: String) -> String {
    var outstr = ""
    let task = Process()
    task.launchPath = "/bin/sh"
    task.arguments = ["-c", args]
    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    if let output = String(data: data, encoding: .utf8) {
        outstr = output as String
    }
    task.waitUntilExit()
    return outstr
}

enum Weekday: Int
{
    case Monday = 2
    case Tuesday = 3
    case Wednesday = 4
    case Thursday = 5
    case Friday = 6
}

func stringToWeekday(_ dayName: String) -> Weekday
{
    if(dayName == "Monday")
    {
        return Weekday.Monday
    }
    else if(dayName == "Tuesday")
    {
        return Weekday.Tuesday
    }
    else if(dayName == "Wednesday")
    {
        return Weekday.Wednesday
    }
    else if(dayName == "Thursday")
    {
        return Weekday.Thursday
    }
    else
    {
        return Weekday.Friday
    }
}

func checkTodayIsWeekday(_ day: Weekday) -> Bool
{
    
    return day.rawValue == Date().dayNumberOfWeek()

}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

//
//  ClassSchedule.swift
//  Zoom Scheduler
//
//  Created by Anuj Parakh on 3/7/21.
//

import Foundation

class ClassSchedule
{
    var allClasses: [ZoomClass] = []
    
    func getCurrentClass() -> ZoomClass?
    {
        let calendar = Calendar.current

        for aClass in allClasses
        {
            // Check day
            var works = false
            for day in aClass.days
            {
                if checkTodayIsWeekday(day)
                {
                    works = true
                    break
                }
            }
            
            if !works
            {
                continue
            }
            
            // Check time
            let now = Date()
            let startTime = calendar.date(bySettingHour: aClass.timeOfDay.hour!, minute: aClass.timeOfDay.minute!, second: 0, of: now)!
            let leftTime = calendar.date(byAdding: .minute, value: -10, to: startTime)!
            let rightTime = calendar.date(byAdding: .minute, value: aClass.durationMinutes, to: startTime)!
            
            if now >= leftTime && now <= rightTime
            {
                return aClass
            }
            
        }
        
        return nil
    }
    
    func parseAllClasses(_ classesJSON: Any)
    {
        if let classesJSON = classesJSON as? Dictionary<String, AnyObject>, let classes = classesJSON["classes"] as? [Any]
        {
            for aClass in classes
            {
                if let newClass = ZoomClass.parseZoomClass(aClass)
                {
                    allClasses.append(newClass)
                }
            }
        }
        
    }
}

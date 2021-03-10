//
//  Class.swift
//  Zoom Scheduler
//
//  Created by Anuj Parakh on 3/7/21.
//

import Foundation

class ZoomClass
{
    var name: String!
    var codeName: String!
    var days: [Weekday] = []
    var timeOfDay: DateComponents! = DateComponents()
    var durationMinutes: Int!
    var link: String!
    
    func startClass()
    {
        shell("open -a /Applications/zoom.us.app \(link!)")
    }
    
    static func parseZoomClass(_ zoomClassJSON: Any) -> ZoomClass?
    {
        let toReturn: ZoomClass = ZoomClass()
        if let zoomClassJSON = zoomClassJSON as? Dictionary<String, AnyObject>
        {
            if let name = zoomClassJSON["name"] as? String
            {
                toReturn.name = name
            }
            
            if let code = zoomClassJSON["code"] as? String
            {
                toReturn.codeName = code
            }
            
            if let durationMinutes = zoomClassJSON["durationMinutes"] as? Int
            {
                toReturn.durationMinutes = durationMinutes
            }
            
            if let link = zoomClassJSON["link"] as? String
            {
                toReturn.link = link
            }
            
            // Time and days!
            if let time = zoomClassJSON["time"] as? String
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                let date = dateFormatter.date(from: time)
                let calendar = Calendar.current

                toReturn.timeOfDay.hour = calendar.component(.hour, from: date!)
                toReturn.timeOfDay.minute = calendar.component(.minute, from: date!)
                
            }
            
            if let days = zoomClassJSON["days"] as? [Any]
            {
                for day in days
                {
                    if let day = day as? String
                    {
                        toReturn.days.append(stringToWeekday(day))
                    }
                }
            }
            
            return toReturn

        }
        
        return nil
    }
}

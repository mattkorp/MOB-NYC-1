//
//  Weather.swift
//  Weather
//
//  Created by Rudd Taylor on 3/2/15.
//  Copyright (c) 2015 ga. All rights reserved.
//

import Foundation

class Weather {
    var friendlyWeather: NSString?
    
    init(json: NSDictionary) {
        if let weather = json["weather"] as? NSArray {
            if let firstWeather = weather.firstObject as? NSDictionary {
                if let description = firstWeather["description"] as? NSString {
                    self.friendlyWeather = description
                }
            }
        }
    }
    
    class func retrieveWeather(completionHandler: (Weather) -> Void) {
        if let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=nyc,ny") {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url,
                completionHandler: {
                    (data, response, error) -> Void in
                    if let jsonDict = NSJSONSerialization.JSONObjectWithData(data, options: .allZeros, error:nil)  as? NSDictionary {
                        var weather = Weather(json: jsonDict)
                        if let friendlyWeather = weather.friendlyWeather {
                        }
                        dispatch_async(dispatch_get_main_queue(), {
                            completionHandler(weather)
                        })
                    }
            })
            task.resume()
        }
    }
}
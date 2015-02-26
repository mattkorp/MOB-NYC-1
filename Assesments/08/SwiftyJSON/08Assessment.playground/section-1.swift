// Playground - noun: a place where people can play
import Foundation


// Assignment 8 playground

import XCPlayground
import SwiftyJSON

// Let asynchronous code run
XCPSetExecutionShouldContinueIndefinitely()

//TODO one: Write and call a function that make a successful network connection to google.com using core networking APIs, then print out the results.

if let url = NSURL(string: "http:www.google.com") {
    let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error)  in
        var string: String!
        if let error = error {
            if let info = error.userInfo {
            string = info.debugDescription
            }
        } else {
            string = NSString(data: data, encoding: NSUTF8StringEncoding)!
        }
        println(string)
    }
    task.resume()
}

//TODO two: Write and call a function that makes a failing network connection (using core networking APIs) to http://generalassemb.ly/foobar.baz, a nonexistant page. Print out the status code and body of the response.

if let url = NSURL(string: "http://generalassemb.ly/foobar.baz") {
    let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error)  in
        if let error = error {
            if let info = error.userInfo {
                println("code: \(error.code)")
                println("domain: \(error.domain)")
                println("userInfo: \(info)")
                println("localizedDescription: \(error.localizedDescription)")
                println("localizedRecoveryOptions: \(error.localizedRecoveryOptions)")
                println("localizedRecoverySuggestion: \(error.localizedRecoverySuggestion)")
                println("localizedFailureReason: \(error.localizedFailureReason)")
            }
        }
    }
    task.resume()
}

//TODO three: Make a successful network connection to http://api.openweathermap.org/data/2.5/weather?q=New%20York,US, an API that speaks JSON using core networking APIs. Create a model class that corresponds to the JSON response object, populate it with the contents of that JSON using NSJSONSerialization, then print out the model.

struct Coordinates: Printable {
    var lat: Double!
    var lon: Double!
    var description: String {
        return "Coordinates: Latitude: \(lat) Longitude: \(lon)"
    }
}
struct Sys: Printable {
    var sunrise: Int!
    var sunset: Int!
    var description: String {
        return "Sunrise: \(sunrise) Sunset: \(sunset)"
    }
}
struct Desc: Printable {
    var desc: String!
    var description: String {
        return "Description: \(desc)"
    }
}
struct Main: Printable {
    var temp: Double!
    var temp_min: Double!
    var temp_max: Double!
    var pressure: Double!
    var humidity: Int!
    var description: String {
        return "Temperature: \(temp) Min: \(temp_min) Max \(temp_max) Pressure: \(pressure) Humidity: \(humidity)"
    }
}
struct Wind: Printable {
    var speed: Double!
    var deg: Double!
    var description: String {
        return "Wind: Speed: \(speed) Degree: \(deg)"
    }
}
struct Clouds: Printable {
    var clouds: Int!
    var description: String {
        return "Clouds: \(clouds)"
    }
}

class Weather {
    
    let coordinates: Coordinates?
    let sys: Sys?
    let weather: Desc?
    let main: Main?
    let wind: Wind?
    let clouds: Clouds?
    
    
    init(coordinates: Coordinates,sys: Sys, weather: Desc, main: Main, wind: Wind, clouds: Clouds) {
        self.coordinates = coordinates
        self.sys = sys
        self.weather = weather
        self.main = main
        self.wind = wind
        self.clouds = clouds
    }
    
    func description() {
        println(self.coordinates!.description)
        println(self.sys!.description)
        println(self.weather!.description)
        println(self.main!.description)
        println(self.wind!.description)
        println(self.clouds!.description)
    }
    
}

if let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=New%20York,US") {
    let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
        if let error = error {
            println(error)
        } else {
            var c: Coordinates!
            var s: Sys!
            var d: Desc!
            var m: Main!
            var w: Wind!
            var cov: Clouds!
            var jsonError: NSError?
            if let json: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) {
                if let coordinates = json["coord"] as NSDictionary! {
                    if let lat = coordinates["lat"] as Double! {
                        if let lon = coordinates["lon"] as Double! {
                            c = Coordinates(lat: lat, lon: lon)
                        }
                    }
                }
                if let sys = json["sys"] as NSDictionary! {
                    if let sunrise = sys["sunrise"] as Int! {
                        if let sunset = sys["sunset"] as Int! {
                            s = Sys(sunrise: sunrise, sunset: sunset)
                        }
                    }
                }
                if let weather = json["weather"] as NSArray! {
                    if let desc = weather[0]["description"] as String! {
                        d = Desc(desc: desc)
                        
                    }
                }
                if let main = json["main"] as NSDictionary! {
                    if let temp = main["temp"] as Double! {
                        if let min = main["temp_min"] as Double! {
                            if let max = main["temp_max"] as Double! {
                                if let pressure = main["pressure"] as Double! {
                                    
                                    if let humidity = main["humidity"] as Int! {
                                        m = Main(temp: temp, temp_min: min, temp_max: max, pressure: pressure, humidity: humidity)
                                    }
                                }
                            }
                        }
                    }
                }
                if let wind = json["wind"] as NSDictionary! {
                    if let speed = wind["speed"] as Double! {
                        if let deg = wind["deg"] as Double! {
                            w = Wind(speed: speed, deg: deg)
                        }
                    }
                }
                if let clouds = json["clouds"] as NSDictionary! {
                    if let cloud = clouds["all"] as Int! {
                        cov = Clouds(clouds: cloud)
                    }
                }
                let weather = Weather(coordinates: c, sys: s, weather: d, main: m, wind: w, clouds: cov)
                weather.description()
            }
        }
    }
    task.resume()
}

//TODO four: Make a successful network connection to http://api.openweathermap.org/data/2.5/weather?q=New%20York,US, an API that speaks JSON. Populate a your above-defined model with the contents of that JSON using SwiftyJSON, then print out the model.
var c: Coordinates!
var s: Sys!
var d: Desc!
var m: Main!
var w: Wind!
var cov: Clouds!

if let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=New%20York,US") {
    let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
        if let error = error {
            println(error)
        } else {
            let json = JSON(data: data)
            c = Coordinates(lat: json["coord"]["lat"].double, lon: json["coord"]["lon"].double)
            s = Sys(sunrise: json["sys"]["sunrise"].int, sunset: json["sys"]["sunset"].int)
            d = Desc(desc: json["weather"][0]["description"].string)
            let main = json["main"]
            m = Main(temp: main["temp"].double, temp_min: main["min"].double, temp_max: main["max"].double, pressure: main["pressure"].double, humidity: main["humidity"].int)
            w = Wind(speed: json["wind"]["speed"].double, deg: json["wind"]["deg"].double)
            cov = Clouds(clouds: json["clouds"]["all"].int)

            let weather = Weather(coordinates: c, sys: s, weather: d, main: m, wind: w, clouds: cov)
            weather.description()
        }
    }
    task.resume()
}









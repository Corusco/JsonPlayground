//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let dict = ["this": "that"]

let dict2 = ["another thing": "and another"]

let play = ["this one": ["that one": "or another"]]

let multiDict: Dictionary<String, String> = ["this":"that", "another":"and another"]

let someString = "{\"this\": [\"that\", \"another\"]}"

let array = [dict, dict2]

func encodeJSON(thing: AnyObject?) -> NSData? {
    do {
        guard let thing = thing else {
            return nil
        }
        
        return try NSJSONSerialization.dataWithJSONObject(thing, options: [])
    } catch {
        return nil
    }
}

func parseJSON(data: NSData?) -> [String: AnyObject]? {
    do {
        if let data = data,
            json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: AnyObject] {
                return json
        }
    } catch {
        print ("couldn't parse JSON")
    }
    
    return nil
}

func encodeJSONString(thing: AnyObject, prettyPrinted:Bool = false) -> String {
    
    let options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : NSJSONWritingOptions(rawValue:0)
    
    do {
        let data = try NSJSONSerialization.dataWithJSONObject(thing, options: options)
        if let dataString = String(data: data, encoding: NSUTF8StringEncoding) {
            return dataString as String
        }
    } catch {
        print("error")
    }
    
    return ""
}

let encodedDict = encodeJSON(multiDict)

var request = NSMutableURLRequest(URL: NSURL(string: "www.google.com")!)
var session = NSURLSession.sharedSession()

request.HTTPMethod = "POST"

var error: NSURLError?
request.HTTPBody = encodedDict
request.addValue("application/json", forHTTPHeaderField: "Content-Type")

var string = String(data: encodedDict!, encoding: NSUTF8StringEncoding)
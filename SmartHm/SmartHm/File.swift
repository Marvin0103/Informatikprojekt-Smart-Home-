//
//  File.swift
//  SmartHm
//
//  Created by Marvin Herhaus on 08.02.21.
//


import Foundation

let jsonString =
"""
{
    "name": "Bob",
    "age": 25
}
"""
let data = jsonString.data(using: .utf8)!

let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
print(dictionary["name"])

let serializedData = try JSONSerialization.data(withJSONObject: dictionary, options: [])


//struct File: Codable{
//
//    var state = "ON"
//    var brightness = 100
//}


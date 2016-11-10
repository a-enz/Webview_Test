//
//  NervousnetRemote.swift
//  Webview_Test
//
//  Created by Enz  Andreas on 03.11.16.
//  Copyright © 2016 COSS. All rights reserved.
//

import Foundation

protocol NervousnetRemote {
    //static func getLatestReading(sensorType: Double) -> SensorReading
    
    static func getReading(sensorType: Double) -> SensorReading //todo: make using callback
    //async call is not easy because in the server GET methods the calls are blocking. Need to change
    //swifter to be able to do this async (check out MethodRoute in HttpServer)
    
    static func getReadings(sensorType: Double, startTime: Double, endTime: Double) -> SensorReading
    
}


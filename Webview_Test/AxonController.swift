//
//  AxonController.swift
//  Webview_Test
//
//  Created by Enz  Andreas on 27.10.16.
//  Copyright © 2016 COSS. All rights reserved.
//

import Foundation
import Swifter

class AxonController {
    let axonResourceDir = "/Users/aenz/COSS/Webview_Test/Webview_Test/Assets/axon-resources/"
    let axonDir = "/Users/aenz/COSS/Webview_Test/Webview_Test/Assets"

    
    var pseudoSensor: Int = 0
    
    var server = HttpServer()
    
    init(){
        startAxonHTTPServer()
    }
    
    
    func startAxonHTTPServer(){
        
        do {
            try self.server.start()
            print("Server Started Successfully!")
            self.mapAxonHTTPServerRoutes()
        } catch {
            print("Server start error: \(error)")
        }
        
    }
    
    
    func restoreAxonHTTPServer(){
        self.startAxonHTTPServer()
    }
    
    
    func mapAxonHTTPServerRoutes(){
        // route to list available services
        self.server["/"] = { r in
            var listPage = "<div style='font-family: Helvetica; font-size: 12pt'>Available nervousnet services on this device:<br><ul>"
            for services in self.server.routes {
                if !services.isEmpty {
                    listPage += "<li><a href=\"\(services)\">\(services)</a></li>"
                }
            }
            listPage += "</ul></div>"
            return .ok(.html(listPage))
        }
    
        
        

        // route to get static resources like JS, HTML or assets provided by nervous

        self.server.GET["/nervousnet-axon-resources/:resource"] = { r in
            if let filename = r.params[":resource"] {
                return self.returnRawResponse(fileURL: "\(self.axonResourceDir)\(filename)");
            }
            return .notFound
            
        }


        
        // route to get any axon resource
        self.server.GET["/nervousnet-axons/:axonname/:resource"] = { r in
            if let filename = r.params[":resource"], let axonname = r.params[":axonname"] {
                return self.returnRawResponse(fileURL: "\(self.axonDir)/\(axonname)-master/\(filename)");
            }
            return .notFound
            
        }
        


        
        // route to get any axon resource
        // for now a pseudo sensor that returns a counter
        self.server.GET["/nervousnet-api/raw-sensor-data/:sensor/"] = { r in
            
            if let _ = r.params[":sensor"] {
                
                self.pseudoSensor += 1
                let data =  self.pseudoSensor
                
                
                print(data)
                let jsonObject: NSDictionary = ["data": data]
                return .ok(.json(jsonObject))

                
                
            }
            
            return .notFound
            
        }
        
        self.server.GET["/nervousnet-api/historical_data/:sensor/:start/:end"] = { r in
            
            if let sensor = r.params[":sensor"],
            let startTime = r.params[":start"],
            let endTime = r.params[":end"] {
                
                //do some input checking: times should be in some format - probably milliseconds and not newer
                //than today?
                
                
            }
            
            return .notFound
            
        }
        
        //EXTENDED FUNCTIONALITY
        
        
    }
    
    
    func returnRawResponse(fileURL:String) -> HttpResponse {
        
        if let contentsOfFile = NSData(contentsOfFile: fileURL) {
            print("getting \(fileURL)")
            
            var contentsOfFileBytes = [UInt8](repeating: 0, count: contentsOfFile.length)
            contentsOfFile.getBytes(&contentsOfFileBytes, length: contentsOfFile.length)

            return HttpResponse.raw(200, "OK", nil, {try $0.write(contentsOfFileBytes)})

        }
        
        print("resource at \(fileURL) not found")
        return .notFound
        
    }
    
    
}

//
//  ViewController.swift
//  Webview_Test
//
//  Created by Enz  Andreas on 26.10.16.
//  Copyright © 2016 COSS. All rights reserved.
//

import UIKit
import Foundation
import Swifter

class ViewController: UIViewController {

    @IBOutlet weak var axonWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("displaying a basic WebView")
        
        print("Home directory  \(NSBundle.mainBundle().resourcePath!)")
        
        var html: String
        html = "<br /><h2>WebView Hello World</h2>"
        //load html directly as a string
        //axonWebView.loadHTMLString(html, baseURL: nil)
        
        let urlDummySensor: NSURL = NSURL(fileURLWithPath: "http://http://localhost:8080/nervousnet-api/raw-sensor-data/:sensor")
        axonWebView.loadRequest(NSURLRequest(URL: urlDummySensor))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


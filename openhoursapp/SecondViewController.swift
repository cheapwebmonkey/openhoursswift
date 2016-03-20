//
//  SecondViewController.swift
//  openhoursapp
//
//  Created by Margeaux Spring on 3/17/16.
//  Copyright © 2016 Margeaux Spring. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL(string: "http://www.openhours.space")
        
        let request = NSURLRequest(URL: url!)
        webview.loadRequest(request)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


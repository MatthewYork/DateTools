//
//  ViewController.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/19/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        let date = Date()
        print((date + 3.years).chunkBetween(date: Date()))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
}


//
//  SecondViewController.swift
//  DateToolsExample
//
//  Created by Grayson Webster on 10/21/16.
//  Copyright © 2016 Matt York. All rights reserved.
//

import UIKit

class TimePeriodsViewController: UIViewController {

    @IBOutlet weak var periodA: UIView!
    @IBOutlet weak var periodB: UIView!
    @IBOutlet weak var periodC: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.topItem?.title = "Time Periods"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            let xPoint = max((view.frame.width / 2) + 10, min(view.center.x + translation.x, self.view.center.x + (self.view.frame.width / 2) - (view.frame.width / 2) - 10))
            let yPoint = view.center.y
            view.center = CGPoint(x: xPoint, y: yPoint)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
}

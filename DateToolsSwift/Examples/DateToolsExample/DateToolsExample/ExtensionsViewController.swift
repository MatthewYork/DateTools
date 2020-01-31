//
//  FirstViewController.swift
//  DateToolsExample
//
//  Created by Grayson Webster on 10/21/16.
//  Copyright © 2016 Matt York. All rights reserved.
//

import UIKit

class ExtensionsViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var weeksLabel: UILabel!
    @IBOutlet weak var monthsLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.\
        self.navigationController?.navigationBar.topItem?.title = "DateTools + Extensions"
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderChanged(_ sender: AnyObject) {
        updateLabels()
    }
    
    func updateLabels() {
        let date = Date() + TimeInterval(1000000000 * slider.value)
        dateLabel.text = date.format(with: "MMMM d y")
        secondsLabel.text = String(date.secondsAgo)
        minutesLabel.text = String(date.minutesAgo)
        hoursLabel.text = String(date.hoursAgo)
        daysLabel.text = String(date.daysAgo)
        weeksLabel.text = String(date.weeksAgo)
        monthsLabel.text = String(date.monthsAgo)
        yearsLabel.text = String(date.yearsAgo)
    }

}


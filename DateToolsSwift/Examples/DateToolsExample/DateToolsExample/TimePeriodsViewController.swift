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
    
    @IBOutlet weak var aRelationB: UILabel!
    @IBOutlet weak var aRelationC: UILabel!
    @IBOutlet weak var bRelationA: UILabel!
    @IBOutlet weak var bRelationC: UILabel!
    @IBOutlet weak var cRelationA: UILabel!
    @IBOutlet weak var cRelationB: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.topItem?.title = "Time Periods"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        calculateRelationships()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        recognizer.view?.frame = CGRect(x: max(10, min((self.view.frame.size.width-recognizer.view!.frame.size.width - 10), recognizer.view!.frame.origin.x + translation.x)), y: recognizer.view!.frame.origin.y, width: recognizer.view!.frame.size.width, height: recognizer.view!.frame.size.height)
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        calculateRelationships()
    }
    
    func calculateRelationships() {
        
        // Init Time Periods
        let aLeftPoint = periodA.frame.origin.x * 100
        let bLeftPoint = periodB.frame.origin.x * 100
        let cLeftPoint = periodC.frame.origin.x * 100
        
        let timePeriodA = TimePeriod.init(beginning: Date.init(timeIntervalSince1970: TimeInterval(aLeftPoint)), end: Date.init(timeIntervalSince1970: TimeInterval(aLeftPoint + periodA.frame.size.width * 100)))
        let timePeriodB = TimePeriod.init(beginning: Date.init(timeIntervalSince1970: TimeInterval(bLeftPoint)), end: Date.init(timeIntervalSince1970: TimeInterval(bLeftPoint + periodB.frame.size.width * 100)))
        let timePeriodC = TimePeriod.init(beginning: Date.init(timeIntervalSince1970: TimeInterval(cLeftPoint)), end: Date.init(timeIntervalSince1970: TimeInterval(cLeftPoint + periodC.frame.size.width * 100)))
        
        
        // Set Labels
        
        aRelationB.text = relationToString(relation: timePeriodA.relation(to: timePeriodB)) + " B"
        aRelationC.text = relationToString(relation: timePeriodA.relation(to: timePeriodC)) + " C"
        
        bRelationA.text = relationToString(relation: timePeriodB.relation(to: timePeriodA)) + " A"
        bRelationC.text = relationToString(relation: timePeriodB.relation(to: timePeriodC)) + " C"
        
        cRelationA.text = relationToString(relation: timePeriodC.relation(to: timePeriodA)) + " A"
        cRelationB.text = relationToString(relation: timePeriodC.relation(to: timePeriodB)) + " B"
    }
    
    func relationToString(relation: Relation) -> String {
        switch relation {
        case Relation.after:
            return "After"
        case Relation.startTouching:
            return "Starts Touching"
        case Relation.startInside:
            return "Starts Inside"
        case Relation.insideStartTouching:
            return "Ins. Starts Touch"
        case Relation.enclosingStartTouching:
            return "Enc. Start Touch"
        case Relation.enclosing:
            return "Enclosing"
        case Relation.enclosingEndTouching:
            return "Enc. Ends Touch"
        case Relation.exactMatch:
            return "Exact Match"
        case Relation.inside:
            return "Inside"
        case Relation.insideEndTouching:
            return "Ins. Ends Touch"
        case Relation.endInside:
            return "Ends Inside"
        case Relation.endTouching:
            return "Ends Touching"
        case Relation.before:
            return "Before"
        case Relation.none:
            return "None"
        }
    }
    
    
}

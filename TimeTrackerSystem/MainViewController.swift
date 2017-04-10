//
//  MainViewController.swift
//  TimeTrackerSystem
//
//  Created by Anil Saini on 3/15/17.
//  Copyright © 2017 saini.com. All rights reserved.
//

import UIKit

//extension UIViewController
//{
//    @nonobjc func revealViewController() {
//        self.performSelector(Selector("revealViewController"))
//    }
//}

class MainViewController: UIViewController {

    @IBOutlet var timerView: UIView!
    @IBOutlet var sidebarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Time Tracker"
        if let revealVC:SWRevealViewController = self.revealViewController() {
            self.sidebarButton.target = revealVC
            self.sidebarButton.action = "revealToggle:"
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func drawTimer(sender: AnyObject) {
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            for index in 1...100 {
                self.addCircleView(index)
                sleep(1)
            }
       // }
    }

    func addCircleView(let drawCnt: Int) {
        //let diceRoll = CGFloat(Int(arc4random_uniform(7))*50)
        let circleWidth = CGFloat(200)
        let circleHeight = circleWidth
        
        // Create a new CircleView
        let timeView = TimerView(frame: CGRectMake(50, 100, circleWidth, circleHeight))
        
        view.addSubview(timeView)
        
        // Animate the drawing of the circle over the course of 1 second
        let drawPerc: Double = Double(drawCnt)*0.01
        timeView.animateCircle(drawPerc)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

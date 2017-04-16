//
//  MainViewController.swift
//  TimeTrackerSystem
//
//  Created by Anil Saini on 3/15/17.
//  Copyright © 2017 saini.com. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

    @IBOutlet var timerView: UIView!
    @IBOutlet var sidebarButton: UIBarButtonItem!
    //var timer = NSTimer()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Time Tracker"
        if let revealVC:SWRevealViewController = self.revealViewController() {
            self.sidebarButton.target = revealVC
            self.sidebarButton.action = "revealToggle:"
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())

            self.showProgress()

//            timer.invalidate()
//            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "showProgress", userInfo: nil, repeats: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showProgress()
    {
        let progressView = timerView as! CircleProgressView
        progressView.refreshRate = 0.0001
        progressView.destinationProgress = 10.0
        progressView.displayLink?.paused = false
//        print(" == \(progressView.progress)")
//        if progressView.progress >= 0.99
//        {
//            progressView.displayLink?.paused = true
//        }
//        else
//        {
//            progressView.progress = progressView.progress + 0.1
//        }
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

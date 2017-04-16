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
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showProgress()
    {
        let progressView = timerView as! CircleProgressView
        progressView.destinationProgress = 9*3600.0
        progressView.refreshRate = 1/3600.0
        progressView.displayLink?.paused = false
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

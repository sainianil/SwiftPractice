//
//  ReportViewController.swift
//  TimeTrackerSystem
//
//  Created by Anil Saini on 4/6/17.
//  Copyright © 2017 saini.com. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {

    @IBOutlet var sidebarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Time Tracker - Reports"
        if let revealVC:SWRevealViewController = self.revealViewController() {
            self.sidebarButton.target = revealVC
            self.sidebarButton.action = "revealToggle:"
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

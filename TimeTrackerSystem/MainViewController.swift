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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

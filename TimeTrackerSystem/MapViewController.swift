//
//  MapViewController.swift
//  TimeTrackerSystem
//
//  Created by Anil Saini on 3/29/17.
//  Copyright © 2017 saini.com. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    @IBOutlet var sidebarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Map"
        if let revealVC:SWRevealViewController = self.revealViewController() {
            self.sidebarButton.target = revealVC
            self.sidebarButton.action = "revealToggle:"
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
}

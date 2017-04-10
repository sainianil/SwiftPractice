//
//  SettingViewController.swift
//  TimeTrackerSystem
//
//  Created by Anil Saini on 4/6/17.
//  Copyright © 2017 saini.com. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet var sidebarButton: UIBarButtonItem!
    let generalSettings = ["WorkTime":"9 Hours 0 Mins", "OutTime":"1 Hour 0 Min", "WeekDays":"Mon, Tue, Wed, Thu, Sun", "LateTime":"10:30", "PriorNotificationForLateComing":"15 Mins", "PriorNotificationForOuttimeEnd":"5 Mins", "PriorNotificationForHome":"10 Mins", "MaxOuttimeLimit":"19:30"]
    let notificationSettings = ["PriorLateTime":true, "PriorOuttimeEnd":true, "PriorNotificationForGoHome":true, "WorkingHourCompletedNotification":true, "OnLeave":false]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Time Tracker - Settings"
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
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rows = generalSettings.count
        if section == 1 {
            rows = notificationSettings.count
        }
        return rows;
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cellIdentifier = "settings"
        if indexPath.section == 1 {
            cellIdentifier = "notification"
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var sectionName:String = "General"
        
        if section == 1 {
            sectionName = "Notifications"
        }
        
        return sectionName
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

//
//  SettingViewController.swift
//  TimeTrackerSystem
//
//  Created by Anil Saini on 4/6/17.
//  Copyright © 2017 saini.com. All rights reserved.
//

import UIKit

class GeneralSettingsCell: UITableViewCell
{
    @IBOutlet var imgGenSettings: UIImageView!
    @IBOutlet var lblGenSettingsTitle: UILabel!
    @IBOutlet var lblGenSettingsValue: UILabel!
}

class NotificationSettingsCell:UITableViewCell
{
    @IBOutlet var imgNotifSettings: UIImageView!
    @IBOutlet var lblNotifSettingsTitle: UILabel!
    @IBOutlet var switchNotifSettings: UISwitch!
}

struct GenSettings {
    let key:String
    var value:String
}

struct NotifSettings {
    let key:String
    var value:Bool
}

class SettingsTableViewController: UITableViewController {

    @IBOutlet var sidebarButton: UIBarButtonItem!
    let generalSettingsKey = "GeneralSettings"
    let notificationSettingsKey = "NotificationSettings"
    var generalSettings:[GenSettings]!
    var notificationSettings:[NotifSettings]!
//    let generalSettings = ["9 Hours 0 Mins", "1 Hour 0 Min", "Mon, Tue, Wed, Thu, Sun", "10:30", "15 Mins", "5 Mins", "10 Mins", "19:30"]
//    let notificationSettings = [true, true, true, true, false]
    
    func initData() {
        
        if let obj = NSUserDefaults.standardUserDefaults().objectForKey(generalSettingsKey)
        {
            generalSettings = obj as! [GenSettings]
        }
        else
        {
            generalSettings = [GenSettings(key:"Work Time", value:"9 Hours 0 Mins"), GenSettings(key:"Out Time", value:"1 Hour 0 Min"), GenSettings(key:"Week Days", value:"Mon, Tue, Wed, Thu, Sun"), GenSettings(key:"Late Time", value:"10:30"), GenSettings(key:"Prior Notification For Late Coming", value:"15 Mins"), GenSettings(key:"Prior Notification For Outtime End", value:"5 Mins"), GenSettings(key:"Prior Notification For Home", value:"10 Mins"), GenSettings(key:"Max Outtime Limit", value:"19:30")]
        }
//            generalTitles = ["Work Time", "Out Time", "Week Days", "Late Time", "Prior Notification For Late Coming", "Prior Notification For Outtime End", "Prior Notification For Home", "Max Outtime Limit"]
        
        if let obj = NSUserDefaults.standardUserDefaults().objectForKey(notificationSettingsKey)
        {
            notificationSettings = obj as! [NotifSettings]
        }
        else
        {
            notificationSettings = [NotifSettings(key:"Prior Late Time", value:true), NotifSettings(key:"Prior Outtime End", value:true), NotifSettings(key:"Prior Notification For Go Home", value:true), NotifSettings(key:"Working Hour Completed Notification", value:true), NotifSettings(key:"On Leave", value:false)]
        }
//            notificationTitles = ["Prior Late Time", "Prior Outtime End", "Prior Notification For Go Home", "Working Hour Completed Notification", "On Leave"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initData()
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
                
        if indexPath.section == 0
        {
            let obj = generalSettings[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier("settings", forIndexPath: indexPath) as! GeneralSettingsCell
            cell.imgGenSettings.image =  UIImage(named: obj.key)
            cell.lblGenSettingsTitle.text = obj.key
            cell.lblGenSettingsValue.text = obj.value
            return cell
        }
        else
        {
            let obj = notificationSettings[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier("notification", forIndexPath: indexPath) as! NotificationSettingsCell
            cell.imgNotifSettings.image = UIImage(named: obj.key)
            cell.lblNotifSettingsTitle.text = obj.key
            cell.switchNotifSettings.setOn(obj.value, animated: true)
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var sectionName:String = "General"
        
        if section == 1 {
            sectionName = "Notifications"
        }
        
        return sectionName
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0
        {
            let obj = generalSettings[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier("settings", forIndexPath: indexPath) as! GeneralSettingsCell
            if obj.value != cell.lblGenSettingsValue {
                generalSettings[indexPath.row].value = cell.lblGenSettingsValue.text!
               // NSUserDefaults.standardUserDefaults().setObject(generalSettings!, forKey: generalSettingsKey)
            }
        }
        else
        {
            let obj = notificationSettings[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier("notification", forIndexPath: indexPath) as! NotificationSettingsCell
//            if obj.value != cell.switchNotifSettings.state {
//               
//            }
        }
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

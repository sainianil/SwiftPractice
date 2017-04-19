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
    @IBOutlet var txtGenSettingsValue: UITextField!
}

class NotificationSettingsCell:UITableViewCell
{
    @IBOutlet var imgNotifSettings: UIImageView!
    @IBOutlet var lblNotifSettingsTitle: UILabel!
    @IBOutlet var switchNotifSettings: UISwitch!
}


class SettingsTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet var sidebarButton: UIBarButtonItem!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var datePickerView: UIDatePicker!
    
//    let generalSettingsKey = "GeneralSettings"
//    let notificationSettingsKey = "NotificationSettings"
    var generalSettings:[GenSettings]!
    var notificationSettings:[NotifSettings]!
    
    let kSettingsCellID = "SettingsCell"  // the cell containing the general settings
    let kNotificationCellID = "NotificationCell" // the cell containing the notification settings
    
    let hours = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let mins = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59]
//    let generalSettings = ["9 Hours 0 Mins", "1 Hour 0 Min", "Mon, Tue, Wed, Thu, Sun", "10:30", "15 Mins", "5 Mins", "10 Mins", "19:30"]
//    let notificationSettings = [true, true, true, true, false]
    
    func initData() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let obj = userDefaults.objectForKey(AppDefaults.sharedInstance.generalSettingsKey)
        {
            if let objArray = NSKeyedUnarchiver.unarchiveObjectWithData(obj as! NSData)
            {
                generalSettings = objArray as! [GenSettings]
            }
        }
        else
        {
            generalSettings = AppDefaults.sharedInstance.generalSettings() //[GenSettings(key:"Total Working Hours", value:"9 Hours 0 Mins"), GenSettings(key:"Out Of Office Time", value:"1 Hour 0 Min"), GenSettings(key:"Week Days", value:"Mon, Tue, Wed, Thu, Sun"), GenSettings(key:"Max Late Time", value:"10:30"), GenSettings(key:"Remind Prior Late Time", value:"15 Mins"), GenSettings(key:"Remind Prior Outtime End", value:"5 Mins"), GenSettings(key:"Remind Prior Working Hours Completed", value:"10 Mins"), GenSettings(key:"Max Outtime Limit", value:"19:30")]
        }
        
        if let obj = userDefaults.objectForKey(AppDefaults.sharedInstance.notificationSettingsKey)
        {
            if let objArray = NSKeyedUnarchiver.unarchiveObjectWithData(obj as! NSData)
            {
                notificationSettings = objArray as! [NotifSettings]
            }
        }
        else
        {
            notificationSettings = AppDefaults.sharedInstance.notificationSettings() //[NotifSettings(key:"Remind Prior Late Time", value:true), NotifSettings(key:"Remind Prior Outtime End", value:true), NotifSettings(key:"Remind Prior Work Hours Completed", value:true), NotifSettings(key:"Working Hour Completed Notification", value:true), NotifSettings(key:"On Leave", value:false)]
        }
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
        if section == 1
        {
            rows = notificationSettings.count
        }
        return rows;
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                
        if indexPath.section == 0
        {
            let obj = generalSettings[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier(kSettingsCellID, forIndexPath: indexPath) as! GeneralSettingsCell
            cell.imgGenSettings.image =  UIImage(named: obj.key)
            cell.lblGenSettingsTitle.text = obj.key
            cell.txtGenSettingsValue.text = obj.value
            cell.txtGenSettingsValue.tag = indexPath.row
            cell.txtGenSettingsValue.addTarget(self, action: "pickTime:", forControlEvents: .EditingDidBegin)
            
//            let toolBar = UIToolbar()
//            toolBar.barStyle = UIBarStyle.Default
//            toolBar.translucent = true
//            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
//            toolBar.sizeToFit()
//            
//            
//            let doneButton = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "donePicker:")
//            let spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
//            let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancelPicker")
//            
//            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//            toolBar.userInteractionEnabled = true
//            
//            cell.txtGenSettingsValue.inputView = pickerView
//            cell.txtGenSettingsValue.inputAccessoryView = toolBar
            
            return cell
        }
        else
        {
            let obj = notificationSettings[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier(kNotificationCellID, forIndexPath: indexPath) as! NotificationSettingsCell
            cell.imgNotifSettings.image = UIImage(named: obj.key)
            cell.lblNotifSettingsTitle.text = obj.key
            cell.switchNotifSettings.setOn(obj.value, animated: true)
            cell.switchNotifSettings.tag = indexPath.row
            cell.switchNotifSettings.addTarget(self, action: "switchTriggered:", forControlEvents: .ValueChanged)
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        var sectionName:String = "General"
        
        if section == 1 {
            sectionName = "Notifications"
        }
        
        return sectionName
    }
        
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.section == 0
        {
        }
        
//        if indexPath.section == 0
//        {
//            let obj = generalSettings[indexPath.row]
//            let cell = tableView.dequeueReusableCellWithIdentifier("settings", forIndexPath: indexPath) as! GeneralSettingsCell
//            if obj.value != cell.lblGenSettingsValue.text
//            {
//                generalSettings[indexPath.row].value = cell.lblGenSettingsValue.text!
//                let userDefaults = NSUserDefaults.standardUserDefaults()
//                userDefaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(generalSettings), forKey: generalSettingsKey)
//                userDefaults.synchronize()
//            }
//        }
    }
    
    func pickTime(sender:UITextField)
    {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .ActionSheet)
        alert.modalInPopover = true

        //  Add the picker to the alert controller
        alert.view.addSubview(pickerView)
        
//        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
//        
//        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func switchTriggered(sender:UISwitch)
    {
        let obj = notificationSettings[sender.tag]
        let isEnable = sender.on
        
        if obj.value != isEnable
        {
            notificationSettings[sender.tag].value = isEnable
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(notificationSettings), forKey: AppDefaults.sharedInstance.notificationSettingsKey)
            userDefaults.synchronize()
        }
    }
    
    // MARK: - UIPickerView delegate and datasource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 4;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        var numberOfRows = 1
        switch component
        {
        case 0:
            numberOfRows = hours.count
            break
        case 2:
            numberOfRows = mins.count
            break
        default:
            break
        }
        
      return numberOfRows;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        var rowValue:String!
        
        switch component
        {
        case 0:
            rowValue = String(stringInterpolationSegment: hours[row])
            pickerView.reloadComponent(1)
            break
        case 1:
            rowValue = "Hours"
            let index = pickerView.selectedRowInComponent(0)
            if hours[index] == 1
            {
                rowValue = "Hour"
            }
            break
        case 2:
            rowValue = String(stringInterpolationSegment: mins[row])
            pickerView.reloadComponent(3)
            break
        case 3:
            let index = pickerView.selectedRowInComponent(2)
            rowValue = "Mins"
            if mins[index] == 1
            {
                rowValue = "Min"
            }
            break
        default:
            break
        }
        
        return rowValue
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


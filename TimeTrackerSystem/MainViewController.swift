//
//  MainViewController.swift
//  TimeTrackerSystem
//
//  Created by Anil Saini on 3/15/17.
//  Copyright © 2017 saini.com. All rights reserved.
//

import UIKit

enum ProgressType: Int
{
    case InTime = 1, OutTime
}

class MainViewController: UIViewController, CircleProgressViewDelegate {

    @IBOutlet var timerView: CircleProgressView!
    @IBOutlet var sidebarButton: UIBarButtonItem!
    @IBOutlet var btnTimer: UIButton!
    @IBOutlet var lblRemainingTime: UILabel!
    @IBOutlet var lblRemainingText: UILabel!
    @IBOutlet var lblElapseTime: UILabel!
    @IBOutlet var lblInOutText: UILabel!
    
    var timerStartedTime:NSDate!
    var progressType = ProgressType.InTime.rawValue
    let userDefaults = NSUserDefaults.standardUserDefaults()
    var workingHoursCompleted:Bool = false
    let progressTypeDefaultKey = "ProgressTypeDefaultsKey"

    override func viewDidLoad()
    {
        super.viewDidLoad()

        //setup view
        self.title = "Time Tracker"
        if let revealVC:SWRevealViewController = self.revealViewController() {
            self.sidebarButton.target = revealVC
            self.sidebarButton.action = "revealToggle:"
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        btnTimer.titleLabel?.textAlignment = .Center
        btnTimer.titleLabel?.lineBreakMode = .ByWordWrapping
        timerView.delegate = self
        lblRemainingText.text = "Remains"
        lblInOutText.text = "In Time"
        
        self.updateAndSaveCheckedInTime()
        self.onUpdateUI()
    }

    override func didReceiveMemoryWarning()
    {
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
    
    func showProgress()
    {
        if progressType == ProgressType.InTime.rawValue
        {
            timerView.destinationProgress = 9*3600.0
            timerView.progress = timerView.destinationProgress / self.timeDifference(ProgressType.InTime.rawValue)
            timerView.refreshRate = 1/(timerView.destinationProgress)
            timerView.displayLink?.paused = false
        }
        else
        {
            timerView.destinationProgress = 3600.0
            timerView.progress = timerView.destinationProgress / self.timeDifference(ProgressType.OutTime.rawValue)
            timerView.refreshRate = 1/(timerView.destinationProgress)
            timerView.displayLink?.paused = false
        }
    }
    
    @IBAction func startTimer(sender: UIButton)
    {
        self.updateAndSaveCheckedInTime()
        
//        if progressType == ProgressType.InTime.rawValue
//        {
//            progressType = ProgressType.OutTime.rawValue
//        }
//        else
//        {
//            progressType = ProgressType.InTime.rawValue
//        }

        self.showProgress()
    }
    
    func dayString() -> String
    {
        let currentTime = NSDate()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "ddMMMyyyy"
        let dayString = dateFormatter.stringFromDate(currentTime)
        return dayString
    }
    
    func updateAndSaveCheckedInTime()
    {
        let currentTime = NSDate()
        
        //fetch start time if already started otherwise save current time
        let savedCheckInTime = userDefaults.objectForKey(self.dayString())
        if(savedCheckInTime == nil)
        {
            timerStartedTime = currentTime;
            userDefaults.setObject(currentTime, forKey: self.dayString())
            userDefaults.synchronize()
        }
        else
        {
            timerStartedTime = savedCheckInTime as! NSDate
            self.showProgress()
        }
        
        //fetch progressType if already stored otherwise store it
        var savedProgressType = userDefaults.integerForKey(progressTypeDefaultKey)
        if savedProgressType == 0
        {
            savedProgressType = ProgressType.InTime.rawValue
            
            userDefaults.setInteger(savedProgressType, forKey:progressTypeDefaultKey)
            userDefaults.synchronize()
        }
        progressType = savedProgressType;
    }
    
    func timeStringToDisplay(type:Int) -> String
    {
        let timeDifference = self.timeDifference(type)
        let seconds =  Int(timeDifference % 60)
        let minutes = Int((timeDifference / 60) % 60)
        let hours = Int((timeDifference / 60) / 60)
        
        let secondsString = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        let minutesString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let hoursString = hours < 10 ? "0\(hours)" : "\(hours)"
        
        return "\(hoursString):\(minutesString):\(secondsString)"
    }
    
    func timeDifference(type:Int) -> NSTimeInterval
    {
        var hoursCompleted:Bool = false
        let currentTime = NSDate()
        var timeDifference = currentTime.timeIntervalSinceDate(timerStartedTime)
        //let generalSettings = userDefaults.objectForKey(AppDefaults.sharedInstance.generalSettingsKey)
        let totalWorkingHours = 9 * 3600.0
        hoursCompleted = (timeDifference >= totalWorkingHours)
        
        if hoursCompleted != workingHoursCompleted
        {
            workingHoursCompleted = hoursCompleted
            
            if hoursCompleted
            {
                self.askUserToGoHome()
            }
        }
        
        if(type == ProgressType.InTime.rawValue)
        {
            timeDifference = totalWorkingHours - timeDifference;
        }
        
        return timeDifference
    }
    
    func askUserToGoHome()
    {
//        let userNotification = UIUserNotification
//        userNotification
    }
    
    // MARK: - CircleProgressViewDelegate
    
    func onUpdateUI()
    {
        let remainsTimeString = self.timeStringToDisplay(ProgressType.InTime.rawValue)
        let inTimeString = self.timeStringToDisplay(ProgressType.OutTime.rawValue)
        
        if progressType == ProgressType.OutTime.rawValue
        {
            lblInOutText.text = "Out Time"
        }
        else
        {
            lblInOutText.text = "In Time"
        }
        
        lblRemainingTime.text = remainsTimeString
        lblElapseTime.text = inTimeString
    }

}

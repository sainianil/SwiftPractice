//
//  Constants.swift
//  TimeTrackerSystem
//
//  Created by Anil Saini on 4/18/17.
//  Copyright © 2017 saini.com. All rights reserved.
//

import Foundation


class GenSettings: NSObject, NSCoding {
    var key:String!
    var value:String!
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
    
    // MARK: NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        guard let key = aDecoder.decodeObjectForKey("key"),
            let value = aDecoder.decodeObjectForKey("value")
            else { return nil }
        
        self.init(key: key as! String, value: value as! String)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.key, forKey: "key")
        aCoder.encodeObject(self.value, forKey: "value")
    }
}

class NotifSettings: NSObject, NSCoding {
    let key:String!
    var value:Bool!
    
    init(key: String, value: Bool) {
        self.key = key
        self.value = value
    }
    
    // MARK: NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        guard let key = aDecoder.decodeObjectForKey("key"),
            let value = aDecoder.decodeObjectForKey("value")
            else { return nil }
        
        self.init(key: key as! String, value: value as! Bool)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.key, forKey: "key")
        aCoder.encodeObject(self.value, forKey: "value")
    }
}


class AppDefaults {
    static let sharedInstance = AppDefaults()
    
    let generalSettingsKey = "GeneralSettings"
    let notificationSettingsKey = "NotificationSettings"
    
    func generalSettings() -> [GenSettings] {
        return [GenSettings(key:"Total Working Hours", value:"9 Hours 0 Mins"), GenSettings(key:"Out Of Office Time", value:"1 Hour 0 Min"), GenSettings(key:"Week Days", value:"Mon, Tue, Wed, Thu, Sun"), GenSettings(key:"Max Late Time", value:"10:30"), GenSettings(key:"Remind Prior Late Time", value:"15 Mins"), GenSettings(key:"Remind Prior Outtime End", value:"5 Mins"), GenSettings(key:"Remind Prior Working Hours Completed", value:"10 Mins"), GenSettings(key:"Max Outtime Limit", value:"19:30")]
    }
    
    func notificationSettings() -> [NotifSettings] {
        return [NotifSettings(key:"Remind Prior Late Time", value:true), NotifSettings(key:"Remind Prior Outtime End", value:true), NotifSettings(key:"Remind Prior Work Hours Completed", value:true), NotifSettings(key:"Working Hour Completed Notification", value:true), NotifSettings(key:"On Leave", value:false)]
    }
}
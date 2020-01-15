//
//  WifiInfo.swift
//  InOutManagement
//
//  Created by 유석환 on 2020/01/15.
//  Copyright © 2020 ysh. All rights reserved.
//

import Foundation
import SystemConfiguration.CaptiveNetwork

class WifiInfo {
    var _ssid:String?
    var ssid:String {
        get {
            if _ssid != nil {
                return _ssid!
            } else {
                return "error"
            }
        }
        set(newVal) {
            _ssid = newVal
        }
    }
    
    var _bssid:String?
    var bssid:String {
        get {
            if _bssid != nil {
                return _bssid!
            } else {
                return "error"
            }
        }
        set(newVal) {
            _bssid = newVal
        }
    }
    
    // 생성자
    init() {
        self._ssid = "ssid"
        self._bssid = "bssid"
    }
    
    // Wi-Fi 정보 업데이트
    func updateWifiInformation() {
        var newSsid: String?
        var newBssid: String?
        
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    newSsid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    newBssid = interfaceInfo[kCNNetworkInfoKeyBSSID as String] as? String
                    break
                }
            }
        }
        
        if newSsid != nil {
            ssid = newSsid!
        } else {
            ssid = "error"
        }
        
        if newBssid != nil {
            bssid = newBssid!
        } else {
            bssid = "error"
        }
    }
    
    // toString()
    func toString() -> String {
        var contents: String = "[연결된 Wi-Fi 정보]"
        contents += "\nSSID: " + ssid + "\nBSSID: " + bssid
        
        return contents
    }
}

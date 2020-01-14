//
//  ViewController.swift
//  InOutManagement
//
//  Created by 유석환 on 2020/01/12.
//  Copyright © 2020 ysh. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var currentNetworkInfos: Array<NetworkInfo>? {
        get {
            return SSID.fetchNetworkInfo()
        }
    }
    
    @IBOutlet var labelRequestTime: UILabel!
    @IBOutlet var labelContents: UILabel!
    
    // Main View가 로드됐을 때
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            let status = CLLocationManager.authorizationStatus()
            if status == .authorizedWhenInUse {
                labelContents.text = currentNetworkInfos?.first?.ssid
            } else {
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
            }
        } else {
            labelContents.text = currentNetworkInfos?.first?.ssid
        }
    }

    // Wi-Fi 버튼을 클릭했을 때
    @IBAction func btnWifi(_ sender: UIButton) {
        currentTime()
        labelContents.text = "SSID: "
    }
    
    // Bluetooth 버튼을 클릭했을 때
    @IBAction func btnBluetooth(_ sender: UIButton) {
        currentTime()
        labelContents.text = "Bluetooth 버튼 클릭됨"
    }
    
    // 요청시간 출력
    @objc func currentTime() {
        let date = NSDate()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        labelRequestTime.text = "요청 시간: " + formatter.string(from: date as Date)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            labelContents.text = currentNetworkInfos?.first?.ssid
        }
    }
}

public class SSID {
    class func fetchNetworkInfo() -> [NetworkInfo]? {
        if let interfaces: NSArray = CNCopySupportedInterfaces() {
            var networkInfos = [NetworkInfo]()
            for interface in interfaces {
                let interfaceName = interface as! String
                var networkInfo = NetworkInfo(interface: interfaceName,
                                              success: false,
                                              ssid: nil,
                                              bssid: nil)
                if let dict = CNCopyCurrentNetworkInfo(interfaceName as CFString) as NSDictionary? {
                    networkInfo.success = true
                    networkInfo.ssid = dict[kCNNetworkInfoKeySSID as String] as? String
                    networkInfo.bssid = dict[kCNNetworkInfoKeyBSSID as String] as? String
                }
                networkInfos.append(networkInfo)
            }
            return networkInfos
        }
        return nil
    }
}

struct NetworkInfo {
    var interface: String
    var success: Bool = false
    var ssid: String?
    var bssid: String?
}

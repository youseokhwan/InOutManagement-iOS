//
//  ViewController.swift
//  InOutManagement
//
//  Created by 유석환 on 2020/01/12.
//  Copyright © 2020 ysh. All rights reserved.
//

import UIKit
import Network
import CoreLocation
import UserNotifications

// 현재 연결된 Wi-Fi 정보
var currentWifi:WifiInfo = WifiInfo()

// 네트워크 감지
@available(iOS 12.0, *)
let monitor = NWPathMonitor()

// 백그라운드 작업
let queue = DispatchQueue.global(qos: .background)

class MainViewController: UIViewController, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {
    let locationManager = CLLocationManager()
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    @IBOutlet var labelRequestTime: UILabel!
    @IBOutlet var labelContents: UILabel!
    
    // Main View가 로드된 직후 실행
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 위치권한 확인 및 요청
        // issue: 상태값 반환 관련 버그 https://forums.developer.apple.com/thread/117256#369672
        if #available(iOS 13.0, *) {
            let status = CLLocationManager.authorizationStatus()
            
            if status == .authorizedAlways {
                startWifiDetection()
            } else if status == .authorizedWhenInUse {
                locationManager.delegate = self
                locationManager.requestAlwaysAuthorization()
            } else {
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
            }
        } else {
            startWifiDetection()
        }
        
        // 알림권한 확인 및 요청
        userNotificationCenter.delegate = self
        requestNotificationAuthorization()
        sendNotification(title: "알림", body: "네트워크 감지를 시작합니다.")
    }

    // Wi-Fi 버튼을 클릭했을 때
    @IBAction func btnWifi(_ sender: UIButton) {
        currentTime()
        currentWifi.updateWifiInformation()
        labelContents.text = currentWifi.toString()
    }
    
    // Bluetooth 버튼을 클릭했을 때
    @IBAction func btnBluetooth(_ sender: UIButton) {
        currentTime()
        labelContents.text = "Bluetooth Information"
    }
    
    // 요청시간 출력
    @objc func currentTime() {
        let date = NSDate()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        labelRequestTime.text = "요청 시간: " + formatter.string(from: date as Date)
    }
    
    // 위치권한 변경에 대한 작업
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            startWifiDetection()
        } else if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    // 알림권한 요청
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .sound)
        
        userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }
    
    // 알림 요청
    func sendNotification(title: String, body: String) {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = title
        notificationContent.body = body

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification", content: notificationContent, trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    // Wi-Fi 감지 시작
    // issue: 백그라운드에서 제대로 동작하지 않는 상태
    // issue: 네트워크 변경 시 알림이 여러번 발생하는 현상 해결해야 함
    // issue: 알림에 소리/진동이 발생하지 않음
    func startWifiDetection() {
        if #available(iOS 12.0, *) {
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    if path.usesInterfaceType(.wifi) {
                        print("Wi-Fi에 연결")
                        self.sendNotification(title: "네트워크 알림", body: "Wi-Fi에 연결되었습니다.")
                    } else if path.usesInterfaceType(.cellular) {
                        print("셀룰러 데이터에 연결")
                        self.sendNotification(title: "네트워크 알림", body: "셀룰러 데이터에 연결되었습니다.")
                    } else {
                        print("기타 네트워크에 연결")
                        self.sendNotification(title: "네트워크 알림", body: "기타 네트워크에 연결되었습니다.")
                    }
                } else {
                    print("인터넷에 연결되지 않은 상태")
                    self.sendNotification(title: "네트워크 알림", body: "네트워크 연결이 끊겼습니다.")
                }
            }
            monitor.start(queue: queue)
        } else {
            print("iOS 12 미만입니다.")
            self.sendNotification(title: "시스템 알림", body: "지원하지 않는 버전입니다.")
        }
    }
}

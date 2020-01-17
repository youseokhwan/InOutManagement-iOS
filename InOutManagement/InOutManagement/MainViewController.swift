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

// 현재 연결된 Wi-Fi 정보
var currentWifi:WifiInfo = WifiInfo()

// 네트워크 감지
@available(iOS 12.0, *)
let monitor = NWPathMonitor()

// 백그라운드 작업
let queue = DispatchQueue.global(qos: .background)

class MainViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    @IBOutlet var labelRequestTime: UILabel!
    @IBOutlet var labelContents: UILabel!
    
    // Main View가 로드된 직후 실행
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 위치권한 확인 및 요청
        // 상태값 반환 관련 버그 https://forums.developer.apple.com/thread/117256#369672
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
    
    // 위치권한 요청 및 응답
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            startWifiDetection()
        } else if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    // Wi-Fi 감지 시작
    // 알림 기능 구현 후 네트워크 변경 작업이 백그라운드에서도 잘 동작하는지 확인하기
    func startWifiDetection() {
        if #available(iOS 12.0, *) {
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    if path.usesInterfaceType(.wifi) {
                        print("Wi-Fi에 연결")
                    } else if path.usesInterfaceType(.cellular) {
                        print("셀룰러 데이터에 연결")
                    } else {
                        print("기타 네트워크에 연결")
                    }
                } else {
                    print("인터넷에 연결되지 않은 상태")
                }
            }
            monitor.start(queue: queue)
        } else {
            print("iOS 12 미만입니다.")
        }
    }
}



//
//  ViewController.swift
//  InOutManagement
//
//  Created by 유석환 on 2020/01/12.
//  Copyright © 2020 ysh. All rights reserved.
//

import UIKit

// 현재 연결된 Wi-Fi 정보
var currentWifi:WifiInfo = WifiInfo()

class MainViewController: UIViewController {
    @IBOutlet var labelRequestTime: UILabel!
    @IBOutlet var labelContents: UILabel!
    
    // Main View가 로드된 직후 실행
    override func viewDidLoad() {
        super.viewDidLoad()
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
}



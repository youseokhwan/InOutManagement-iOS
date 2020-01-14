//
//  ViewController.swift
//  InOutManagement
//
//  Created by 유석환 on 2020/01/12.
//  Copyright © 2020 ysh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet var labelRequestTime: UILabel!
    @IBOutlet var labelContents: UILabel!
    
    // Main View가 로드됐을 때
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Wi-Fi 버튼을 클릭했을 때
    @IBAction func btnWifi(_ sender: UIButton) {
        updateTime()
        labelContents.text = "Wi-Fi 버튼 클릭됨"
    }
    
    // Bluetooth 버튼을 클릭했을 때
    @IBAction func btnBluetooth(_ sender: UIButton) {
        updateTime()
        labelContents.text = "Bluetooth 버튼 클릭됨"
    }
    
    @objc func updateTime() {
        let date = NSDate()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        labelRequestTime.text = "요청 시간: " + formatter.string(from: date as Date)
    }
}


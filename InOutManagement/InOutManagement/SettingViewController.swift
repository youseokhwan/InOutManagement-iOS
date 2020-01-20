//
//  SettingViewController.swift
//  InOutManagement
//
//  Created by 유석환 on 2020/01/12.
//  Copyright © 2020 ysh. All rights reserved.
//

import UIKit

var homeWifiList:[WifiInfo] = [
    WifiInfo(newSsid: "HomeWifi1", newBssid: "11:11:11:11:11:11"),
    WifiInfo(newSsid: "HomeWifi2", newBssid: "22:22:22:22:22:22")
]

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var labelCurrentWifiSsid: UILabel!
    @IBOutlet weak var tableViewHomeWifiList: UITableView!
    
    // SettingView 로드 후 실행
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 현재 연결된 Wi-Fi의 SSID 출력
        currentWifi.updateWifiInformation()
        labelCurrentWifiSsid.text = "현재 Wi-Fi: " + currentWifi.ssid
        
        // Table View에 Home Wi-Fi 목록 출력
        tableViewHomeWifiList.delegate = self
        tableViewHomeWifiList.dataSource = self
        
        // 연결된 Wi-Fi를 Home Wi-Fi로 추가하는 기능 구현
        // code...
    }
    
    // TableView의 개수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeWifiList.count
    }
    
    // TableView의 Cell 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! CustomCell
        let currentRowOfList = homeWifiList[indexPath.row]
        
        cell.labelSsid.text = currentRowOfList.ssid
        cell.bssid = currentRowOfList.bssid
        
        return cell
    }
}

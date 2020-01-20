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
    
    // 현재 Wi-Fi를 Home Wi-Fi로 추가
    // issue: 추가는 되는데 바로 애니메이션으로 반영되지 않음
    @IBAction func buttonAddHomeWifi(_ sender: UIButton) {
        // Wi-Fi에 연결되어있지 않을 경우 Alert
        if currentWifi.bssid == "error" {
            let alert = UIAlertController(title: "Error", message: "Wi-Fi에 연결되어있지 않습니다.", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return
        }
        
        // 이미 등록된 Home Wi-Fi일 경우 Alert
        for homeWifi in homeWifiList {
            if homeWifi.bssid == currentWifi.bssid {
                let alert = UIAlertController(title: "Error", message: "이미 등록된 Wi-Fi입니다.", preferredStyle: UIAlertController.Style.alert)
                let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                return
            }
        }
        
        // Home Wi-Fi로 등록
        homeWifiList.append(WifiInfo(newSsid: currentWifi.ssid, newBssid: currentWifi.bssid))
    }
}

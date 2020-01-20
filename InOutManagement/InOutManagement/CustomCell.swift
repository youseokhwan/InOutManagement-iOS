//
//  CustomCell.swift
//  InOutManagement
//
//  Created by 유석환 on 2020/01/20.
//  Copyright © 2020 ysh. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet var labelSsid: UILabel!
    var bssid: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 삭제 버튼 클릭 시 해당 셀 삭제
    @IBAction func buttonRemove(_ sender: UIButton) {
//        print("bssid: " + self.bssid)
//
//        for i in 0 ..< homeWifiList.count {
//            if self.bssid == homeWifiList[i].bssid {
//                homeWifiList.remove(at: i)
//                break
//            }
//        }
    }
}

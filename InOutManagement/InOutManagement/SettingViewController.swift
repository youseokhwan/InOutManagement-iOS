//
//  SettingViewController.swift
//  InOutManagement
//
//  Created by 유석환 on 2020/01/12.
//  Copyright © 2020 ysh. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet var labelTest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelTest.text = "Setting"
    }

}

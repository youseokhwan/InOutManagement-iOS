//
//  ContentView.swift
//  InOutManagement
//
//  Created by 유석환 on 2020/01/06.
//  Copyright © 2020 ysh. All rights reserved.
//

import SwiftUI
import SystemConfiguration.CaptiveNetwork

@available(iOS 13.0, *)
struct ContentView: View {
    @State var content: String = "Network Status"
    @State var ssid: String?
    
    var body: some View {
        VStack {
            Text("InOutManagement")
                .font(.title)
            
            HStack(alignment: .center) {
                Button(action: {
                    self.ssid = getSSID()
                    self.content = "현재 연결된 Wi-Fi: \(self.ssid)"
                }) {
                    Text("Wi-Fi")
                }
                
                Spacer()
                
                Button(action: {
                    self.content = "Bluetooth Clicked"
                }) {
                    Text("Bluetooth")
                }
                
                Spacer()
                
                Button(action: {
                    self.content = "Get Clicked"
                }) {
                    Text("Get")
                }
                
                Spacer()
                
                Button(action: {
                    self.content = "Setting Clicked"
                }) {
                    Text("Setting")
                }
            }.padding()
            
            Text(self.content).padding()
            
            Spacer()
        }.padding()
    }
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

@available(iOS 13.0, *)
struct SettingView: View {
    var body: some View {
        Text("SettingView")
    }
}

// 현재 연결된 SSID를 가져오는 함수
func getSSID() -> String? {
    let interfaces = CNCopySupportedInterfaces()
    if interfaces == nil {
        return nil
    }
    
    let interfacesArray = interfaces as! [String]
    if interfacesArray.count <= 0 {
        return nil
    }
    
    let interfaceName = interfacesArray[0] as String
    let unsafeInterfaceData = CNCopyCurrentNetworkInfo(interfaceName as CFString)
    if unsafeInterfaceData == nil {
        return nil
    }
    
    let interfaceData = unsafeInterfaceData as! Dictionary <String,AnyObject>
    
    return interfaceData["SSID"] as? String
}

//
//  ContentView.swift
//  InOutManagement
//
//  Created by 유석환 on 2020/01/06.
//  Copyright © 2020 ysh. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct ContentView: View {
    var body: some View {
         NavigationView {
            VStack(alignment: .center) {
                Text("InOutManagement")
                    .font(.title)
                
                HStack(alignment: .center) {
                    Button(action: {
                        print("Wi-Fi Clicked")
                    }) {
                        Text("Wi-Fi")
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("Bluetooth Clicked")
                    }) {
                        Text("Bluetooth")
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("Get Clicked")
                    }) {
                        Text("Get")
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("Setting Clicked")
                    }) {
                        Text("Setting")
                    }
                }.padding()
                
                Text("Information TextView").padding()
                
                Spacer()
            }.padding()
        }
    }
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

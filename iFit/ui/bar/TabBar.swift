//
//  TabBar.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/7.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            PersonView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("历史")
                }
                .tag(0)
            PersonView()
                .tabItem {
                    Image(systemName: "figure.run")
                    Text("运动")
                }
                .tag(1)
            PersonView()
                .tabItem {
                    Image(systemName: "person")
                    Text("个人")
                }
                .tag(2)
        }
        .onAppear {
            self.selection = 1
        }
    }
    
}

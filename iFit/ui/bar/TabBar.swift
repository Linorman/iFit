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
    @State private var localUsername: String
    
    init(selection: Int = 0, localUsername: String) {
        self.selection = selection
        self.localUsername = localUsername
    }
    
    var body: some View {
        TabView(selection: $selection) {
            AnalyzeView(localUsername: localUsername)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("历史")
                }
                .tag(0)
            ExerciseView(localUsername: localUsername)
                .tabItem {
                    Image(systemName: "figure.run")
                    Text("运动")
                }
                .tag(1)
            PersonView(localUsername: localUsername)
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

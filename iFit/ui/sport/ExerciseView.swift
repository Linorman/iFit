//
//  ExerciseView.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/10.
//

import Foundation
import SwiftUI

struct ExerciseView: View {
    @State private var selection = 0
    @State private var localUsername: String
    
    init(localUsername: String) {
        _localUsername = State(initialValue: localUsername)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("计时器")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(selection == 0 ? .black : .gray)
                    .padding(.horizontal)
                    .onTapGesture {
                        self.selection = 0
                    }
                Spacer()
                Text("倒计时")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(selection == 1 ? .black : .gray)
                    .padding(.horizontal)
                    .onTapGesture {
                        self.selection = 1
                    }
                Spacer()
            }
            TabView(selection: $selection) {
                TimerModeView(localUsername: localUsername)
                    .tag(0)
            
                CountdownModeView(localUsername: localUsername)
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            Spacer()
        }
    }
}

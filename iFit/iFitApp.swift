//
//  iFitApp.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/5.
//

import SwiftUI

@main
struct iFitApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

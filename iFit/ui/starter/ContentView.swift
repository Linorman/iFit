//
//  ContentView.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/5.
//

import SwiftUI
import CoreData

//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            LoginView()
//        }
//    }
//}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isLogged = false
    
    var body: some View {
        NavigationView{
            LoginView()
        }
    }
}


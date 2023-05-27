//
//  SoftwareInfoView.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/10.
//

import Foundation

import SwiftUI

struct AppInfoView: View {
    var developer: String
    var donationLink: String
    var githubLink: String
    var giteeLink: String
    var license: String
    
    var body: some View {
        List {
            Section(header: Text("Developer")) {
                Text(developer)
            }
            
            Section(header: Text("Links")) {
                Button(action: {
                    if let url = URL(string: donationLink) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Donate")
                }
                
                Button(action: {
                    if let url = URL(string: githubLink) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Github")
                }
                
                Button(action: {
                    if let url = URL(string: giteeLink) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Gitee")
                }
                
                Text(license)
            }
        }
        .navigationTitle("软件信息")
    }
}

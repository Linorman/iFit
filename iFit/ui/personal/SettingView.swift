//
//  SettingView.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/9.
//

import SwiftUI

struct SettingsView: View {

    @State private var sportUnit: String = ""
    @State private var isRingOn: Bool = false
    @State private var dailyTime: Int = 0
    @State private var timer: Int = 0
    
    @State private var showAlert: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
//                Text("Settings")
//                    .font(.title)

                Form {
                    Section(header: Text("单位")) {
                        Picker(selection: $sportUnit, label: Text("单位").foregroundColor(.primary)) {
                            Text("KM").tag("KM")
                            Text("Miles").tag("Miles")
                        }
                    }

                    Section(header: Text("响铃设置")) {
                        Toggle("打开响铃", isOn: $isRingOn)
                    }

                    Section(header: Text("训练计划")) {
                        List {
                            VStack {
                                Section {
                                    Text ("Daily Time")
                                    Stepper("\(dailyTime) 分钟", value: $dailyTime, in: 0...1440, step: 10)
                                }
                            }
                            
                        }
                    }
                    
                    Section(header: Text("定时器设置")) {
                        Stepper("\(timer) 分钟", value: $dailyTime, in: 0...1440, step: 1)
                    }
                }
                .background(.white)

                Button(action: saveSettings) {
                    Text("保存").frame(maxWidth: .infinity).padding().background(Color.orange).foregroundColor(.white).cornerRadius(8).padding()
                        
                }.disabled(sportUnit.isEmpty && !isRingOn)
            }
        }
        .onAppear {
            loadSettings()
        }
        .navigationTitle("设置")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("保存成功"), message: Text("您已经保存数据成功"), dismissButton: .default(Text("确定")))
        }
        
    }

    func loadSettings() {
        let defaults = UserDefaults.standard
        sportUnit = defaults.string(forKey: SettingsKeys.sportUnit) ?? "KM"
        isRingOn = defaults.bool(forKey: SettingsKeys.ringSetting)
        dailyTime = defaults.integer(forKey: SettingsKeys.dailyTime)==0 ? 30 : defaults.integer(forKey: SettingsKeys.dailyTime)
        timer = defaults.integer(forKey: SettingsKeys.timer)==0 ? 30 : defaults.integer(forKey: SettingsKeys.timer)
    }

    func saveSettings() {
        let defaults = UserDefaults.standard
        defaults.set(sportUnit, forKey: SettingsKeys.sportUnit)
        defaults.set(isRingOn, forKey: SettingsKeys.ringSetting)
        defaults.set(dailyTime, forKey: SettingsKeys.dailyTime)
        defaults.set(timer, forKey: SettingsKeys.timer)
        
        self.showAlert = true
    }
}

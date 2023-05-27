//
//  CountDownView.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/10.
//

import Foundation
import SwiftUI

struct CountdownTimerView: View {
    @Binding var isRunning: Bool
    @Binding var timeElapsed: TimeInterval
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    private var countdownTime = 60.0

    var body: some View {
        Text(timeString(from: countdownTime - timeElapsed))
            .font(.system(size: 80))
            .padding()
            .foregroundColor(countdownTime - timeElapsed <= 5 ? .red : .primary)
            .onReceive(timer) { _ in
                guard isRunning else { return }
                if timeElapsed < countdownTime {
                    timeElapsed += 0.1
                } else {
                    isRunning = false
                }
            }
    }

    private func timeString(from time: TimeInterval) -> String {
        return String(format: "%.1f", time)
    }
}

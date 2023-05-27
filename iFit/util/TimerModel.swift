//
//  ExerciseViewModel.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/10.
//

import SwiftUI
import Combine

class TimerModel: ObservableObject {
    @Published var timeElapsed: TimeInterval = 0
    @Published var isRunning = false
    
    private var tickCancellable: AnyCancellable?
    private var startDate: Date?
    
    func toggle() {
        if isRunning {
            stop()
        } else {
            startExercise()
        }
    }
    
    func reset() {
        timeElapsed = 0
        stop()
    }
    
    private func startExercise() {
        isRunning = true
        startDate = Date()
        
        tickCancellable = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.timeElapsed = Date().timeIntervalSince(self.startDate ?? Date())
            }
    }
    
    public func stop() {
        isRunning = false
        startDate = nil
        tickCancellable?.cancel()
        tickCancellable = nil
    }
}

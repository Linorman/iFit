//
//  ExerciseView.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/10.
//

import Foundation
import SwiftUI
import AVFoundation
import CoreData

//struct ExerciseTimerView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @State private var timer: Timer?
//    @State private var countdownTimer: Timer?
//
//    @State private var duration: Double = 0
//    @State private var isTiming: Bool = false
//    @State private var isCountdown: Bool = false
//    @State private var countdownSeconds: Int16 = 0
//
//    @State private var showImagePicker: Bool = false
//    @State private var selectedImage: UIImage?
//
//    @State private var image: UIImage?
//
//    private let countdownSecondsDefault: Int16 = 120
//
//    @ObservedObject var audioManager = AudioManager()
//
//    var body: some View {
//        VStack {
//            if let selectedImage = selectedImage {
//                Image(uiImage: selectedImage)
//                    .resizable()
//                    .scaledToFit()
//                    .padding()
//            }
//
//            Text("\(Int(duration / 60)):\(String(format: "%02d", Int(duration) % 60))")
//                .font(.largeTitle)
//                .padding()
//
//            if isCountdown {
//                Text("Countdown: \(countdownSeconds) seconds")
//                    .font(.title)
//                    .foregroundColor(.red)
//                    .padding()
//            }
//
//            Spacer()
//
//            HStack {
//                Button(action: startTimer) {
//                    Text(isTiming ? "Stop" : "Start")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(isTiming ? Color.red : Color.green)
//                        .cornerRadius(15)
//                }
//                .disabled(isCountdown)
//
//                Button(action: resetTimer) {
//                    Text("Reset")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.gray)
//                        .cornerRadius(15)
//                }
//                .disabled(isTiming || isCountdown)
//            }
//
//            Button(action: selectImage) {
//                Text("Select Image")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(15)
//            }
//            .sheet(isPresented: $showImagePicker, onDismiss: saveRecord) {
//                ImagePicker(image: self.$image)
//            }
//        }
//        .onAppear {
//            resetTimer()
//        }
//    }
//
//    private func startTimer() {
//        if isTiming {
//            stopTimer()
//        } else {
//            if countdownSeconds > 0 {
//                startCountdown()
//            } else {
//                startExercise()
//            }
//        }
//    }
//
//    private func startExercise() {
//        isTiming = true
//
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//            duration += 1
//
//            if Int(duration) % 60 == 0 {
//                playBellSound()
//            }
//        }
//    }
//
//    private func startCountdown() {
//        isCountdown = true
//        countdownSeconds = countdownSecondsDefault
//
//        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//            countdownSeconds -= 1
//
//            if countdownSeconds <= 0 {
//                stopCountdown()
//                startExercise()
//            }
//        }
//    }
//
//    private func stopTimer() {
//        isTiming = false
//
//        timer?.invalidate()
//        timer = nil
//
//        stopCountdown()
//    }
//
//    private func stopCountdown() {
//        isCountdown = false
//
//        countdownTimer?.invalidate()
//        countdownTimer = nil
//    }
//
//    private func resetTimer() {
//        stopTimer()
//        selectedImage = nil
//        duration = 0
//        image = nil
//    }
//
//    private func playBellSound() {
//        audioManager.playBellSound()
//    }
//
//    private func selectImage() {
//        showImagePicker = true
//    }
//
//    private func saveRecord() {
//        guard let image = image else { return }
//
//        let newRecord = ExerciseRecord(context: viewContext)
//        newRecord.time = duration
//        newRecord.image = image.jpegData(compressionQuality: 1.0)
//        newRecord.date = Date()
//
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//
//        selectedImage = image
//    }
//}



//struct ExerciseTimerView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @State private var timer: Timer?
//    @State private var countdownTimer: Timer?
//
//    @State private var duration: Double = 0
//    @State private var isTiming: Bool = false
//    @State private var isCountdown: Bool = false
//    @State private var countdownSeconds: Int16 = 0
//
//    @State private var showImagePicker: Bool = false
//    @State private var selectedImage: UIImage?
//
//    @State private var image: UIImage?
//
//    @State private var countdownInput: String = ""
//    @State private var isCountdownMode: Bool = false
//
//    private let countdownSecondsDefault: Int16 = 120
//
//    @ObservedObject var audioManager = AudioManager()
//
//    var body: some View {
//        VStack {
//            if let selectedImage = selectedImage {
//                Image(uiImage: selectedImage)
//                    .resizable()
//                    .scaledToFit()
//                    .padding()
//            }
//
//            Text("\(Int(duration / 60)):\(String(format: "%02d", Int(duration) % 60))")
//                .font(.largeTitle)
//                .padding()
//
//            if isCountdown {
//                Text("Countdown: \(countdownSeconds) seconds")
//                    .font(.title)
//                    .foregroundColor(.red)
//                    .padding()
//            }
//
//            if isCountdownMode {
//                TextField("Countdown Time (seconds)", text: $countdownInput)
//                    .keyboardType(.numberPad)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
//            }
//
//            Spacer()
//
//            HStack {
//                Button(action: startTimer) {
//                    Text(isTiming ? "Stop" : "Start")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(isTiming ? Color.red : Color.green)
//                        .cornerRadius(15)
//                }
//                .disabled(isCountdownMode || isCountdown)
//
//                Button(action: resetTimer) {
//                    Text("Reset")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.gray)
//                        .cornerRadius(15)
//                }
//                .disabled(isTiming || isCountdown)
//            }
//
//            Button(action: selectImage) {
//                Text("Select Image")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(15)
//            }
//            .sheet(isPresented: $showImagePicker, onDismiss: saveRecord) {
//                ImagePicker(image: self.$image)
//            }
//
//            if !isCountdownMode {
//                Button(action: toggleMode) {
//                    Text("Switch to Countdown Mode")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.purple)
//                        .cornerRadius(15)
//                }
//            } else {
//                Button(action: toggleMode) {
//                    Text("Switch to Timer Mode")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.purple)
//                        .cornerRadius(15)
//                }
//            }
//        }
//        .onAppear {
//            resetTimer()
//        }
//    }
//
//    private func startTimer() {
//        if isTiming {
//            stopTimer()
//        } else {
//            if isCountdownMode {
//                startCountdown()
//            } else {
//                startExercise()
//            }
//        }
//    }
//
//    private func startExercise() {
//        isTiming = true
//
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//            duration += 1
//
//            if Int(duration) % 60 == 0 {
//                playBellSound()
//            }
//        }
//    }
//
//    private func startCountdown() {
//        guard let seconds = Int(countdownInput.trimmingCharacters(in: .whitespacesAndNewlines)) else { return }
//
//        duration = Double(seconds)
//        countdownSeconds = Int16(seconds)
//
//        isCountdownMode = true
//        isCountdown = true
//
//        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//            countdownSeconds -= 1
//
//            if countdownSeconds <= 0 {
//                stopCountdown()
//                playBellSound()
//            }
//        }
//    }
//
//    private func stopTimer() {
//        isTiming = false
//
//        timer?.invalidate()
//        timer = nil
//
//        stopCountdown()
//    }
//
//    private func stopCountdown() {
//        isCountdown = false
//
//        countdownTimer?.invalidate()
//        countdownTimer = nil
//    }
//
//    private func resetTimer() {
//        stopTimer()
//        selectedImage = nil
//        duration = 0
//        image = nil
//        countdownInput = ""
//        isCountdownMode = false
//    }
//
//    private func playBellSound() {
//        audioManager.playBellSound()
//    }
//
//    private func selectImage() {
//        showImagePicker = true
//    }
//
//    private func saveRecord() {
//        guard let image = image else { return }
//
//        let newRecord = ExerciseRecord(context: viewContext)
//        newRecord.time = duration
//        newRecord.image = image.jpegData(compressionQuality: 1.0)
//        newRecord.date = Date()
//
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//
//        selectedImage = image
//    }
//
//    private func toggleMode() {
//        isCountdownMode.toggle()
//        resetTimer()
//    }
//}

struct TimerView: View {
    @Binding var isRunning: Bool
    @Binding var timeElapsed: TimeInterval
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text(timeString(from: timeElapsed))
            .font(.system(size: 80))
            .padding()
            .onReceive(timer) { _ in
                guard isRunning else { return }
                timeElapsed += 0.1
            }
    }

    private func timeString(from time: TimeInterval) -> String {
        return String(format: "%.1f", time)
    }
}

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

struct TimerModeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = TimerModel()
    @State private var showImagePicker = false
    @State private var image: UIImage?
    @State private var showAlert = false
    @State private var localUsername: String
    
    init(localUsername: String) {
        _localUsername = State(initialValue: localUsername)
    }
    
    var body: some View {
        VStack {
            Button(action: {
                self.showImagePicker = true
            }) {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 210, height: 170)
                        .cornerRadius(10)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 210, height: 170)
                        .cornerRadius(10)
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image)
            }
            .padding()
            
            Text(timeString(timeElapsed: viewModel.timeElapsed))
                .font(.system(size: 80, weight: .bold, design: .monospaced))
            
            HStack(spacing: 55) {
                Image(systemName: viewModel.isRunning ? "pause.fill" : "play.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: 80, minHeight: 0, maxHeight: 80)
                    .background(viewModel.isRunning ? .red : .green)
                    .clipShape(Capsule())
                    .onTapGesture {
                        viewModel.toggle()
                    }
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: 80, minHeight: 0, maxHeight: 80)
                    .background(.blue)
                    .clipShape(Capsule())
                    .onTapGesture {
                        viewModel.reset()
                    }
            }.padding(.bottom, 55)
            
            Spacer()
            
            Button(action: {
                if let image = image {
                    let record = ExerciseRecord(context: viewContext)
                    record.username = self.localUsername
                    record.duration = viewModel.timeElapsed
                    record.image = image.pngData()
                    record.dateStamp = Date()
                    do {
                        try viewContext.save()
                    } catch {
                        print("Error saving exercise record: \(error.localizedDescription)")
                    }
                } else {
                    print("No image selected")
                }
                
                viewModel.reset()
            }) {
                Image(systemName: "square.and.arrow.down")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .alert("错误", isPresented: $showAlert) {
                Text("没有选择图片。")
            }
        }
        .padding()
        .navigationBarTitle("计时器")
    }
}

func timeString(timeElapsed: TimeInterval) -> String {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.allowedUnits = [.minute, .second]
    formatter.zeroFormattingBehavior = .pad
    
    return formatter.string(from: timeElapsed)!
}

//
//  CountDownView.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/10.
//

import Foundation
import SwiftUI
import AudioToolbox

struct CountdownModeView: View {
    @StateObject private var viewModel = TimerModel()
    @State private var showImagePicker = false
    @State private var image: UIImage?
    @State private var totalTime: CGFloat = 30
    @State private var counterTime: Int = 0
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var showAlert = false
    @State private var localUsername: String
    @State private var editTime = false

    @Environment(\.managedObjectContext) private var viewContext
    
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
                        .frame(width: 180, height: 150)
                        .cornerRadius(10)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 180, height: 150)
                        .cornerRadius(10)
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image)
            }
            .padding()
            
            ZStack {
                Circle()
                    .fill(Color.clear)
                    .padding()
                    .frame(width: 230, height: 230)
                    .overlay(
                        Circle()
                            .trim(from: 0, to: ((CGFloat(totalTime)-CGFloat(counterTime)) / CGFloat(totalTime)))
                            .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.init(degrees: -90))
                            .foregroundColor(
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    ((CGFloat(totalTime)-CGFloat(counterTime)) / CGFloat(totalTime))==1 ? Color.green : Color.orange
                                }
                            )
                    )
                
                
                VStack {
//                    Image(systemName: "exclamationmark.circle.fill")
//                        .foregroundColor(.gray)
//                        .font(.system(size: 20))
//                        .clipShape(Capsule())
//                        .alert(isPresented: $editTime) {
//                            Alert(title: "提示", message: "请到设置中修改定时器时间。", dismissButton: .default(Text("确定")))
//                        }
                    Text(counterToMinutes())
                        .font(.system(size: 48))
                        .fontWeight(.black)
                }
                    
            }
            .onReceive(timer) { time in
                self.startCounting()
            }
            
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
                        viewModel.stop()
                        self.counterTime = 0
                        withAnimation(.default) {
                            self.totalTime = 30
                        }
                    }
            }.padding(.bottom, 55)
            
            
            Spacer()
            
            Button(action: {
                if self.counterTime==Int(self.totalTime) {
                    if let image = image {
                        let record = ExerciseRecord(context: viewContext)
                        record.username = self.localUsername
                        record.duration = Double(self.totalTime)
                        record.image = image.pngData()
                        record.dateStamp = Date()
                        do {
                            try viewContext.save()
                            self.image = Image(systemName: "photo")
                                .resizable()
                                .frame(width: 210, height: 170)
                                .cornerRadius(10) as! UIImage
                        } catch {
                            print("Error saving exercise record: \(error.localizedDescription)")
                        }
                    } else {
                        print("No image selected")
                    }
                    viewModel.reset()
                } else {
                    showAlert = true
                }
                
            }) {
                Image(systemName: "square.and.arrow.down")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("保存错误"), message: Text("您还未完成运动，无法打卡"), dismissButton: .default(Text("确定")))
            }
            
        }
        .padding()
        .navigationBarTitle("倒计时")
    }
    
    func counterToMinutes() -> String {
        let currentTime = Int(totalTime) - counterTime
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
    
    func startCounting() {
        if viewModel.isRunning {
            if (self.counterTime < Int(self.totalTime)) {
                self.counterTime += 1
            }else {
                viewModel.toggle()
                // 播放铃声
                AudioServicesPlaySystemSound(SystemSoundID(1000))
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    // 停止播放系统提示音
                    AudioServicesDisposeSystemSoundID(SystemSoundID(1000))
}
            }
        }
    }
}


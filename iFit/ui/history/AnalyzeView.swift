//
//  AnalyzeView.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/19.
//

import Foundation
import SwiftUI
import CoreData


struct AnalyzeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var totalDuration: Double = 0
    // @FetchRequest(entity: ExerciseRecord.entity(), sortDescriptors: []) var records: FetchedResults<ExerciseRecord>
    @State private var records: [ExerciseRecord] = []
    @State private var showingHistoryView = false // 是否显示HistoryView
    @State private var selectedRecord: ExerciseRecord? // 选择的记录
    @State private var localUsername: String
    
    init(localUsername: String) {
        _localUsername = State(initialValue: localUsername)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("运动总时长：\(totalDuration, specifier: "%.2f") 秒")
                        .fontWeight(.bold)
                    Spacer()
                }
                
                List {
                    ForEach(records, id: \.self) { record in
                        HStack {
                            Text("\(record.duration, specifier: "%.2f") 秒")
                            Text(record.username ?? "")
                            Text(getFormattedDate(date: record.dateStamp))
                        }
                        .onTapGesture {
                            selectedRecord = record
                            showingHistoryView = true
                        }
                    }
                }
            }
            .sheet(isPresented: $showingHistoryView) {
                if let record = selectedRecord {
                    HistoryView(record: record)
                }
            }
            .onAppear {
                initRecords()
                calculateTotalDuration()
            }
            .navigationTitle("历史记录")
        }
        .padding()
    }
    
    private func initRecords() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ExerciseRecord")
                fetchRequest.predicate = NSPredicate(format: "username == %@", localUsername)
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dateStamp", ascending: false)]
                do {
                    let result = try viewContext.fetch(fetchRequest)
                    records = result as! [ExerciseRecord]
                } catch {
                    print(error)
                }
    }
    
    
    private func calculateTotalDuration() {
        // 计算健身总时长
        totalDuration = records.reduce(0) { $0 + $1.duration }
        for record in records {
            print(record.username ?? "")
            print(record.dateStamp)
            print(record.duration)
        }
    }
    
    private func getFormattedDate(date: Date?) -> String {
        // 获取格式化的日期
        guard let date = date else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: date)
    }
}

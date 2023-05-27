import Foundation
import SwiftUI

struct HistoryView: View {
    let record: ExerciseRecord
    
    var body: some View {
        VStack{
            HStack {
            Text("精彩时刻")
                .font(.system(size: 30))
                .fontWeight(.bold)
            }
            .padding()
            Text(getFormattedDate(date: record.dateStamp))
                .font(.system(size: 20))
                .fontWeight(.bold)
        }
        
        VStack {
            Image(uiImage: UIImage(data: record.image ?? Data()) ?? UIImage())
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
        }
        VStack {
            Text("\(record.duration, specifier: "%.2f") 秒")
                .font(.system(size: 20))
                .fontWeight(.bold)
            
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

//
//  DateManager.swift
//  LetSwift
//
//  Created by Delma Song on 2020/11/22.
//

import Foundation

struct DateManager {
    func judgeSessionNowLive(date: String, time: String) -> Bool {
        guard let sessionTime = stringDateConvert(date: date, time: time) else { return false }
        
        let today = Calendar.current.dateComponents([.month, .day, .hour], from: Date())
        let sessionStart = Calendar.current.dateComponents([.month, .day, .hour], from: sessionTime.start)
        let sessionEnd = Calendar.current.dateComponents([.month, .day, .hour], from: sessionTime.end)
        
        guard today.month == sessionStart.month && today.day == sessionStart.day else { return false }
        guard let startHour = sessionStart.hour,
              let endHour = sessionEnd.hour,
              let nowHour = today.hour
        else { return false }
        guard startHour <= nowHour, nowHour <= endHour else { return false }
        
        return true
    }
    
    func stringDateConvert(date: String, time: String) -> (start: Date, end: Date)? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        
        let startTime = time[time.startIndex...time.index(time.startIndex, offsetBy: 4)]
        let endTime = time[time.index(time.endIndex, offsetBy: -5)...time.index(before: time.endIndex)]
        
        guard let startDate = dateFormatter.date(from: "2020년 \(date) \(startTime)"),
              let endDate = dateFormatter.date(from: "2020년 \(date) \(endTime)")
        else { return nil }
        
        return (startDate, endDate)
    }
}

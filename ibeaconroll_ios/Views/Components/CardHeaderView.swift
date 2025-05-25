//
//  CardHeaderView.swift
//  ibeaconroll_ios
//
//  Created by soo on 5/25/25.
//

import SwiftUI

struct CardHeaderView: View {
    let schedule: ClassSchedule
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(timeRangeString)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(schedule.className)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(schedule.room)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // 상태 배지
            StatusBadgeView(status: schedule.attendanceStatus)
        }
    }
    
    private var timeRangeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ko_KR")
        return "\(formatter.string(from: schedule.startTime)) - \(formatter.string(from: schedule.endTime))"
    }
}

//
//  CompletedAttendanceView.swift
//  ibeaconroll_ios
//
//  Created by soo on 5/25/25.
//

import SwiftUI

struct CompletedAttendanceView: View {
    let schedule: ClassSchedule
    
    var body: some View {
        AttendanceStatusView(
            type: .present,
            title: "출석 완료",
            subtitle: subtitleText
        )
    }
    
    private var subtitleText: String {
        guard let checkInTime = schedule.checkInTime,
              let checkOutTime = schedule.checkOutTime else { return "" }
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ko_KR")
        return "입실: \(formatter.string(from: checkInTime)) | 퇴실: \(formatter.string(from: checkOutTime))"
    }
}


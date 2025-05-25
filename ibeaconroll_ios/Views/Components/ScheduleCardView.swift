//
//  ScheduleCardView.swift
//  ibeaconroll_ios
//
//  Created by soo on 5/25/25.
//

// ==========================================
// MARK: - Views/Components/ScheduleCardView.swift
// ==========================================

import SwiftUI

struct ScheduleCardView: View {
    let schedule: ClassSchedule
    let index: Int
    let viewModel: AttendanceViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 카드 헤더
            CardHeaderView(schedule: schedule)
            
            Divider()
            
            // 출석 섹션
            attendanceSection
        }
        .padding(20)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
    }
    
    @ViewBuilder
    private var attendanceSection: some View {
        switch schedule.attendanceStatus {
        case .waiting:
            WaitingAttendanceView(index: index, viewModel: viewModel)
        case .ongoing:
            OngoingAttendanceView(schedule: schedule, index: index, viewModel: viewModel)
        case .completed:
            CompletedAttendanceView(schedule: schedule)
        case .absent:
            AbsentAttendanceView()
        }
    }
}

struct ScheduleCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleCardView(
            schedule: ClassSchedule(
                startTime: Date(),
                endTime: Date().addingTimeInterval(3600),
                className: "컴퓨터프로그래밍",
                room: "공학관 301호",
                attendanceStatus: .waiting
            ),
            index: 0,
            viewModel: AttendanceViewModel()
        )
        .padding()
    }
}

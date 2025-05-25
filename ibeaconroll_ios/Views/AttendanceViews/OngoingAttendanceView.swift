//
//  OngoingAttendanceView.swift
//  ibeaconroll_ios
//
//  Created by soo on 5/25/25.
//

import SwiftUI

struct OngoingAttendanceView: View {
    let schedule: ClassSchedule
    let index: Int
    let viewModel: AttendanceViewModel
    
    var body: some View {
        VStack(spacing: 12) {
//            HStack(spacing: 12) {
//                Button(action: {}) {
//                    HStack {
//                        Image(systemName: "checkmark")
//                        Text("입실완료")
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 12)
//                    .background(Color.gray.opacity(0.2))
//                    .foregroundColor(.gray)
//                    .clipShape(RoundedRectangle(cornerRadius: 12))
//                }
//                .disabled(true)
//                
//                Button(action: {
//                    viewModel.requestCheckOut(at: index)
//                }) {
//                    HStack {
//                        Image(systemName: "door.left.hand.open")
//                        Text("퇴실하기")
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 12)
//                    .background(
//                        LinearGradient(
//                            gradient: Gradient(colors: [Color.red, Color.red.opacity(0.8)]),
//                            startPoint: .leading,
//                            endPoint: .trailing
//                        )
//                    )
//                    .foregroundColor(.white)
//                    .clipShape(RoundedRectangle(cornerRadius: 12))
//                }
//            }
            
            // 현재 출석 상태
            AttendanceStatusView(
                type: .present,
                title: "수업 진행중",
                subtitle: subtitleText
            )
        }
    }
    
    private var subtitleText: String {
        guard let checkInTime = schedule.checkInTime else { return "" }
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ko_KR")
        return "입실: \(formatter.string(from: checkInTime)) | 경과시간: \(viewModel.getElapsedTime(for: schedule))"
    }
}

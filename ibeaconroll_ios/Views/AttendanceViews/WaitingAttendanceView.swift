//
//  WaitingAttendanceView.swift
//  ibeaconroll_ios
//
//  Created by soo on 5/25/25.
//

import SwiftUI

struct WaitingAttendanceView: View {
    let index: Int
    let viewModel: AttendanceViewModel
    
    var body: some View {
        HStack(spacing: 12) {
//            Button(action: {
//                viewModel.checkIn(at: index)
//            }) {
//                HStack {
//                    Image(systemName: "location.fill")
//                    Text("입실하기")
//                }
//                .frame(maxWidth: .infinity)
//                .padding(.vertical, 12)
//                .background(
//                    LinearGradient(
//                        gradient: Gradient(colors: [Color.green, Color.green.opacity(0.8)]),
//                        startPoint: .leading,
//                        endPoint: .trailing
//                    )
//                )
//                .foregroundColor(.white)
//                .clipShape(RoundedRectangle(cornerRadius: 12))
//            }
//            
//            Button(action: {}) {
//                Text("퇴실하기")
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 12)
//                    .background(Color.gray.opacity(0.2))
//                    .foregroundColor(.gray)
//                    .clipShape(RoundedRectangle(cornerRadius: 12))
//            }
//            .disabled(true)
            
        }
        AttendanceStatusView(
            type: .present,
            title: "출석 대기 중",
            subtitle: ""
        )
    }
    
}

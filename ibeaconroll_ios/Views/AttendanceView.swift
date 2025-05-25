//
//  AttendanceView.swift
//  ibeaconroll_ios
//
//  Created by soo on 5/25/25.
//

import SwiftUI

struct AttendanceView: View {
    @StateObject private var viewModel = AttendanceViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                // 배경 그라데이션
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // 헤더
                    HeaderView(scheduleCount: viewModel.schedules.count)
                    
                    // 컨텐츠
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(Array(viewModel.schedules.enumerated()), id: \.element.id) { index, schedule in
                                ScheduleCardView(
                                    schedule: schedule,
                                    index: index,
                                    viewModel: viewModel
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    }
                }
                
            }
        }
        .alert("수업 중 퇴실 확인", isPresented: $viewModel.showPreventionAlert) {
            Button("계속 수업", role: .cancel) {
                viewModel.showPreventionAlert = false
            }
            Button("긴급 퇴실", role: .destructive) {
                viewModel.emergencyCheckOut()
            }
        } message: {
            Text("수업이 아직 진행 중입니다.\n정말로 퇴실하시겠습니까?")
        }
    }
}

struct AttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceView()
    }
}

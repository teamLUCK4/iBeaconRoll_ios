//
//  AttendanceViewModel.swift
//  ibeaconroll_ios
//
//  Created by soo on 5/25/25.
//

import Foundation
import SwiftUI

class AttendanceViewModel: ObservableObject {
    @Published var schedules: [ClassSchedule] = []
    @Published var showPreventionAlert = false
    @Published var selectedScheduleIndex: Int?
    
    private var timer: Timer?
    
    init() {
        loadTodaySchedule()
        startTimer()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    private func loadTodaySchedule() {
        let calendar = Calendar.current
        let now = Date()
        
        // 샘플 데이터 생성
        schedules = [
            ClassSchedule(
                startTime: calendar.date(byAdding: .hour, value: -2, to: now)!,
                endTime: calendar.date(byAdding: .hour, value: -1, to: now)!,
                className: "컴퓨터프로그래밍",
                room: "공학관 301호",
                attendanceStatus: .completed,
                checkInTime: calendar.date(byAdding: .hour, value: -2, to: now)!,
                checkOutTime: calendar.date(byAdding: .hour, value: -1, to: now)!
            ),
            ClassSchedule(
                startTime: calendar.date(byAdding: .minute, value: -30, to: now)!,
                endTime: calendar.date(byAdding: .hour, value: 1, to: now)!,
                className: "데이터베이스설계",
                room: "공학관 205호",
                attendanceStatus: .ongoing,
                checkInTime: calendar.date(byAdding: .minute, value: -30, to: now)!
            ),
            ClassSchedule(
                startTime: calendar.date(byAdding: .hour, value: 2, to: now)!,
                endTime: calendar.date(byAdding: .hour, value: 3, to: now)!,
                className: "소프트웨어공학",
                room: "공학관 401호",
                attendanceStatus: .waiting
            ),
            ClassSchedule(
                startTime: calendar.date(byAdding: .hour, value: 4, to: now)!,
                endTime: calendar.date(byAdding: .hour, value: 5, to: now)!,
                className: "모바일앱개발",
                room: "공학관 501호",
                attendanceStatus: .waiting
            )
        ]
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            self.updateScheduleStatus()
        }
    }
    
    private func updateScheduleStatus() {
        let now = Date()
        for index in 0..<schedules.count {
            let schedule = schedules[index]
            if schedule.checkInTime != nil && schedule.checkOutTime == nil {
                if now >= schedule.endTime {
                    schedules[index].attendanceStatus = .completed
                }
            }
        }
    }
    
    func checkIn(at index: Int) {
        schedules[index].checkInTime = Date()
        schedules[index].attendanceStatus = .ongoing
    }
    
    func requestCheckOut(at index: Int) {
        selectedScheduleIndex = index
        let schedule = schedules[index]
        let now = Date()
        
        // 수업 시간이 끝나지 않았으면 경고 표시
        if now < schedule.endTime {
            showPreventionAlert = true
        } else {
            performCheckOut(at: index)
        }
    }
    
    func performCheckOut(at index: Int) {
        schedules[index].checkOutTime = Date()
        schedules[index].attendanceStatus = .completed
        showPreventionAlert = false
        selectedScheduleIndex = nil
    }
    
    func emergencyCheckOut() {
        guard let index = selectedScheduleIndex else { return }
        performCheckOut(at: index)
    }
    
    func getElapsedTime(for schedule: ClassSchedule) -> String {
        guard let checkInTime = schedule.checkInTime else { return "" }
        let elapsed = Date().timeIntervalSince(checkInTime)
        let hours = Int(elapsed) / 3600
        let minutes = (Int(elapsed) % 3600) / 60
        return "\(hours)시간 \(minutes)분"
    }
}

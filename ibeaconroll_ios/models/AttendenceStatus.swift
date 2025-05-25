//
//  AttendenceStatus.swift
//  ibeaconroll_ios
//
//  Created by soo on 5/25/25.
//
import SwiftUI

enum AttendanceStatus {
    case waiting
    case ongoing
    case completed
    case absent
    
    var displayText: String {
        switch self {
        case .waiting: return "대기중"
        case .ongoing: return "진행중"
        case .completed: return "완료"
        case .absent: return "결석"
        }
    }
    
    var color: Color {
        switch self {
        case .waiting: return .orange
        case .ongoing: return .green
        case .completed: return .blue
        case .absent: return .red
        }
    }
}

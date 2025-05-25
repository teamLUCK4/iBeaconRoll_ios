//
//  AttendenceType.swift
//  ibeaconroll_ios
//
//  Created by soo on 5/25/25.
//

import SwiftUI

enum AttendanceType {
    case present, late, absent
    
    var icon: String {
        switch self {
        case .present: return "checkmark.circle.fill"
        case .late: return "clock.fill"
        case .absent: return "xmark.circle.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .present: return .green
        case .late: return .orange
        case .absent: return .red
        }
    }
}

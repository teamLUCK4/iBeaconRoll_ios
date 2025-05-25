//
//  StatusBadgeView.swift
//  ibeaconroll_ios
//
//  Created by soo on 5/25/25.
//
import SwiftUI

struct StatusBadgeView: View {
    let status: AttendanceStatus
    
    var body: some View {
        Text(status.displayText)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(status.color.opacity(0.2))
            .foregroundColor(status.color)
            .clipShape(Capsule())
    }
}

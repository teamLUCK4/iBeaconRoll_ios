//
//  AbsentAttendanceView.swift
//  ibeaconroll_ios
//
//  Created by soo on 5/25/25.
//

import SwiftUI

struct AbsentAttendanceView: View {
    var body: some View {
        AttendanceStatusView(
            type: .absent,
            title: "결석",
            subtitle: "출석하지 않음",
            backgroundColor: .red
        )
    }
}

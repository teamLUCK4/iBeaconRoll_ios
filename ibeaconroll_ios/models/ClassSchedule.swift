//
//  ClassSchedule.swift
//  ibeaconroll_ios
//
//  Created by soo on 5/25/25.
//
import Foundation
import SwiftUI

struct ClassSchedule: Identifiable {
    let id = UUID()
    let startTime: Date
    let endTime: Date
    let className: String
    let room: String
    var attendanceStatus: AttendanceStatus
    var checkInTime: Date?
    var checkOutTime: Date?
}


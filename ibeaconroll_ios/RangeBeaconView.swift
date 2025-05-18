//
//  RangeBeaconView.swift
//  ibeaconroll_ios
//
//  Created by 김다연 on 5/18/25.
//

import SwiftUI
import UIKit

struct RangeBeaconView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RangeBeaconViewController {
        return RangeBeaconViewController()
    }

    func updateUIViewController(_ uiViewController: RangeBeaconViewController, context: Context) {
        // 업데이트 필요 없음
    }
}

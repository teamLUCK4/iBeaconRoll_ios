//
//  ContentView.swift
//  ibeaconroll_ios
//
//  Created by soo on 5/18/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("🧭 iBeacon View 연결 중...").onAppear {
            DailyDataManager.shared.getDailyData { result in
                switch result {
                case .success(let data):
                    print("✅ Fetched data: \(data)")
                case .failure(let error):
                    print("❌ Error: \(error)")
                }
            }
        }
        RangeBeaconView()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}

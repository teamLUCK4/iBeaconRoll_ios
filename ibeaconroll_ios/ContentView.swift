//
//  ContentView.swift
//  ibeaconroll_ios
//
//  Created by soo on 5/18/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("🧭 iBeacon View 연결 중...")
        RangeBeaconView()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}

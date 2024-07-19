//
//  RealTimeClockView.swift
//  Stocks
//
//  Created by Nikunj Thakur on 2024-07-10.
//

import SwiftUI

struct RealTimeClockView: View {
    @State private var currentTime = Date()

    var body: some View {
        Text("\(formattedDate(currentTime))")
            .font(.headline)
            .onAppear(perform: startClock)
    }

    // Function to start the clock
    private func startClock() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.currentTime = Date()
        }
        timer.tolerance = 0.1
    }

    // Helper function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
}

#Preview {
    RealTimeClockView()
}


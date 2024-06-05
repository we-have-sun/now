//
//  InfinteSunTester.swift
//  Now
//
//  Created by Nicho on 30/05/2024.
//

import SwiftUI

struct InfinteSunTester: View {
    @State var duration: Int? = 0
    @State private var timer: Timer?
    var body: some View {
        Button("Random Time") {
            duration = Int.random(in: 0...10_800_000)
        }
        .padding(20)
        Button("Start Timer") {
            startTimer()
        }
        .padding(40)
        
        InfiniteSun(hue: 50, duration: $duration)
        Slider(value: durationDouble, in: 0...10_800_000, step: 1)
                       .padding()
        
    }
    private var durationDouble: Binding<Double> {
            Binding(
                get: { Double(duration ?? 0) },
                set: { duration = Int($0) }
            )
        }
    private func startTimer() {
            timer?.invalidate() // Invalidate the existing timer if any
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
                if let currentDuration = duration {
                    duration = currentDuration + 100_000
                }
            }
        }

}

#Preview {
    InfinteSunTester()
}

//
//  InfinteSunTester.swift
//  Now
//
//  Created by Nicho on 30/05/2024.
//

import SwiftUI

struct InfinteSunTester: View {
    @State private var duration: Int? = 3 * 1000 * 60
    var body: some View {
        
        InfiniteSun(duration: $duration)
        Slider(value: durationDouble, in: 0...10_800_000, step: 1)
                       .padding()
        
    }
    private var durationDouble: Binding<Double> {
            Binding(
                get: { Double(duration ?? 0) },
                set: { duration = Int($0) }
            )
        }

}

#Preview {
    InfinteSunTester()
}

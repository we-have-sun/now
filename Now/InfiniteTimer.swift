//
//  ContentView.swift
//  Now
//
//  Created by Natalia Terlecka on 13/04/2024.
//

import SwiftUI
import CoreGraphics

struct InfiniteTimer: View {

    @StateObject private var sun: Sun
    @State private var timeIsRunning = false
    @State private var intention = "Training" // State for storing user intention
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(intention: String) {
        self.intention = intention
        _sun = StateObject(wrappedValue: Sun(name: intention))
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Color(red: 251, green: 250, blue: 249)

            VStack {

                Spacer() // Space between the controls and the circle

                Text(intention)
                    .font(.largeTitle)
                Spacer() // Space between the controls and the circle

                if timeIsRunning {
                    Text(formattedTime(sun.timeInMs))
                        .font(.headline)
                } else {
                    Spacer()
                }
                
                Spacer(minLength: 300) // Push the circle up a bit
            }

            // Section at the bottom for the Start Countdown Button
            VStack {
                Button(action: {
                    self.timeIsRunning.toggle()
                    self.timeIsRunning ? sun.start() : sun.stop()
                }) {
                    if timeIsRunning {
                        Image("stop")
                    } else {
                        Image("play")
                    }
                }
                .padding(.bottom, 20) // Bottom padding for the button
                .padding(.horizontal, 20) // Horizontal padding for better touch area
            }
            .background(Color.clear) // Ensure no overlap or extra padding affects layout
        }
    }
    
    func formattedTime(_ milliseconds: Int) -> String {
        let seconds = milliseconds / 1000
        let ms = milliseconds % 1000
        return String(format: "%d:%03d", seconds, ms)
    }

}

struct PieSliceMask: Shape {
    var startAngle: Angle
    var endAngle: Angle

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.midX, startAngle: startAngle, endAngle: endAngle, clockwise: true) // Ensure the clockwise direction is correct for reducing arc
        path.closeSubpath()
        return path
    }
}

struct InfiniteTimer_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteTimer(intention: "State")
    }
}

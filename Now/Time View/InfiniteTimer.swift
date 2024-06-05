//
//  ContentView.swift
//  Now
//
//  Created by Natalia Terlecka on 13/04/2024.
//

import SwiftUI
import CoreGraphics

struct InfiniteTimer: View {

    @StateObject private var sun: RunningSun
    @State private var timeIsRunning = false
    @State private var intention = "Training" // State for storing user intention

    init(intention: String) {
        self.intention = intention
        _sun = StateObject(wrappedValue: RunningSun(sun: Sun(name: intention)))
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 239, green: 243, blue: 245)
                .ignoresSafeArea()

            VStack {
                Text(intention)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center) // Center text alignment
                Spacer()

                if timeIsRunning {
                    InfiniteSun(hue: sun.permanentSun.hue, duration: $sun.timeInMs)
                    HStack {
                        Spacer()
                        Text(formattedTime(sun.timeInMs ?? 0))
                            .font(.system(size: 26, weight: .medium, design: .monospaced))
                            .foregroundColor(.black)
                        Spacer()
                    }

                    Spacer() // Push the circle up a bit
                } else {
                    Spacer()
                }

                Spacer()
                Button(action: {
                    self.timeIsRunning.toggle()
                    self.timeIsRunning ? sun.start() : sun.stop()
                }) {
                    if timeIsRunning {
                        Image("stop")
                            .resizable()
                            .aspectRatio(contentMode: .fit)

                    } else {
                        Image("play")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .frame(width: 74, height: 74)
                .padding(.bottom, 20) // Bottom padding for the button
                .padding(.horizontal, 20) // Horizontal padding for better touch area
            }
            .background(Color.clear) // Ensure no overlap or extra padding affects layout
        }
    }
    
    func formattedTime(_ milliseconds: Int) -> String {
        var seconds = milliseconds / 1000
        var minutes = seconds / 60
        let hours = minutes / 60
        let ms = milliseconds % 1000

        var secondsString = seconds > 10 ? "\(seconds)" : "0\(seconds)"
        var minutesString = minutes > 10 ? "\(minutes)" : "0\(minutes)"

        if minutes > 0 {
            seconds = seconds - minutes*60
            secondsString = seconds > 10 ? "\(seconds)" : "0\(seconds)"
            
            if hours > 0 {
                minutes = minutes - hours*60
                minutesString = minutes > 10 ? "\(minutes)" : "0\(minutes)"
                
                return String(format: "%d:%@:%@.%03d", hours, minutesString, secondsString, ms)
            } else {
                return String(format: "0:%@:%@.%03d", minutesString, secondsString, ms)
            }
        } else {
            return String(format: "0:00:%@.%03d", secondsString, ms)
        }
    }

}


struct InfiniteTimer_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteTimer(intention: "State")
    }
}

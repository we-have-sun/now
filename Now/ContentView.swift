//
//  ContentView.swift
//  Now
//
//  Created by Natalia Terlecka on 13/04/2024.
//

import SwiftUI

struct AnimatedGradientCircleWithCountdown: View {
    @State private var isUp = false
    @State private var time = 1 // Time in minutes
    @State private var remainingTime: Int
    @State private var isActive = false
    @State private var intention = "" // State for storing user intention
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init() {
        _remainingTime = State(initialValue: 60) // Start with 1 minute
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            // Background Image
            Image("backgroundImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .frame(height: UIScreen.main.bounds.height - 140) // Adjust to push the bottom up

            VStack(spacing: 0) {
                // Text field for user intention
                TextField("Enter your intention", text: $intention)
                    .textFieldStyle(PlainTextFieldStyle()) // Using PlainTextFieldStyle for custom styling
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .padding(.horizontal, 20) // Adding horizontal padding for the text field

                // Time and Stepper on Top
                VStack {
                    Text("Time: \(time) minutes")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .cornerRadius(10)
                        .padding(.top, 20)

                    Stepper("Adjust Time", value: $time, in: 1...120)
                        .padding()
                        .cornerRadius(10)
                }

                Spacer() // Space between the controls and the circle

                // Gradient Circle with Mask
                Circle()
                    .fill(RadialGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]), center: .center, startRadius: 20, endRadius: 100))
                    .frame(width: 200, height: 200)
                    .mask(
                        PieSliceMask(startAngle: .degrees(-90), endAngle: .degrees(-89 + 360 * Double(remainingTime) / Double(time * 60)))
                            .frame(width: 200, height: 200)
                    )
                    .onAppear {
                        self.remainingTime = time * 60 // Initialize with total seconds
                    }
                    .onReceive(timer) { _ in
                        if self.isActive && self.remainingTime > 0 {
                            self.remainingTime -= 1
                        }
                    }

                Spacer(minLength: 300) // Push the circle up a bit
            }

            // Section at the bottom for the Start Countdown Button
            VStack {
                Button(action: {
                    self.isActive = true
                    self.remainingTime = time * 60 // Restart countdown
                }) {
                    Text("Start Countdown")
                        .foregroundColor(Color.brown) // Brown text color
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange) // Orange background
                        .cornerRadius(20)
                }
                .padding(.bottom, 20) // Bottom padding for the button
                .padding(.horizontal, 20) // Horizontal padding for better touch area
            }
            .background(Color.clear) // Ensure no overlap or extra padding affects layout
        }
        
        
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

struct AnimatedGradientCircleWithCountdown_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedGradientCircleWithCountdown()
    }
}

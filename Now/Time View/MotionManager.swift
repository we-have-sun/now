//
//  File.swift
//  Now
//
//  Created by Nicho on 05/06/2024.
//
import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    private var motionManager = CMMotionManager()
    @Published var shadowOffset: CGSize = .zero
    
    init() {
        startMotionUpdates()
    }
    
    func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (data, error) in
                guard let data = data else { return }
                self?.updateShadowOffset(data)
            }
        }
    }
    
    private func updateShadowOffset(_ data: CMDeviceMotion) {
        // Map gravity values to shadow offset
        let x = data.gravity.x * 10  // Adjust the multiplier as needed
        let y = data.gravity.y * 10  // Adjust the multiplier as needed
        shadowOffset = CGSize(width: x, height: y)
    }
}


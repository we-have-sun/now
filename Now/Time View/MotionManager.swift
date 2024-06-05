//
//  File.swift
//  Now
//
//  Created by Nicho on 05/06/2024.
//

import Foundation


class MotionManager: ObservableObject {
    private var motionManager = CMMotionManager()
    @Published var shadowOffset: CGSize = .zero
    
    init() {
        startMotionUpdates()
    }
    
    func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (data, error) in
                guard let data = data else { return }
                self?.updateShadowOffset(data)
            }
        }
    }
    
    private func updateShadowOffset(_ data: CMDeviceMotion) {
        // Assume maximum tilt results in a maximum shadow offset of 20 points
        let maxOffset: CGFloat = 20
        let x = CGFloat(data.gravity.x) * maxOffset
        let y = CGFloat(data.gravity.y) * maxOffset
        shadowOffset = CGSize(width: -x, height: -y)
    }
}

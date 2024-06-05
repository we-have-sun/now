//
//  RunningSun.swift
//  Now
//
//  Created by Natalia Terlecka on 03/06/2024.
//

import Foundation
import SwiftUI

class RunningSun: ObservableObject {
    var permanentSun: Sun
    @Published var timeInMs: Int? = 0
    
    private var timer: DispatchSourceTimer?
    private let queue = DispatchQueue.main
    private let interval: TimeInterval = 0.001
    private var startDate: Date? = nil

    init(sun: Sun) {
        self.permanentSun = sun
    }
    
    func start() {
        startDate = Date()
        
        let timer = DispatchSource.makeTimerSource(queue: queue)
        timer.schedule(deadline: .now(), repeating: interval)
        timer.setEventHandler(handler: DispatchWorkItem(block: {
            if let startDate = self.startDate {
                self.timeInMs = -Int(startDate.timeIntervalSinceNow * 1000)
            }
        }))
        self.timer = timer
        timer.resume()
    }

    func stop() {
        permanentSun.timeInMs = timeInMs
        timer?.cancel()
        timer = nil
    }

}

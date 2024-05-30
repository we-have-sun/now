//
//  Sun.swift
//  Now
//
//  Created by Natalia Terlecka on 30/05/2024.
//

import Foundation

class Sun: ObservableObject {
    var name: String
    @Published var timeInMs: Int = 0
    
    private var timer: DispatchSourceTimer?
    private let queue = DispatchQueue.main
    private let interval: TimeInterval = 0.001
    private var startDate: Date? = nil
    
    init(name: String) {
        self.name = name
    }
    
    func start() {
        startDate = Date()
        
        print("start")
        let timer = DispatchSource.makeTimerSource(queue: queue)
        timer.schedule(deadline: .now(), repeating: interval)
        timer.setEventHandler(handler: DispatchWorkItem(block: {
            print("working")

            if let startDate = self.startDate {
                self.timeInMs = -Int(startDate.timeIntervalSinceNow * 1000)
            }
        }))
        self.timer = timer
        timer.resume()
    }

    func stop() {
        timer?.cancel()
        timer = nil
    }

    deinit {
        stop()
    }
}

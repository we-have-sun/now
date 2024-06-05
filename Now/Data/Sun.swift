//
//  Sun.swift
//  Now
//
//  Created by Natalia Terlecka on 30/05/2024.
//

import Foundation
import SwiftData

@Model
class Sun: ObservableObject {
  
    var name: String
    var timeInMs: Int? = 10_800_000
    var hue = Double.random(in: 40...55)
    var id: UUID = UUID()
    
    init(name: String) {
        self.name = name
    }
    
}


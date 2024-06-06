//
//  NowApp.swift
//  Now
//
//  Created by Natalia Terlecka on 13/04/2024.
//

import SwiftUI
import SwiftData

@main
struct NowApp: App {
    var body: some Scene {
        WindowGroup {
            SunsView()
        }
        .modelContainer(for: Sun.self)

    }
}

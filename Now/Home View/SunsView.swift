//
//  SunsView.swift
//  Now
//
//  Created by Natalia Terlecka on 30/05/2024.
//

import Foundation
import SwiftUI


struct SunsView: View {

//    let cloudKitManager = CloudKitManager()

    @State private var intention = "Training"
    @State private var allIntentios = ["We Have Sun", "Training", "Meditation", "Reading", "Uncut", "Beats"]

    @State private var selectedString: Int? = 0


    init() {
        getStrings()
    }
    
    func getStrings() {
//        cloudKitManager.fetchStrings { strings in
//            if let strings = strings {
//                self.allIntentios = strings
//            }
//        }
    }
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color(red: 251, green: 250, blue: 249)
                
                VStack() {
                    Spacer(minLength: 100)
                    SnappingHorizontalScrollView(userStrings: allIntentios, selectedString: $selectedString)
                    Spacer()
                }
            }
        }
    }
}


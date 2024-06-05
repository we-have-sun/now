//
//  SunsView.swift
//  Now
//
//  Created by Natalia Terlecka on 30/05/2024.
//

import Foundation
import SwiftUI
import SwiftData


struct SunsView: View {

    @State private var intention = "Training"
    @State private var allIntentios = ["We Have Sun", "Training", "Meditation", "Reading", "Uncut", "Beats"]

    @State private var selectedString: Int? = 0

    @Query var suns: [Sun]
    @Environment(\.modelContext) var modelContext
    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]

    var body: some View {
        NavigationStack {
            
            ZStack {
                Color(red: 251, green: 250, blue: 249)
                
                VStack() {
                    Spacer(minLength: 100)
                    SnappingHorizontalScrollView(userStrings: allIntentios, selectedString: $selectedString)
                    Spacer()
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
//                            ForEach(suns, id: \.self) { sun in
//                                InfiniteSun(hue: sun.permanentSun.hue, duration: sun.$timeInMs)
//                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxHeight: 300)
                    Spacer()
                }
            }
        }
    }
}


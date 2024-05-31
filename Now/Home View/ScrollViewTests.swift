//
//  ScrollViewTests.swift
//  Now
//
//  Created by Natalia Terlecka on 31/05/2024.
//

import Foundation
import SwiftUI

struct HCardsScrollView: View {
    
    @State private var allIntentios = ["Training", "Meditation", "Reading", "Exercise", "Work"]

    @State private var selectedString: Int? = 0
    let colorSets: [Color] = [
        .red, .green, .blue,
        .yellow, .purple, .pink,
        .accentColor, .black, .brown,
        .cyan, .indigo, .teal,
        .orange, .mint
    ]

    
    var body: some View {
        GeometryReader { reader in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(allIntentios.indices, id: \.self) { index in
                        let color = colorSets[index].opacity(0.8)
                        Rectangle()
                            .foregroundStyle(color)
                            .frame(width: reader.size.width, height: reader.size.height)
                            .tag(index)

                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $selectedString)
        }
        .edgesIgnoringSafeArea(.all)
        // MARK: - Fast Scroll container
        .overlay (alignment: .top) {
            FastScrollView(strings: allIntentios, selectedString: $selectedString)
                .frame(height: 96)
                .safeAreaPadding(.horizontal, 16)
        }
    }
}




struct FastScrollView: View {
    
    var strings: [String]
    @Binding var selectedString: Int?
    
    var body: some View {
        ZStack {
            ScrollViewReader { reader in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(strings.indices, id: \.self) { index in
                            let text = strings[index]
                            let color = Color.black.opacity(0.8)
                            Text(text)
                                .font(.largeTitle)
                                .foregroundStyle(color)
//                                .frame(width: 80, height: 80)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: selectedString == index ? 8 : 0)
                                        .foregroundStyle(Material.bar)
                                )
                                .padding(.top, 12)
                                .padding(.bottom, 12)
                                .padding(.leading, 40)
                                .padding(.trailing, 40)
                                .tag(index)
                                .onTapGesture {
                                    withAnimation(.spring) {
                                        self.selectedString = index
                                        reader.scrollTo(index, anchor: .center)
                                    }
                                }
                                .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1 : 0.5)
                                        .scaleEffect(phase.isIdentity ? 1 : 0.55)
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .onChange(of: selectedString, { oldValue, newValue in
                    withAnimation(.spring) {
                        reader.scrollTo(selectedString ?? 0, anchor: .center)
                    }
                })
            }
        }
    }
}

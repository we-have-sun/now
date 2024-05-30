//
//  SnappingHorizontalScrollView.swift
//  Now
//
//  Created by Natalia Terlecka on 30/05/2024.
//

import SwiftUI

struct SnappingHorizontalScrollView: View {
    var userStrings: [String]
    @State private var selectedIndex = 0
    @State private var scrollOffset: CGFloat = 0.0
    @State private var draggingOffset: CGFloat = 0.0
    @State private var isDragging = false

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("START")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(userStrings.indices, id: \.self) { index in
                            NavigationLink(destination: InfiniteTimer(intention: userStrings[index])) {
                                Text(userStrings[index])
                                    .font(.title)
                                    .padding(.horizontal)
                                    .foregroundColor(.black)
                                    .opacity(opacity(for: index))
                            }
                        }
                    }
                    .padding(.horizontal, (geometry.size.width / 3) / 2)
                    .background(GeometryReader { innerGeometry in
                        Color.clear.preference(key: ScrollOffsetKey.self, value: innerGeometry.frame(in: .global).minX)
                    })
                    .onPreferenceChange(ScrollOffsetKey.self) { value in
                        if isDragging {
                            draggingOffset = value - scrollOffset
                        } else {
                            scrollOffset = value
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                isDragging = true
                                draggingOffset = value.translation.width
                            }
                            .onEnded { value in
                                isDragging = false
                                scrollOffset += value.translation.width
                                draggingOffset = 0
                                snapToNearestItem(in: geometry.size.width)
                            }
                    )
                    .offset(x: scrollOffset + draggingOffset)
                }
            }
        }
        .animation(.easeInOut, value: scrollOffset)
    }

    private func opacity(for index: Int) -> Double {
        return index == selectedIndex ? 1.0 : 0.5
    }

    private func snapToNearestItem(in width: CGFloat) {
        let itemWidth = width / 3 + 20 // Account for item width plus spacing
        let offset = scrollOffset / itemWidth
        let index = round(offset)
        selectedIndex = max(0, min(userStrings.count - 1, Int(-index)))
        withAnimation {
            scrollOffset = -CGFloat(selectedIndex) * itemWidth
        }
    }
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct SnappingHorizontalScrollView_Previews: PreviewProvider {
    static var previews: some View {
        SnappingHorizontalScrollView(userStrings: ["stuff"])
    }
}

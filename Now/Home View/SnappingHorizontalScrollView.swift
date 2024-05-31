//
//  SnappingHorizontalScrollView.swift
//  Now
//
//  Created by Natalia Terlecka on 30/05/2024.
//

import SwiftUI

struct SnappingHorizontalScrollView: View {
    var userStrings: [String]
    @Binding var selectedString: Int?

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("START")
                HStack {
                    Spacer()
                    
                    TabView {
                        ForEach(userStrings.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                VStack {
                                    NavigationLink(destination: InfiniteTimer(intention: userStrings[index])) {
                                        Text(userStrings[index])
                                            .font(.system(size: 36, weight: .bold, design: .rounded))
                                            .foregroundColor(.black)
                                            .opacity(opacity(for: index))
                                    }
                                    .frame(width: geometry.size.width, height: 68)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .frame(width: geometry.size.width, height: 108)
                    .tabViewStyle(PageTabViewStyle())
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                    .scrollClipDisabled()
                    
                    Spacer()
                }
//                ZStack {
//                    HStack {
//                        Spacer()
//
//                        ScrollViewReader { reader in
//                            
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                ZStack {
//                                    Color(.blue)
//                                    HStack {
//                                        ForEach(userStrings.indices, id: \.self) { index in
//                                            NavigationLink(destination: InfiniteTimer(intention: userStrings[index])) {
//                                                Text(userStrings[index])
//                                                    .font(.system(size: 36, weight: .bold, design: .rounded))
//                                                    .foregroundColor(.black)
//                                                    .opacity(opacity(for: index))
//                                            }
//                                            .frame(width: geometry.size.width*0.7)
//                                        }
//                                    }
//                                }
//                            }
//                            .scrollTargetBehavior(.paging)
//                            .scrollClipDisabled()
//                            .frame(width: geometry.size.width*0.7, height: 80)
//                            .edgesIgnoringSafeArea(.all)
//                        }
//                    }
//                    Spacer()
//                }
                Spacer()
            }
        }
    }

    private func opacity(for index: Int) -> Double {
//        return index == selectedString ? 1.0 : 0.5
        return 1.0
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
        SnappingHorizontalScrollView(userStrings: ["stuff"], selectedString: .constant(1))
    }
}

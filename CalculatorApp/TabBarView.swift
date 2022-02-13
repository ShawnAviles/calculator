//
//  TabBarView.swift
//  CalculatorApp
//
//  Created by Shawn Aviles on 10/14/21.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selection: Int
    @Namespace private var currentTab
    
    var body: some View {
        HStack(alignment: .bottom) {
            // views
            ForEach(tabs.indices) {index in
                GeometryReader { geometry in
                    VStack(spacing: 4) {
                        if selection == index {
                            Color(.label) // .label knows if dark or light mode
                                .frame(height: 2)
                                .offset(y: -8)
                                .matchedGeometryEffect(id: "currentTab", in: currentTab)
                        }
                        
                        // rotate animation
                        if tabs[selection].label == "Calculator" && tabs[index].label == "Calculator" {
                            Image(systemName: tabs[index].image)
                                .frame(height: 20)
                                .rotationEffect(.degrees(360))
                        }
                        else {
                            Image(systemName: tabs[index].image)
                                .frame(height: 20)
                                .rotationEffect(.degrees(360))
                        }
                        
                        Text(tabs[index].label)
                            .font(.caption2)
                            .fixedSize()
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: geometry.size.width / 2, height: 44, alignment: .bottom)
                    .padding(.horizontal)
                    .foregroundColor(selection == index ? Color(.label) : .secondary)
                    .onTapGesture {
                        withAnimation {
                            selection = index
                        }
                    }
                }
                .frame(height: 44, alignment: .bottom)
            }
        }
        .offset(x: 20)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selection: Binding.constant(0))
            .previewLayout(.sizeThatFits)
    }
}

struct Tab {
    let image: String
    let label: String
}

let tabs = [
    Tab(image: "plus.forwardslash.minus", label: "Calculator"),
    Tab(image: "map.fill", label: "Map"),
    Tab(image: "pencil.circle", label: "third")
]

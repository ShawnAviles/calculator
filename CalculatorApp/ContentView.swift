//
//  ContentView.swift
//  CalculatorApp
//
//  Created by Shawn Aviles on 10/10/21.
//

import SwiftUI

// calculator's view being displayed on screen
struct ContentView: View {
    @State private var selection = 0
    
    // display
    var body: some View {
        VStack {
            TabView (selection: $selection){
                CalculatorView()
                    .tag(0)
                MapView()
                    .tag(1)
                GameView()
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            Divider()
            // tab bar
            TabBarView(selection: $selection)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

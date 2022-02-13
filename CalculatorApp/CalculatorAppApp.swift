//
//  CalculatorAppApp.swift
//  CalculatorApp
//
//  Created by Shawn Aviles on 10/10/21.
//

import SwiftUI

@main
struct CalculatorAppApp: App {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor.white]
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

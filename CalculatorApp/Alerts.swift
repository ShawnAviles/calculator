//
//  Alerts.swift
//  CalculatorApp
//
//  Created by Shawn Aviles on 10/19/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin     = AlertItem(title: Text("You Win!"),
                             message: Text("You are so smart!"),
                             buttonTitle: Text("Heck Yeah :)"))
    
    static let computerWin  = AlertItem(title: Text("You Lost!"),
                             message: Text("How'd you lose?"),
                             buttonTitle: Text("Rematch"))
    
    static let draw         = AlertItem(title: Text("Draw!"),
                             message: Text("What a battle of wits"),
                             buttonTitle: Text("Try Again"))
}

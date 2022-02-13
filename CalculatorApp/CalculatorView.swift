//
//  CalculatorView.swift
//  CalculatorApp
//
//  Created by Shawn Aviles on 10/14/21.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case substract = "-"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"
    
    var buttonColor: Color {
        switch self {
        case .add, .substract, .multiply, .divide, .equal:
            return .blue
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

// calculator backend and UI itself (view)
struct CalculatorView: View {
    
    @State var value = "0"  // value of "answer" on top
    @State var runningNumber = Float(0.0)
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .substract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        ZStack {
            //Color.black.edgesIgnoringSafeArea(.all) // make background of app black including notch area
            
            VStack {
                Spacer()
                
                // Text Display
                HStack {  //horizontal stack
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 80))
                        .foregroundColor(Color(.label))
                        .lineLimit(1)
                }
                .padding()
                
                // Our Buttons
                ForEach(buttons, id: \.self) { row in
                    HStack (spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 2)
                }
            }
            .padding()
        }
    }
    
    // did user press (tap) a button
    func didTap(button: CalcButton) {
        switch button {
        case .add, .substract, .multiply, .divide, .equal:
            if button == .add{
                self.currentOperation = .add
                self.runningNumber = Float(self.value) ?? 0
            }
            else if button == .substract {
                self.currentOperation = .subtract
                self.runningNumber = Float(self.value) ?? 0
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Float(self.value) ?? 0
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber = Float(self.value) ?? 0
            }
            else if button == .equal{
                let runningValue = self.runningNumber
                let currentValue = Float(self.value) ?? 0
                
                if (currentValue == 0){
                    break
                }
                
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
                
                // properly display number as having decimals or not having decimals
                let output = Float(self.value) ?? 0
                if ((output - (Float(Int(output)))) == 0) {
                    self.value = "\(Int(output))"
                }
            }
            
            // resets value after hitting operator that not "="
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .percent, .decimal, .negative:
            let currentValue = Float(self.value) ?? 0
            if button == .percent {
                self.value = "\(currentValue / 100)"
            }
            else if button == .decimal {
                if (self.value.contains(".")){
                    break
                }
                self.value = "\(Int(currentValue))\(".")"
            }
            else if button == .negative {
            
                if ((currentValue - (Float(Int(currentValue)))) == 0) {
                    self.value = "\(Int(currentValue) * -1)"
                }
                else {
                    self.value = "\(currentValue * -1)"
                }
            }
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    
    // returns value of each button width
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    // returns value of each button height
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}

//
//  GameView.swift
//  CalculatorApp
//
//  Created by Shawn Aviles on 10/18/21.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var vM = GameViewModel() // viewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Tic-Tac-Toe")
                    .bold()
                    .font(.system(size: UIScreen.main.bounds.width*1/10))
                    .foregroundColor(Color(.label))
                    .lineLimit(1)
                Spacer()
                LazyVGrid(columns: vM.columns, spacing: 10) {
                    ForEach(0..<9) {i in
                        ZStack {
                            GameSquareView(proxy: geometry)
                            PlayerIndicator(proxy: geometry, systemImageName:  vM.moves[i]?.indicator ?? "")
                        }
                        .onTapGesture {
                            vM.processPlayerMove(for: i)
                        }
                    }
                }
                Spacer()
            }
            .disabled(vM.isGameboardDisabled)
            .padding()
            .alert(item: $vM.alertItem, content: { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: { vM.resetGame() }))
            })
        }
    }
}

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark": "circle"
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

struct GameSquareView: View {
    
    var proxy: GeometryProxy
    
    var body: some View {
        Circle()
            .foregroundColor(.blue).opacity(0.5)
            .frame(width: proxy.size.width/3 - 15 ,
                   height: proxy.size.width/3 - 15)
    }
}

struct PlayerIndicator: View {
    
    var proxy: GeometryProxy
    var systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: proxy.size.width/3 - 75, height: proxy.size.width/3 - 75)
            .foregroundColor(Color(.label))
    }
}

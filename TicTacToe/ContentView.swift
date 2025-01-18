//
//  ContentView.swift
//  TicTacToe
//
//  Created by Hemant Mehta on 31/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var TicTacToe=TicTacToeGame()
    
    var body: some View {
        VStack {
            Text("Welcome to the Game of Tic Tac Toe")
            
            Text("Time Remaining: \(TicTacToe.timeRemaining) seconds")
                            .font(.headline)
                            .foregroundColor(.red)
                            .padding()
            
            
            let col=Array(repeating: GridItem(.flexible()), count: 3)
            
            LazyVGrid(columns: col,content:{
                ForEach(0..<9) { row in
                   
                        Button(action: {
                            TicTacToe.buttonTapped(i: row)
                        }) {
                            Text(TicTacToe.buttonLabel(i: row))
                                .frame(width: 50, height: 50)
//                                .foregrp
                                .foregroundColor(.black)
                                .font(.title)
                                .fontWeight(.bold)
                               
                        }
                        .background(.mint)
                    }
            })
            Button(action:{
                TicTacToe.resetGame()
            },label: {
                Text("Play Again")
                    .clipShape(.capsule)
            })
        }
        .padding()
        .onAppear(){
            TicTacToe.starttimer()
        }
    }
    
}

#Preview {
    ContentView()
}

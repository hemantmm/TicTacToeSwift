//
//  game.swift
//  TicTacToe
//
//  Created by Hemant Mehta on 31/12/24.
//

import Foundation


enum Player{
    case X
    case O
}


class TicTacToeGame:ObservableObject{
    
    @Published var board:[Player?] = Array(repeating: nil, count: 9)
    @Published var activePlayer: Player = .X
    @Published var winner: Player?=nil
    @Published var timeRemaining: Int = 20
    
    var timer: Timer?
    
    func buttonTapped(i: Int){
        
        guard board[i]==nil && winner==nil else{
            return
        }
        
        board[i]=activePlayer
            
        if checkWinner(){
            winner = activePlayer
            print("\(activePlayer) has won the game")
            timer?.invalidate()
            autoReset()
        }
        else if board.allSatisfy({$0 != nil}){
            print("Match Draw")
            timer?.invalidate()
            autoReset()
        }
        else {
            activePlayer=activePlayer == .X ? .O : .X
            starttimer()
        }
        
    }
    
    func buttonLabel(i: Int) -> String{
        if let player = board[i]
        {
            return player == .X ? "X" : "O"
        }
        else{
            return ""
        }
    }
    
    func resetGame(){
        board = Array(repeating: nil, count: 9)
        activePlayer = .X
        winner=nil
        starttimer()
    }
    
    @objc func checkWinner() -> Bool{
         
        // Rows
        for i in stride(from: 0, to: 9, by: 3){
            if board[i]==activePlayer && board[i+1]==activePlayer && board[i+2]==activePlayer{
                return true
            }
        }
        
        // Columns
        
        for i in 0..<3{
            if board[i]==activePlayer && board[i+3]==activePlayer && board[i+6]==activePlayer{
                return true
            }
        }
        
        // Diagonals
        
        if board[0]==activePlayer && board[4]==activePlayer && board[8]==activePlayer{
            return true
        }
        
        if board[2]==activePlayer && board[4]==activePlayer && board[6]==activePlayer{
            return true
        }
        
        return false
    }
    
    func autoReset(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.resetGame()
        }
    }
    
    func starttimer(){
        timer?.invalidate()
        timeRemaining=20
        timer=Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.timeRemaining-=1
                if self.timeRemaining==0{
                    self.timer?.invalidate()
                    self.timeout()
            }
        }
    }
    
    func timeout(){
        print("\(activePlayer) ran out of time!")
        activePlayer=activePlayer == .X ? .O : .X
    }
    
}

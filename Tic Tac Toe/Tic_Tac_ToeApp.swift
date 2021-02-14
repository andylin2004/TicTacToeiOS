//
//  Tic_Tac_ToeApp.swift
//  Tic Tac Toe
//
//  Created by Andy Lin on 2/13/21.
//

import SwiftUI

private var board: [[String]] = Array(repeating: ["", "", ""], count: 3)

@main
struct Tic_Tac_ToeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

func changeState(turn: Bool, x: Int, y: Int) -> String{
    board[x][y] = "x"
    print(x, y, board)
    return "x"
}

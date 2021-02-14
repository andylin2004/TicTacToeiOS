//
//  BoardView.swift
//  Tic Tac Toe
//
//  Created by Andy Lin on 2/13/21.
//

import SwiftUI

struct BoardView: View {
    private var threeColView = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        VStack{
            Text("Player 1 Turn")
            ZStack{
                Image("board")
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                LazyVGrid(columns: threeColView, spacing: 80){
                    Text("e")
                    Text("")
                    Text("")
                    Text("e")
                    Text("")
                    Text("")
                    Text("e")
                    Text("")
                    Text("e")
                }
            }
            
        }
        
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}

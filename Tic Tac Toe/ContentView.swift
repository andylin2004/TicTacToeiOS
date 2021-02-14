//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Andy Lin on 2/13/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Text("Tic Tac Toe")
                .font(.system(size: 75))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            NavigationLink(
                destination: BoardView(),
                label: {
                    Text("Play")
                        .font(.system(size: 50))
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

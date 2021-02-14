//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Andy Lin on 2/13/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Tic Tac Toe")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                NavigationLink(
                    destination: BoardView()){
                    Text("Play")
                        .font(.system(size: 25))
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

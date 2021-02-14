//
//  BoardView.swift
//  Tic Tac Toe
//
//  Created by Andy Lin on 2/13/21.
//

import SwiftUI

struct BoardView: View {
    private var threeColView = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    enum GridWidth: Preference{}
    let gridWidth = GeometryPreferenceReader(key: AppendValue<GridWidth>.self, value: {[$0.size.width]})
    @State var width: CGFloat? = nil
    //true is x, false is y
    @State var turn: Bool = true
    @State var alertWin: Bool = false
    @State var alertMessage: String = ""
    
    @State var board: [[String]] = Array(repeating: [" ", " ", " "], count: 3)
    @State var intPlayed: Int = 0
    
    var body: some View {
        VStack{
            Text("Player \(turn ? "1" : "2") Turn")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding(.bottom, 30)
            ZStack{
                Image("board")
                    .read(gridWidth)
                LazyVGrid(columns: threeColView, spacing: 40){
                    ForEach(0..<9){ number in
                        Button(action: {
                            if board[number/3][number%3] == " "{
                                board[number/3][number%3] = changeState(turn: turn, x: number/3, y: number%3)
                            intPlayed += 1
                            alertWin = checkForWin(x: number/3, y: number%3) || intPlayed == 9
                            turn = !turn
                            }
                        },
                               label: {
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.clear)
                                    Text(board[number/3][number%3])
                                        .font(.system(size: 50))
                                }
                                }
                        )
                    }
                }
                .padding(.all)
                .frame(width: width)
            }
            .assignMaxPreference(for: gridWidth.key, to: $width)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .alert(isPresented: $alertWin){
            Alert(title: Text(alertMessage))
        }
        
    }
    
    func changeState(turn: Bool, x: Int, y: Int) -> String{
        board[x][y] = turn ? "X" : "O"
        print(x, y, board)
        return turn ? "X" : "O"
    }
    
    func checkForWin(x: Int, y: Int) -> Bool{
        if intPlayed < 3 {return false}
        var allSame: Int = 0
        var result: Bool = false
        for index in 0...1{
            allSame += board[x][index] == board [x][index+1] ? 1 : 0
        }
        print(allSame)
        if allSame != 2{
            allSame = 0
            for index in 0...1{
                allSame += board[index][y] == board [index+1][y] ? 1 : 0
            }
            if allSame != 2{
                if x == 1 && y == 1{
                    result = diagonalUp() || diagonalDown()
                }else if x == y{
                    result = diagonalDown()
                }else if max(x, y) - 2 == y{
                    result = diagonalUp()
                }
            }else{
                result = true
            }
        }else{
            result = true
        }
        if intPlayed == 9{
            alertMessage = "It's a draw"
        }else if result{
            alertMessage = "Player \(turn ? "1" : "2") win!"
        }
        return result
    }
    
    func diagonalDown() -> Bool{
        var allSame: Int = 0
        for x in (0...1){
            allSame += board[x][x] == board[x+1][x+1] ? 1 : 0
        }
        return allSame == 2
    }
    
    func diagonalUp() -> Bool{
        var allSame: Int = 0
        for x in (0...1){
            allSame += board[x][2-x] == board[x+1][1-x] ? 1 : 0
        }
        return allSame == 2
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}

struct GeometryPreferenceReader<K: PreferenceKey, V> where K.Value == V {
    let key: K.Type
    let value: (GeometryProxy) -> V
}

extension GeometryPreferenceReader: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(GeometryReader {
                Color.clear.preference(key: self.key,
                                       value: self.value($0))
            })
    }
}

protocol Preference {}

struct AppendValue<T: Preference>: PreferenceKey {
    static var defaultValue: [CGFloat] { [] }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
    typealias Value = [CGFloat]
}

extension View {
    func assignMaxPreference<K: PreferenceKey>(
        for key: K.Type,
        to binding: Binding<CGFloat?>) -> some View where K.Value == [CGFloat] {

        return self.onPreferenceChange(key.self) { prefs in
            let maxPref = prefs.reduce(0, max)
            if maxPref > 0 {
                // only set value if > 0 to avoid pinning sizes to zero
                binding.wrappedValue = maxPref
            }
        }
    }

    func read<K: PreferenceKey, V>(_ preference: GeometryPreferenceReader<K, V>) -> some View {
        modifier(preference)
    }
}

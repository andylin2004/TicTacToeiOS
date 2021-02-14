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
    
    @State var board: [[String]] = Array(repeating: ["    ", "    ", "    "], count: 3)
    
    var body: some View {
        VStack{
            Text("Player 1 Turn")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding(.bottom, 30)
            ZStack{
                Image("board")
                    .read(gridWidth)
                LazyVGrid(columns: threeColView, spacing: 40){
                    Button(action: {board[0][0] = changeState(turn: false, x: 0, y: 0)}, label: {
                        Text(board[0][0])
                    })
                    .background(Color.green)
                    .font(.system(size: 50))
                    Button(action: {board[0][0] = changeState(turn: false, x: 0, y: 0)}, label: {
                        Text(board[0][0])
                    })
                    .background(Color.blue)
                    .font(.system(size: 50))
                    Button(action: {board[0][0] = changeState(turn: false, x: 0, y: 0)}, label: {
                        Text(board[0][0])
                    })
                    .background(Color.blue)
                    .font(.system(size: 50))
                    Button(action: {board[0][0] = changeState(turn: false, x: 0, y: 0)}, label: {
                        Text(board[0][0])
                    })
                    .background(Color.blue)
                    .font(.system(size: 50))
                    Button(action: {board[0][0] = changeState(turn: false, x: 0, y: 0)}, label: {
                        Text(board[0][0])
                    })
                    .background(Color.blue)
                    .font(.system(size: 50))
                    Button(action: {board[0][0] = changeState(turn: false, x: 0, y: 0)}, label: {
                        Text(board[0][0])
                    })
                    .background(Color.blue)
                    .font(.system(size: 50))
                    Button(action: {board[0][0] = changeState(turn: false, x: 0, y: 0)}, label: {
                        Text(board[0][0])
                    })
                    .background(Color.blue)
                    .font(.system(size: 50))
                    Button(action: {board[0][0] = changeState(turn: false, x: 0, y: 0)}, label: {
                        Text(board[0][0])
                    })
                    .background(Color.blue)
                    .font(.system(size: 50))
                    Button(action: {board[0][0] = changeState(turn: false, x: 0, y: 0)}, label: {
                        Text(board[0][0])
                    })
                    .background(Color.blue)
                    .font(.system(size: 50))
                }
                .padding(.all)
                .frame(width: width)
            }
            .assignMaxPreference(for: gridWidth.key, to: $width)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
        }
        
    }
}

struct BoaedView_Previews: PreviewProvider {
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

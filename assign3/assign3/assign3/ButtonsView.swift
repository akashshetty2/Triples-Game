//
//  ButtonsView.swift
//  assign3
//
//  Created by Akash Shetty on 4/14/21.
//

import Foundation

import SwiftUI



struct ButtonsView: View {
    @ObservedObject var triples = Triples()
    @EnvironmentObject var list: GlobalHighScoreList
    @State var gametype = true
    @State var finished = false
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    var body: some View {
        
        if (verticalSizeClass == .regular) {
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.vertical)
                .overlay(
            VStack {
                
                Text("Score:    \(triples.getScore())").font(.system(size: 20))
                VStack {
                    
                    ForEach(0..<4, id: \.self) { i in
                            HStack{
                                ForEach(0..<4, id:\.self) { j in
                                    TileView(tile: triples.board[i][j]!)
                                }
                            }
                        }
                }.offset(y: 30)
                
                .gesture(
                    DragGesture(minimumDistance: 12.5)
                        .onEnded { value in
                            if value.translation.width < 0 && abs(value.translation.width) > abs(value.translation.height) {
                                left()
                            }
                            
                            else if value.translation.width > 0 && abs(value.translation.width) > abs(value.translation.height) {
                                right()
                            }
                            
                            else if value.translation.height < 0  {
                                up()
                            }
                            
                            else if value.translation.height > 0 {
                                down()
                            }
                        })

                VStack {
                    Button("up", action: up)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(Color.black)
                        .cornerRadius(5)
                    HStack {
                        Button("left" , action: left)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(Color.black)
                            .cornerRadius(5)
                        Text("                         ")
                        Button("right", action: right)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(Color.black)
                            .cornerRadius(5)
                        }
                    Button("down" , action: down)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(Color.black)
                        .cornerRadius(5)
                }.offset(y: 35)
                
                VStack {
                    Button("New Game?" , action: newGame)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(Color.black)
                        .cornerRadius(5)
                    Picker(selection: $gametype, label: Text("Gametype")) {
                            Text("Random").tag(true)
                            Text("Determ").tag(false)
                        }.pickerStyle(SegmentedPickerStyle())
                }.offset(y: 125)
            
            }.alert(isPresented: $finished) {
                Alert(
                    title: Text("Game Over"),
                    message: Text("No more possible moves, your score: \(triples.getScore())"),
                    dismissButton: .default(Text("New Game"), action: {
                        newGame()
                        finished = false
                    }))
            }.frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading)
            )
        } else {
            
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.horizontal)
                .overlay(
            HStack {
                
                
                VStack {
                    Text("Score:    \(triples.getScore())").font(.system(size: 20))
                    ForEach(0..<4, id: \.self) { i in
                            HStack{
                                ForEach(0..<4, id:\.self) { j in
                                    TileView(tile: triples.board[i][j]!)
                                }
                            }
                        }
                } .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width < 0 && abs(value.translation.width) > abs(value.translation.height) {
                                left()
                            }
                            
                            else if value.translation.width > 0 && abs(value.translation.width) > abs(value.translation.height) {
                                right()
                            }
                            
                            else if value.translation.height < 0  {
                                up()
                            }
                            
                            else if value.translation.height > 0 {
                                down()
                            }
                        })
                VStack {
                    Button("up", action: up)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(Color.black)
                        .cornerRadius(5)
                    HStack {
                        Button("left" , action: left)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(Color.black)
                            .cornerRadius(5)
                        Text("                         ")
                        Button("right", action: right)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(Color.black)
                            .cornerRadius(5)
                        }
                    Button("down" , action: down)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(Color.black)
                        .cornerRadius(5)
                    
                    
                    Button("New Game?" , action: newGame)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(Color.black)
                        .cornerRadius(5)
               
                    Picker(selection: $gametype, label: Text("Gametype")) {
                            Text("Random").tag(true)
                            Text("Determ").tag(false)
                        }.pickerStyle(SegmentedPickerStyle())
                }.offset(y: 20)
            }.alert(isPresented: $finished) {
                Alert(
                    title: Text("Game Over"),
                    message: Text("No more possible moves, your score: \(triples.getScore())"),
                    dismissButton: .default(Text("New Game"), action: {
                        newGame()
                        finished = false
                    }))
            }.frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading)
            )
        }
        
        
    }
    
    func up() {
        triples.collapse(dir: Triples.Direction.up)
        finished = triples.isGameDone()
    }
    //
    func left() {
        triples.collapse(dir: Triples.Direction.left)
        finished = triples.isGameDone()
    }
    
    func right() {
        triples.collapse(dir: Triples.Direction.right)
        finished = triples.isGameDone()
    }
    
    func down() {
        triples.collapse(dir: Triples.Direction.down)
        finished = triples.isGameDone()
    }
    
    func newGame() {
        let newElement = Triples.Score(score: triples.getScore(), time: Date())
        list.add_score(element: newElement)
        triples.newgame(rand: gametype)
        triples.spawn()
        triples.spawn()
        triples.spawn()
        triples.spawn()
        print("hello")
    }

}

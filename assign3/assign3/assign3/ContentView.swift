//
//  ContentView.swift
//  assign3
//
//  Created by Akash Shetty on 4/11/21.
//

import SwiftUI




class GlobalHighScoreList: ObservableObject {
    @Published var highScores: [Triples.Score] = [] 
    
    init() {
        let newElement300 = Triples.Score(score: 300, time:Date())
        let newElement400 = Triples.Score(score: 400, time:Date())
        self.add_score(element: newElement300)
        self.add_score(element: newElement400)
    }
    
    func add_score (element: Triples.Score) {
        
        highScores.append(element)
        highScores.sort {$0.score > $1.score}
    }
}




struct ContentView: View {
    var highScores:GlobalHighScoreList = GlobalHighScoreList()
    var body: some View {
        TabView {
            ButtonsView().tabItem {
                Label("Board", systemImage: "gamecontroller")
            }
            HighScoreView().tabItem {
                Label("HighScores", systemImage: "list.dash")
            }
            AboutView().tabItem {
                Label("About", systemImage: "info.circle" )
            }
        }.environmentObject(highScores)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        ButtonView()
    }
}





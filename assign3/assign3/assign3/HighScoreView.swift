//
//  HighScoreView.swift
//  assign3
//
//  Created by Akash Shetty on 4/14/21.
//

import Foundation

import SwiftUI



struct HighScoreView: View {
    
    @EnvironmentObject var highScores: GlobalHighScoreList
    
    var body: some View {
        
        VStack {
            Text("High Scores").font(.system(size: 30))
            
        
            List(-1..<highScores.highScores.count , id:\.self) { element in
                
                if (element == -1) {
                    Text("  ")
                    Text("Date").font(.system(size: 20))
                    Text("                             ")
                    Text("Scores").font(.system(size: 20))
                } else {
                    let calendar = Calendar.current
                    let month = calendar.component(.month, from: highScores.highScores[element].time)
                    let day = calendar.component(.day, from: highScores.highScores[element].time)
                    
                    Text("\(element + 1))")
                    Text("\(month)-\(day)")
                    Text("                             ")
                    Text("\(highScores.highScores[element].score)")
                }
            }
        }
        
    }
}

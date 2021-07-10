//
//  TileView.swift
//  assign3
//
//  Created by Akash Shetty on 4/14/21.
//

import Foundation

import SwiftUI


struct TileView: View {
    var tile = Triples.Tile(val: 0, id: 0, row: 0, col: 0)

    
    init(tile: Triples.Tile) {
        self.tile = tile
    }
    
    func colorDecider() -> Color {
        
        if (tile.val == 0) {
            return Color.gray
        } else if (tile.val == 1) {
            return Color.blue
        } else if (tile.val == 2){
            return Color.pink
        } else {
            return Color.white
        }
    }
    
    func cellVal() -> String {
        if (tile.val == 0) {
            return ""
        } else {
            return "\(tile.val)"
        }
    }

    var body: some View {
        
        Text(self.cellVal()).font(.system(size: 20))
            .frame(width: 30, height: 30)
            .padding()
            .background(self.colorDecider())
            .overlay(Rectangle().stroke(Color.black, lineWidth: 4))
            .animation(.easeIn(duration: 0.25))
        
    }
}

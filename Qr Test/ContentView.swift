//
//  ContentView.swift
//  Qr Test
//
//  Created by Tyler Radke on 6/6/23.
//

import SwiftUI
import CodeScanner

struct ContentView: View {
    var body: some View {
        VStack {
            Text("This is my first view!")
            
            Button("Press to svan") {
                scanButtonPressed()
            }
        }
        .padding()
    }
    
    func scanButtonPressed() {
        
    }
}

#Preview {
    ContentView()
}

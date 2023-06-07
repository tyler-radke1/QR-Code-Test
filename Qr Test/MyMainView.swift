//
//  ContentView.swift
//  Qr Test
//
//  Created by Tyler Radke on 6/6/23.
//

import CodeScanner
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MyMainView: View {
    
    @State private var isShowingScanner = false
    @State private var isShowingSecondView = false
    
    var body: some View {
        VStack {
            Text("This is my first view!")
            
            Button("Press to scan") {
                scanButtonPressed()
            }
        }
        .padding()
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "Testing") { result in
                handleScan(result: result)
            }
        }
        
        .sheet(isPresented: $isShowingSecondView, content: {
            MySecondView()
        })
        
    }
    
    func scanButtonPressed() {
        isShowingScanner = true
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        //handle result
        
        switch result {
        case .success(let result):
            let string = result.string
            print(string)
            isShowingSecondView = true
        case .failure(let error):
            print("\(error.localizedDescription)")
        }
    }
}

#Preview {
    MyMainView()
}

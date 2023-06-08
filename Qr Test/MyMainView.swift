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
    @State private var teamScanned: Team?
    
    var body: some View {
        VStack {
            Text("This is my first view!")
            
            Button("Press to scan") {
                scanButtonPressed()
            }
        }
        .padding()
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr]) { result in
                handleScan(result: result)
            }
        }
        
        .sheet(isPresented: $isShowingSecondView, content: {
            MySecondView(teamScanned: teamScanned)
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
            handleScanString(string: string)
        case .failure(let error):
            print("\(error.localizedDescription)")
        }
    }
    
    private func handleScanString(string: String) {
        let scannedTeam = Team.dummyTeams.first(where: { $0.id.uuidString == string })
        
        teamScanned = scannedTeam
        
        isShowingSecondView = true
    }
}

struct MyMainView_Previews: PreviewProvider {
    static var previews: some View {
        MyMainView()
    }
}

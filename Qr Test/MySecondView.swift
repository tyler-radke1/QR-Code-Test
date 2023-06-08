//
//  MySecondView.swift
//  Qr Test
//
//  Created by Tyler Radke on 6/7/23.
//

import SwiftUI

struct MySecondView: View {
    @State var teamScanned: Team?
    var body: some View {
        if let teamScanned {
            Text("Qr code scanned for \(teamScanned.name)")
        } else {
            Text("Failed to read team")
        }
    }
}


struct MySecondView_Previews: PreviewProvider {
    static var previews: some View {
        MySecondView(teamScanned: Team(name: "Dummy team"))
    }
}

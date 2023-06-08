//
//  MyViewsTabView.swift
//  Qr Test
//
//  Created by Tyler Radke on 6/7/23.
//

import SwiftUI

struct MyViewsTabView: View {
    var body: some View {
        TabView {
            MyMainView()
                .tabItem {
                    Label("Main View", systemImage: "paperclip")
                }
            
            QRCodeCreator()
                .tabItem {
                    Label("Qr Code Generator", systemImage: "qrcode")
                }
        }
    }
}

struct MyViewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyViewsTabView()
    }
}

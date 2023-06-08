//
//  QRCodeCreator.swift
//  Qr Test
//
//  Created by Tyler Radke on 6/7/23.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodeCreator: View {
    
    @State private var qrCodeData = "This is my test data"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @State var teamsDictionary: [String: UIImage] = [:]
    @State var teamKeys: [String] = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                TextField("QrCodeData", text: $qrCodeData)
                    .multilineTextAlignment(.center)
                
                ForEach(teamKeys, id: \.self) { key in
                    HStack {
                        Text(key)
                        
                        if let uiImage = teamsDictionary[key] {
                            Image(uiImage: uiImage)
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                        
                    }
                }
                
                ShareLink("Get as pdf", item: render())
            }
        } .onAppear {
            teamsDictionary = generateQRCodesForTeams()
            teamKeys = teamsDictionary.keys.filter( { $0 != nil })
        }
        
    }
    
    @MainActor func render() -> URL {
        //Render images
        let renderer = ImageRenderer(content:
        ForEach(teamKeys, id: \.self) { key in
            HStack {
                Text(key)
                
                if let uiImage = teamsDictionary[key] {
                    Image(uiImage: uiImage)
                        //.interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
                
            }
        }
    )
        //Create Documents director
        let url = URL.documentsDirectory.appending(path: "teamQRs.pdf")
        
        //Start rendering process
        renderer.render { size, context in
                   // 4: Tell SwiftUI our PDF should be the same size as the views we're rendering
                   var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)

                   // 5: Create the CGContext for our PDF pages
                   guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                       return
                   }

                   // 6: Start a new PDF page
                   pdf.beginPDFPage(nil)

                   // 7: Render the SwiftUI view data onto the page
                   context(pdf)

                   // 8: End the page and close the file
                   pdf.endPDFPage()
                   pdf.closePDF()
               }
        
        return url
    }
    
    
    func generateQRCodesForTeams() -> [String: UIImage] {
        
        var images: [String: UIImage] = [:]
        
        for team in Team.dummyTeams {
            let data = Data(team.id.uuidString.utf8)
            
            filter.message = data
            
            if let outputImage = filter.outputImage {
                if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                    let finalImage = UIImage(cgImage: cgImage)
                    images[team.name] = finalImage
                    
                }
            }
            
        }
        
        return images
    }
}

struct RestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeCreator()
    }
}

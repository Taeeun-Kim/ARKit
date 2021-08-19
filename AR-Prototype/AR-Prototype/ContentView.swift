//
//  ContentView.swift
//  AR-Prototype
//
//  Created by Taeeun Kim on 16.08.21.
//

import SwiftUI
import RealityKit
import UIKit
import QuickLook
import ARKit
import UniformTypeIdentifiers

struct ContentView: View {
    
    @State private var usdzURL: URL = URL(fileURLWithPath: "")
    @State private var usdzFile: String = "czech"
    @State var fileName = ""
    @State var openFile = false
    @State var saveFile = false
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                if openFile == false {
                    ARQuickLookView(name: "czech", usdzURL: usdzURL)
                        .frame(width: Screen.width, height: Screen.height - Screen.height * 0.4)
                }
                
                Spacer()
                
                VStack(spacing: 0) {
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            MainButton(symbolName: "cube", text: "3D Scan")
                        })
                        Button(action: {
                            
                        }, label: {
                            MainButton(symbolName: "camera", text: "Fotos")
                        })
                        Button(action: {
                            saveFile.toggle()
                        }, label: {
                            MainButton(symbolName: "pencil", text: "Bauplan")
                        })
                        Button(action: {
                            openFile.toggle()
                        }, label: {
                            VStack {
                                MainButton(symbolName: "doc.badge.plus", text: "Dateien")
                            }
                        })
                        .fileImporter(isPresented: $openFile, allowedContentTypes: [.usdz]) { res in
                            do {
                                let fileUrl = try res.get()
                                
                                if fileUrl.startAccessingSecurityScopedResource() {
                                    fileName = fileUrl.lastPathComponent // <--- the file name you want
                                    let fileData = try Data(contentsOf: fileUrl)
                                    let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
                                    let actualPath = resourceDocPath.appendingPathComponent("Kus_\(fileName)")
                                    defer { fileUrl.stopAccessingSecurityScopedResource() }
                                    
                                    do {
                                        try fileData.write(to: actualPath)
                                        print("usdz successfully saved!")
                                    } catch {
                                        print("usdz could not be saved")
                                    }
                                    
                                    usdzURL = actualPath
                                } else {
                                }
                            } catch{
                                print ("error reading: \(error.localizedDescription)")
                            }
                            
                        }
                    }
                    .frame(width: Screen.width * 0.45)
                    .padding()
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        subText(leftText: "Status", rightText: "Ausstehend")
                        subText(leftText: "Fertigstellung", rightText: "16.08.2021")
                        subText(leftText: "Bodenfläche", rightText: "23qm")
                        subText(leftText: "Wandfläche", rightText: "18qm")
                        subText(leftText: "Deckenfläche", rightText: "23qm")
                        
                        subText(leftText: "Material", rightText: "Keramik-Fließen")
                        subText(leftText: "Arbeitsdauer", rightText: "1,5 Tage")
                        
                        Button(action: {
                        }, label: {
                            HStack {
                                Text("Kalkulation erstellen")
                                    .padding()
                            }
                            .frame(width: Screen.width * 0.43, height: Screen.height * 0.04)
                            .background(Color(red: 200 / 255, green: 98 / 255, blue: 76 / 255))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                        })
                    })
                    .padding()
                }
                .frame(width: Screen.width, height: Screen.height * 0.4)
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
            }
        }
    }
}

struct MainButton : View {
    
    var symbolName: String
    var text: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: symbolName)
                .font(.system(size: Screen.height * 0.025))
                .frame(width: Screen.height * 0.035, height: Screen.height * 0.035)
            
            Text(text)
                .font(.system(size: Screen.height * 0.0125))
        }
        .frame(width: Screen.height * 0.07, height: Screen.height * 0.07)
        .background(Color(red: 57 / 255, green: 63 / 255, blue: 84 / 255))
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

struct subText : View {
    
    var leftText: String
    var rightText: String
    
    var body: some View {
        HStack {
            Text(leftText)
                .padding()
            Spacer()
            Text(rightText)
                .padding()
        }
        .frame(width: Screen.width * 0.43, height: Screen.height * 0.04)
        .background(Color(red: 230 / 255, green: 230 / 255, blue: 230 / 255))
        .foregroundColor(.black)
        .cornerRadius(10)
        .padding(1)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

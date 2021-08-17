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

//class LocalFileManager {
//    static let instance = LocalFileManager()
//
//    func saveUSDZ(usdz: URL, name: String) {
//        guard let data = usdz.absoluteString else {
//            print("Error")
//            return
//        }
//
//        let directory = FileManager.default.urls(for: <#T##FileManager.SearchPathDirectory#>, in: <#T##FileManager.SearchPathDomainMask#>)
//    }
//}

struct ContentView: View {
    
    @State private var usdzURL: URL = URL(fileURLWithPath: "")
    @State private var usdzFile: String = "czech"
    @State var fileName = ""
    @State var openFile = false
    @State var saveFile = false
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                //                if usdzURL.isEmpty {
                if openFile == false {
                    ARQuickLookView(name: "czech", usdzURL: usdzURL)
                        .frame(width: Screen.width, height: Screen.height - Screen.height * 0.4)

                }
                //                } else {
                //                    ARQuickLookView(name: "czech", usdzURL: usdzURL)
                //                        .frame(width: Screen.width, height: Screen.height - Screen.height * 0.4)
                //                }
                
                Spacer()
                
                VStack(spacing: 0) {
                    HStack {
                        Button(action: {}, label: {
                            MainButton(symbolName: "cube", text: "3D Scan")
                        })
                        Button(action: {}, label: {
                            MainButton(symbolName: "camera", text: "Fotos")
                        })
                        Button(action: {
                            saveFile.toggle()
                        }, label: {
                            MainButton(symbolName: "pencil", text: "Bauplan")
                        })
                        Button(action: {
                            //                            isPresented = true
                            openFile.toggle()
                        }, label: {
                            VStack {
                                MainButton(symbolName: "doc.badge.plus", text: "Dateien")
                                Text("file selected is \(fileName)")
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
                                    print("saved url1: \(actualPath.absoluteURL)")
//                                    print("saved url: \(actualPath.deletingLastPathComponent())")
//                                    print("saved url: \(actualPath.path)")
//                                    print("saved url: \(actualPath.standardizedFileURL)")
//                                    print("saved url6: \(actualPath.relativePath)")
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
    
    func savePdf(urlString:String, fileName:String) {
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "Prototype-\(fileName).pdf"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("pdf successfully saved!")
            } catch {
                print("Pdf could not be saved")
            }
        }
    }
    
    func showSavedPdf(url:String, fileName:String) {
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if url.description.contains("\(fileName).pdf") {
                        // its your file! do what you want with it!
                        
                    }
                }
            } catch {
                print("could not locate pdf file !!!!!!!")
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

//struct ARViewContainer: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> ARView {
//
//        let arView = ARView(frame: .zero)
//
//        // Load the "Box" scene from the "Experience" Reality File
//
//        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)
//
//        return arView
//
//    }
//
//    func updateUIView(_ uiView: ARView, context: Context) {}
//
//}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

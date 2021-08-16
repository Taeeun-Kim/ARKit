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

struct ContentView : View {
    var body: some View {
        ZStack {

            VStack(spacing: 0) {
                ARQuickLookView(name: "czech")
                    .frame(width: Screen.width, height: Screen.height - Screen.height * 0.4)

                Spacer()
                
                VStack {
                    HStack {
                        Button(action: {}, label: {
                            MainButton(symbolName: "cube", text: "3D Scan")
                        })
                        Button(action: {}, label: {
                            MainButton(symbolName: "camera", text: "Fotos")
                        })
                        Button(action: {}, label: {
                            MainButton(symbolName: "pencil", text: "Bauplan")
                        })
                        Button(action: {}, label: {
                            MainButton(symbolName: "doc.badge.plus", text: "Dateien")
                        })
                    }
                    .frame(width: Screen.width, height: Screen.height * 0.4)
                }
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
            }
        }
    }
}

struct MainButton : View {
    
    var symbolName: String
    var text: String
    
    var body: some View {
        VStack {
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

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

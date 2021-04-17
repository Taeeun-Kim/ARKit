//
//  ContentView.swift
//  3DAnimatedObjectAR
//
//  Created by Taeeun Kim on 17.04.21.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        ZStack {
            HStack {
                Text("Hello")
            }
            ARViewContainer().edgesIgnoringSafeArea(.all)
        }
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

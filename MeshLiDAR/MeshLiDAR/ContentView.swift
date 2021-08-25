//
//  ContentView.swift
//  MeshLiDAR
//
//  Created by Taeeun Kim on 25.08.21.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
//        // Load the "Box" scene from the "Experience" Reality File
//        let boxAnchor = try! Experience.loadBox()
        
        let config = ARWorldTrackingConfiguration()
        config.sceneReconstruction = .mesh

        arView.debugOptions.insert([.showSceneUnderstanding])
        arView.environment.sceneUnderstanding.options.insert([.physics])
        arView.session.run(config)
        
        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)
        
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

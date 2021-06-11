//
//  ContentView.swift
//  3DAnimatedObjectTest
//
//  Created by Taeeun Kim on 11.06.21.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        arView.environment.lighting.intensityExponent = 3
        
        let newAnchor = AnchorEntity (world: .zero)
        let newEnt = try! Entity.load(named: "newtons_cradle")
        newAnchor.addChild(newEnt)
        arView.scene.addAnchor(newAnchor)
        
        for anim in newEnt.availableAnimations {
            newEnt.playAnimation(anim.repeat(duration:.infinity), transitionDuration: 1.25, startsPaused: false)
        }

        
        // Load the "Box" scene from the "Experience" Reality File
//        let boxAnchor = try! Experience.loadBox()
        
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

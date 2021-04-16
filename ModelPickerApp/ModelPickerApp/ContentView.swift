//
//  ContentView.swift
//  ModelPickerApp
//
//  Created by Taeeun Kim on 16.04.21.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        Text("Hello World")
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
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

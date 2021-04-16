//
//  ContentView.swift
//  ModelPickerApp
//
//  Created by Taeeun Kim on 16.04.21.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    
    var models: [String] = ["toy_biplane", "tv_retro", "gramophone", "teapot"]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(0 ..< self.models.count) { index in
                        Button(action: {
                            print("DEBUG: selected model with name: \(self.models[index])")
                        }, label: {
                            Image(uiImage: UIImage(named: self.models[index])!)
                                .resizable()
                                .frame(height: 80)
                                .aspectRatio(1/1, contentMode: .fit)
                                .background(Color.white)
                                .cornerRadius(12)
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            } //: SCROLLVIEW
            .padding(20)
            .background(Color.black.opacity(0.5))
        }
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

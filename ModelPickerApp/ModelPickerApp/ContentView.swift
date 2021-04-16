//
//  ContentView.swift
//  ModelPickerApp
//
//  Created by Taeeun Kim on 16.04.21.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @State private var isPlacementEnabled = false
    
    private var models: [String] = ["toy_biplane", "tv_retro", "gramophone", "teapot"]
//    private var models: [String] = {
//        // Dynamically get our model filenames
//        let filemanager = FileManager.default
//
//        // guaard, because these are optional values
//        guard let path = Bundle.main.resourcePath, let files = try? filemanager.contentsOfDirectory(atPath: path) else {
//                return []
//        } // error occurred
//
//        var availableModels: [String] = []
//        for filename in files where filename.hasSuffix("usdz") {
//            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
//            availableModels.append(modelName)
//        }
//
//        return availableModels
//    }()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
            
            if self.isPlacementEnabled {
                PlacementButtonsView()
            } else {
                ModelPickerView(models: self.models)
            }
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

struct ModelPickerView: View {
    var models: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(0 ..< self.models.count) { index in
                    Button(action: {
                        print("DEBUG: selected model with name: \(self.models[index])")
                    }, label: {
                        Image(uiImage: UIImage(named: self.models[index])!)
                            .resizable()
                            .frame(height: 60)
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

struct PlacementButtonsView: View {
    var body: some View {
        HStack{
            // Cancel Button
            Button(action: {
                print("DEBUG: Cancel model placement.")
            }, label: {
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            })
            
            // Confirm Button
            Button(action: {
                print("DEBUG: model placement comfirmed.")
            }, label: {
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            })
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

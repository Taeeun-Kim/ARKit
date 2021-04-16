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
    @State private var selectedModel: String?
    @State private var modelConfirmedForPlacement: String?
    
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
                PlacementButtonsView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel)
            } else {
                ModelPickerView(isPlacementEnabled: self.$isPlacementEnabled, selecetedModel: self.$selectedModel, models: self.models)
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
    @Binding var isPlacementEnabled: Bool
    @Binding var selecetedModel: String? // 아하! 위에서 선언된 변수를 동시에 사용한다는 의미! 같이 참조해야하니!!
    // 만약 리스트뷰와 토글 뷰가 나뉘어 토글에 따라 리스트를 바꿔야 하는 경우처럼 두 개의 뷰가 동시에 하나의 State를 참조해야 하는 경우가 생길 수 있습니다. 이때 @Binding을 사용 용할 수 있습니다.
    
    var models: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(0 ..< self.models.count) { index in
                    Button(action: {
                        print("DEBUG: selected model with name: \(self.models[index])")
                        
                        self.selecetedModel = self.models[index]
                        self.isPlacementEnabled = true
                        // $isPlacementEnabled가 아닌 이유는, 들어온 값에 대해 바꿔줘야 하는거라
                        
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
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: String?
    
    var body: some View {
        HStack{
            // Cancel Button
            Button(action: {
                print("DEBUG: Cancel model placement.")
                
                self.resetPlacementParameters()
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
                
                self.resetPlacementParameters()
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
    
    func resetPlacementParameters() {
        self.isPlacementEnabled = false
        self.selectedModel = nil
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

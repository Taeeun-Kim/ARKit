//
//  ContentView.swift
//  ModelPickerApp
//
//  Created by Taeeun Kim on 16.04.21.
//

import SwiftUI
import RealityKit
import ARKit
//import FocusEntity

struct ContentView : View {
    @State private var isPlacementEnabled = false
    @State private var selectedModel: Model?
    @State private var modelConfirmedForPlacement: Model?
    
//    private var models: [Model] = ["toy_biplane", "tv_retro", "gramophone", "teapot"]
    private var models: [Model] = {
        // Dynamically get our model filenames
        let filemanager = FileManager.default

        // guaard, because these are optional values
        guard let path = Bundle.main.resourcePath, let files = try? filemanager.contentsOfDirectory(atPath: path) else {
                return []
        } // error occurred

        var availableModels: [Model] = []
        for filename in files where filename.hasSuffix("usdz") {
            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            let model = Model(modelName: modelName)
            
            availableModels.append(model)
        }

        return availableModels
    }()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(modelConfirmedForPlacement: self.$modelConfirmedForPlacement)
            
            if self.isPlacementEnabled {
                PlacementButtonsView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel, modelConfirmedForPlacement: self.$modelConfirmedForPlacement)
            } else {
                ModelPickerView(isPlacementEnabled: self.$isPlacementEnabled, selecetedModel: self.$selectedModel, models: self.models)
            }
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var modelConfirmedForPlacement: Model?
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = CustomARView(frame: .zero)
                
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if let model = self.modelConfirmedForPlacement { // modelName이란 nil이 아니라면, 실행됨
                
            if let modelEntity = model.modelEntity {
                print("DEBUG: adding model t o scene - \(model.modelName)")
                
                let anchorEntity = AnchorEntity(plane: .any)
                anchorEntity.addChild(modelEntity.clone(recursive: true))
                // 모델 추가 기능
                
                uiView.scene.addAnchor(anchorEntity)
            } else {
                print("DEBUG: Unable to load modelEntity for \(model.modelName)")
            }
                
            DispatchQueue.main.async {
                self.modelConfirmedForPlacement = nil
            }
        }
    }
    
}

class CustomARView: ARView {
//    let focusSquare = FocusEntity()
    let focusSquare = FocusEntity(on: self.arView, style: .classic)
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        
//        focusSquare.viewDelegate = self
        focusSquare.delegate = self
        focusSquare.setAutoUpdate(to: true)
        
        self.setupARView()
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupARView() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        
        self.session.run(config)
    }
}

extension CustomARView: FocusEntityDelegate {
    func toTrackingState() {
        print("tracking")
    }
    
    func toInitializingState() {
        print("initializing")
    }
}

struct ModelPickerView: View {
    @Binding var isPlacementEnabled: Bool
    @Binding var selecetedModel: Model? // 아하! 위에서 선언된 변수를 동시에 사용한다는 의미! 같이 참조해야하니!!
    // 만약 리스트뷰와 토글 뷰가 나뉘어 토글에 따라 리스트를 바꿔야 하는 경우처럼 두 개의 뷰가 동시에 하나의 State를 참조해야 하는 경우가 생길 수 있습니다. 이때 @Binding을 사용 용할 수 있습니다.
    
    var models: [Model]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(0 ..< self.models.count) { index in
                    Button(action: {
                        print("DEBUG: selected model with name: \(self.models[index].modelName)")
                        
                        self.selecetedModel = self.models[index]
                        self.isPlacementEnabled = true
                        // $isPlacementEnabled가 아닌 이유는, 들어온 값에 대해 바꿔줘야 하는거라
                        
                    }, label: {
                        Image(uiImage: self.models[index].image)
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
    @Binding var selectedModel: Model?
    @Binding var modelConfirmedForPlacement: Model?

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
                
                self.modelConfirmedForPlacement = self.selectedModel
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

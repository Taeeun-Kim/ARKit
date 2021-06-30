//
//  ContentView.swift
//  Thesis_Project
//
//  Created by Taeeun Kim on 25.06.21.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    
    @State private var arTrigger: Bool = false
    @State private var detailView: Bool = false
    
    init() {
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 52, green: 120, blue: 246, alpha: 0.8)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red: 52, green: 120, blue: 246, alpha: 0.8)]
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.gray
                
                VStack{
                    //                    Image("test3")
                    //                        .resizable()
                    //                        .aspectRatio(contentMode: .fit)
                    //                        .cornerRadius(15)
                    Text("Taeeun Kim")
                        .font(.system(size: 25))
                }
                
                if arTrigger {
                    ARViewContainer()
                        .animation(.easeIn, value: 1)
                        .edgesIgnoringSafeArea(.all)
                }
                
                if detailView {
                    DetailView()
                        .animation(.easeIn, value: 1)
                }
                
                VStack{
                    Spacer()
                    HStack {
                        Button(action: {
                            arTrigger.toggle()
                        }, label: {
                            Text("AR")
                        })
                            .frame(width: 80, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                            .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            .cornerRadius(6)
                            .padding()
                        
                        
                        Button(action: {
                            detailView.toggle()
                        }, label: {
                            Text("Detail")
                        })
                            .frame(width: 80, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                            .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            .cornerRadius(6)
                            .padding()
                    }
                }
                .padding(.bottom, 20)
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Mediengestaltuffng")
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Gazua.loadGo()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        //        let meshTest = MeshResource.generateSphere(radius: 30)
        
        //        let newAnchor = Entity.
        //
        //        let modelEntity = ModelEntity(mesh: MeshResource.generateSphere(radius: 30))
        //
        //        var material = SimpleMaterial()
        //
        //        material.color =  try! .init(tint: UIColor.blue, texture: MaterialParameters.Texture.init(TextureResource.load(named: "earth.jpg", in: Bundle.main)))
        //        let anchorEntity = AnchorEntity()
        //        anchorEntity.addChild(modelEntity.clone(recursive: true))
        //        // 모델 추가 기능
        //
        //        arView.scene.addAnchor(anchorEntity)
        
        //        entity.model?.mesh = newTextMesh
        //        let boxNode = SCNNode(geometry: box)
        //        boxNode.position = SCNVector3(0, 0, -0.5)
        //        boxNode.geometry?.materials = [material]
        //
        //        let sphere = SCNSphere(radius: 0.3)
        //        sphere.firstMaterial?.diffuse.contents = UIImage(named: "earth.jpg")
        //
        //        let sphereNode = SCNNode(geometry: sphere)
        //        sphereNode.position = SCNVector3(0.5, 0, -0.5)
        //
        //        self.sceneView.scene.rootNode.addChildNode(boxNode)
        
        //
        //        arView.environment.lighting.intensityExponent = 3
        //
        //        let newAnchor2: DrPepper.Scene!
        //
        //        newAnchor2 = try! DrPepper.loadScene()
        //
        //        newAnchor2.generateCollisionShapes(recursive: true)
        //
        //        arView.scene.anchors.append(newAnchor2)
        
        //        let newAnchor = AnchorEntity (world: .zero)
        //        let newEnt = try! Entity.load(named: "Czech6")
        //        newAnchor.addChild(newEnt)
        //        arView.scene.addAnchor(newAnchor)
        
        // arView.session.run(config)
        //
        //        for anim in newEnt.availableAnimations {
        //            newEnt.playAnimation(anim.repeat(duration:.infinity), transitionDuration: 1.25, startsPaused: false)
        //        }
        
        
        // Load the "Box" scene from the "Experience" Reality File
        //        let boxAnchor = try! DrPepper.loadScene()
        
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

//
//  ViewController.swift
//  Mesh
//
//  Created by Indrajit Chavda on 04/06/21.
//

import ARKit
import SceneKit

class ViewController: UIViewController, ARSCNViewDelegate {

    let colorizer = Colorizer()
    
    lazy var arView: ARSCNView = {
        let view = ARSCNView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(arView)
        arView.frame = self.view.frame
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.sceneReconstruction = .meshWithClassification
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)
        
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapped))

        arView.addGestureRecognizer(tap)
         
    }
    
    
    @objc
    func tapped() {
       
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let filename = documentsDirectory.appendingPathComponent("dsasfmesh.usdz")
        self.arView.scene.write(to: filename, options: nil, delegate: nil, progressHandler: nil)
        
//        print(filename)
//
//        do {
//                // writes the image data to disk
//                try data.write(to: filename)
//                print("file saved")
//            } catch {
//                print("error saving file:", error)
//            }
//        let fileName = "Mesh"
//
//        let documentDirURL = try! FileManager.default.url(for: .documentDirectory,
//                                                          in: .userDomainMask,
//                                                          appropriateFor: nil,
//                                                          create: true)
//        let fileURL = documentDirURL.appendingPathComponent(fileName).appendingPathExtension("usdz")
//
//        self.arView.scene.write(to: fileURL, options: nil, delegate: nil, progressHandler: nil)
//
//        print("test")
//
        let activityVc = UIActivityViewController.init(activityItems: [try! Data.init(contentsOf: filename)],
                                                       applicationActivities: nil)
        self.present(activityVc, animated:true, completion:nil)
//
//        print("test2")
        
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
            guard let meshAnchor = anchor as? ARMeshAnchor else {
          return nil
            }
            let geometry = SCNGeometry(arGeometry: meshAnchor.geometry)
        
            let classification = meshAnchor.geometry.classificationOf(faceWithIndex: 0)
            let defaultMaterial = SCNMaterial()
            defaultMaterial.fillMode = .lines
            defaultMaterial.diffuse.contents = colorizer.assignColor(to: meshAnchor.identifier, classification: classification)
            geometry.materials = [defaultMaterial]
            let node = SCNNode()
            node.geometry = geometry
            return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
            guard let meshAnchor = anchor as? ARMeshAnchor else {
                return
            }
            let newGeometry = SCNGeometry(arGeometry: meshAnchor.geometry)
        
            let classification = meshAnchor.geometry.classificationOf(faceWithIndex: 0)
            let defaultMaterial = SCNMaterial()
            defaultMaterial.fillMode = .lines
            defaultMaterial.diffuse.contents = colorizer.assignColor(to: meshAnchor.identifier, classification: classification)
            newGeometry.materials = [defaultMaterial]
            node.geometry = newGeometry
    }
    
}



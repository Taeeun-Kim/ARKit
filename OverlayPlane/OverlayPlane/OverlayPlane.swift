//
//  OverlayPlane.swift
//  OverlayPlane
//
//  Created by Taeeun Kim on 21.08.21.
//

import Foundation
import SceneKit
import ARKit

class OverlayPlane : SCNNode {
    
    var anchor :ARPlaneAnchor
    var planeGeometry :SCNPlane!
    
    init(anchor :ARPlaneAnchor) {
        
        self.anchor = anchor
        super.init()
        setup()
    }
    
    func update(anchor :ARPlaneAnchor) {

        self.planeGeometry.width = CGFloat(anchor.extent.x);
        self.planeGeometry.height = CGFloat(anchor.extent.z);
        self.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z);
        
        let planeNode = self.childNodes.first!
        
        planeNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: self.planeGeometry, options: nil))
        
    }
    
    private func setup() {
        
        print("실험")
        self.planeGeometry = SCNPlane(width: CGFloat(self.anchor.extent.x), height: CGFloat(self.anchor.extent.z))
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named:"overlay_grid.png")
        
        self.planeGeometry.materials = [material]
        
        let planeNode = SCNNode(geometry: self.planeGeometry)
        planeNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: self.planeGeometry, options: nil))
        planeNode.physicsBody?.categoryBitMask = BodyType.plane.rawValue
        
        planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z);
        planeNode.transform = SCNMatrix4MakeRotation(Float(-Double.pi / 2.0), 1.0, 0.0, 0.0);
        
        // add to the parent
        self.addChildNode(planeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




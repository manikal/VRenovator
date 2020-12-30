//
//  Plane.swift
//  vrenovator
//
//  Created by Mijo Kaliger on 29.12.2020..
//

import ARKit

extension UIColor {
    static let planeColor = UIColor(named: "planeColor")!
}

class Plane: SCNNode {
    
    let extentNode: SCNNode
    var classificationNode: SCNNode?
    
    var color: UIColor? {
        didSet {
            guard let material = extentNode.geometry?.firstMaterial
                else { fatalError("ARSCNPlaneGeometry always has one material") }
            material.diffuse.contents = color
        }
    }
    
    /// - Tag: VisualizePlane
    init(anchor: ARPlaneAnchor, in sceneView: ARSCNView) {
        
        #if targetEnvironment(simulator)
        #error("ARKit is not supported in iOS Simulator. Connect a physical iOS device and select it as your Xcode run destination, or select Generic iOS Device as a build-only destination.")
        #else
        
        // Create a node to visualize the plane's bounding rectangle.
        let extentPlane: SCNPlane = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        extentNode = SCNNode(geometry: extentPlane)
        extentNode.simdPosition = anchor.center
        
        // `SCNPlane` is vertically oriented in its local coordinate space, so
        // rotate it to match the orientation of `ARPlaneAnchor`.
        extentNode.eulerAngles.x = -.pi / 2

        super.init()

        guard let material = extentNode.geometry?.firstMaterial
            else { fatalError("SCNPlane always has one material") }
        
        material.diffuse.contents = UIColor.planeColor
        
        // Add the plane extent as child node to appear in the scene.
        addChildNode(extentNode)
        
        #endif
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


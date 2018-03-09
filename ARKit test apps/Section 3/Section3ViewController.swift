//
//  Section3ViewController.swift
//  ARKit test apps
//
//  Created by Yatseyko Yuriy on 08.03.2018.
//  Copyright © 2018 Yatseyko Yuriy. All rights reserved.
//

import UIKit

import ARKit

class Section3ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
    }
    
    // MARK: - Help methods
    func restartSession() {
        sceneView.session.pause()
        sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func getRandomNumbers(firstNumber: CGFloat, secondNumber: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNumber - secondNumber) + min(firstNumber, secondNumber)
    }
    
    func addHouse() {
        let  doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        let node = SCNNode()
        //        let path = UIBezierPath()
        //        path.move(to: CGPoint(x: 0, y: 0))
        //        path.addLine(to: CGPoint(x: 0, y: 0.2))
        //        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
        //        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
        //        path.addLine(to: CGPoint(x: 0.4, y: 0))
        //        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        //        node.geometry = shape
        
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        node.position = SCNVector3(0.2, 0.3, -0.2)
        node.eulerAngles = SCNVector3(Float(180.degreesToRadians), 0, 0)
        
        boxNode.position = SCNVector3(0, -0.05, 0)
        doorNode.position = SCNVector3(0, -0.02, 0.053)
        
        sceneView.scene.rootNode.addChildNode(node)
        node.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)
    }
    
    func rotation() {
        let cylinderNode = SCNNode(geometry: SCNCylinder(radius: 0.1, height: 0.15))
        cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        cylinderNode.position = SCNVector3(0, 0, -0.3)
        cylinderNode.eulerAngles = SCNVector3(0, 0, Float(90.degreesToRadians))
        
        let pyramidNode = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
        pyramidNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        pyramidNode.position = SCNVector3(0, 0, -0.5)
        
        cylinderNode.addChildNode(pyramidNode)
        
        sceneView.scene.rootNode.addChildNode(cylinderNode)
    }

    // MARK: - Actions
    @IBAction func addButtonPressed(_ sender: Any) {
        addHouse()
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        restartSession()
    }
}

extension Int {
    var degreesToRadians: Double {
        return Double(self) * .pi / 180
    }
}

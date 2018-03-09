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

    // MARK: - Actions
    @IBAction func addButtonPressed(_ sender: Any) {
        let node = SCNNode()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0.2))
        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
        path.addLine(to: CGPoint(x: 0.4, y: 0))
        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        node.geometry = shape
//        node.geometry = SCNSphere(radius: 0.1)
//        node.geometry = SCNCone(topRadius: 0.1, bottomRadius: 0.1, height: 0.3)
//        node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        let x = getRandomNumbers(firstNumber: -0.3, secondNumber: 0.3)
        let y = getRandomNumbers(firstNumber: -0.3, secondNumber: 0.3)
        let z = getRandomNumbers(firstNumber: -0.3, secondNumber: 0.3)
        node.position = SCNVector3(0, 0, -0.3)
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        restartSession()
    }
}

//
//  ViewController.swift
//  Planets
//
//  Created by Livia Vasconcelos on 27/12/19.
//  Copyright © 2019 Livia Vasconcelos. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,
                                  ARSCNDebugOptions.showWorldOrigin]
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
    }

    override func viewDidAppear(_ animated: Bool) {
        let earth = SCNNode()
        earth.geometry = SCNSphere(radius: 0.2)
        earth.geometry?.firstMaterial?.diffuse.contents  = UIImage(named: "Earth")
        earth.geometry?.firstMaterial?.specular.contents = UIImage(named: "Earth Specular")
        earth.geometry?.firstMaterial?.emission.contents = UIImage(named: "Earth Clouds")
        earth.geometry?.firstMaterial?.normal.contents   = UIImage(named: "Earth Normal")
        earth.position = SCNVector3(0, 0, -1)
        
        sceneView.scene.rootNode.addChildNode(earth)
        
        let action = SCNAction.rotateBy(x: 0,
                                        y: CGFloat(360.degreesToRadians),
                                        z: 0,
                                        duration: 8)
        let forever = SCNAction.repeatForever(action)
        earth.runAction(forever)
    }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

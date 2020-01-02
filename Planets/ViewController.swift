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
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        sun.geometry?.firstMaterial?.diffuse.contents  = UIImage(named: "Sun")
        sun.position = SCNVector3(0, 0, -1)
        
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        let moonParent  = SCNNode()
        
        earthParent.position = SCNVector3(0, 0, -1)
        venusParent.position = SCNVector3(0, 0, -1)
        moonParent.position  = SCNVector3(1.2, 0, 0)
        
        sceneView.scene.rootNode.addChildNode(sun)
        sceneView.scene.rootNode.addChildNode(earthParent)
        sceneView.scene.rootNode.addChildNode(venusParent)
        
        let earth = planet(geometry: SCNSphere(radius: 0.2),
                           diffuse: UIImage(named: "Earth"),
                           specular: UIImage(named: "Earth Specular"),
                           emission: UIImage(named: "Earth Clouds"),
                           normal: UIImage(named: "Earth Normal"),
                           position: SCNVector3(1.2, 0, 0))

        let venus = planet(geometry: SCNSphere(radius: 0.1),
                          diffuse: UIImage(named: "Venus Surface"),
                          specular: nil,
                          emission: UIImage(named: "Venus Atmosphere"),
                          normal: nil,
                          position: SCNVector3(0.7, 0, 0))
        
        let moon = planet(geometry: SCNSphere(radius: 0.05),
                          diffuse: UIImage(named: "Moon Diffuse"),
                          specular: nil,
                          emission: nil,
                          normal: nil,
                          position: SCNVector3(0, 0, -0.3))
        
        sun.runAction(rotation(time: 8))
        earthParent.runAction(rotation(time: 14))
        venusParent.runAction(rotation(time: 10))
        moonParent.runAction(rotation(time: 5))
        
        earth.runAction(rotation(time: 8))
        venus.runAction(rotation(time: 8))
        
        earthParent.addChildNode(earth)
        venusParent.addChildNode(venus)
        
        earthParent.addChildNode(moonParent)
        moonParent.addChildNode(moon)
    }
    
    func planet(geometry: SCNGeometry,
                diffuse: UIImage?,
                specular: UIImage?,
                emission: UIImage?,
                normal: UIImage?,
                position: SCNVector3) -> SCNNode {
        
        let planet = SCNNode()
        planet.geometry = geometry
        planet.geometry?.firstMaterial?.diffuse.contents  = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents   = normal
        planet.position = position
        
        return planet
    }
    
    func rotation(time: TimeInterval) -> SCNAction {
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        
        return SCNAction.repeatForever(rotation)
    }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

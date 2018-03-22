//
//  GameViewController.swift
//  RingsTossGame
//
//  Created by Daria Matusik on 3/13/18.
//  Copyright © 2018 Daria Matusik. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController, SCNSceneRendererDelegate {
    
    let worldHeight:Float = 30
    let worldWidth:Float = 19
    let worldDepth:Float = 3

    var gameView:SCNView!
    var gameScene:SCNScene!
    var cameraNode:SCNNode!
    var targetCreationTime:TimeInterval = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initScene()
        initCamera()
        
        createBoundaries()
        createSpikes()
        createRings()
        
        createButtons()
        
    }
    
    
    
    func initView() {
        gameView = self.view as! SCNView
        gameView.allowsCameraControl = false
        gameView.autoenablesDefaultLighting = true
        gameView.delegate = self
    }
    
    func initScene() {
        gameScene = SCNScene()
        gameView.scene = gameScene
        
        gameView.isPlaying = true
    }
    
    func initCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        cameraNode.position = SCNVector3(x:0, y:0, z:30)
        
        gameScene.rootNode.addChildNode(cameraNode)
        
        
//        print(cameraNode.camera?.zFar);
//        print(cameraNode.camera?.zNear);
//        cameraNode.camera?.fieldOfView;
//        print(cameraNode.camera?.fieldOfView)
//        print(cameraNode.camera?.xFov)
//        print(cameraNode.camera?.yFov)
//        print(getScreenHeight())
        
    }
    
//    func getScreenHeight() -> Double {
//        let fieldofView = cameraNode.camera?.fieldOfView
//        return tan(Double(fieldofView.unsafelyUnwrapped)) * 30 * 2;
//    }
    
    func createBoundaries() {
        let boundaryBox: BoundaryBox = BoundaryBox(boxHeight: worldHeight, boxWidth: worldWidth, boxDepth: worldDepth)
        let box: [SCNNode] = [
            boundaryBox.createRightBoundary(),
            boundaryBox.createLeftBoundary(),
            boundaryBox.createTopBoundary(),
            boundaryBox.createBottomBoundary(),
            boundaryBox.createFrontBoundary(),
            boundaryBox.createBackBoundary()
        ]
        
        for boundaryNode in box {
            gameScene.rootNode.addChildNode(boundaryNode)
            repositionNodeOnYAxis(geometryNode: boundaryNode, repositionFactor: 2.5)
            print(boundaryNode.position)
        }
    }
    
    func repositionNodeOnYAxis(geometryNode: SCNNode, repositionFactor:Float) {
        geometryNode.position.y = geometryNode.position.y + repositionFactor
    }
    
    
    func createBoundingWallTemplate() -> SCNGeometry {
        let boundingWall: SCNGeometry = SCNPlane(width: 10, height: 10)
        boundingWall.materials.first?.diffuse.contents = UIColor.white
        
        return boundingWall
    }
    
    func createButtons() {
        
        createLeftButton()
        createRightButton()
    }
    
    func createLeftButton() {
        let leftButton = UIButton(type: UIButtonType.custom)
        
        let x_ButtonPosition:Float = 20
        let y_ButtonPosition:Float = 0
        
        leftButton.setImage(UIImage(named: "button_test.png"), for: [])
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        //        leftButton.frame = CGRect(x: x_ButtonPosition, y: y_ButtonPosition, width: 50, height: 50)
        
        leftButton.addTarget(self, action: #selector(leftButtonClicked), for: UIControlEvents.touchDown)
        
        gameView.addSubview(leftButton)
        
        //set constrains:
        NSLayoutConstraint.activate([
            leftButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(x_ButtonPosition)),
            leftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat(y_ButtonPosition)),
            leftButton.widthAnchor.constraint(equalToConstant: 100),
            leftButton.heightAnchor.constraint(equalToConstant: 100)
            ])
    }
    
    @objc func leftButtonClicked(){
        print("Left button clicked")
        for _ in 1...20 {
            createBubble(position: SCNVector3(x: -worldWidth/2+3, y: -worldHeight/2 + 2.5, z: 0))
        }
        let fieldOriginOffset = SCNVector3(x: -worldWidth/2+3, y: -worldHeight/2, z: 0)
        let fieldNode:SCNNode = attachImpulseField(strength: 800, offset: fieldOriginOffset, fieldType: SCNPhysicsField.electric())
        
        
        //Just to see the center
//        let spikeGeometry:SCNGeometry = SCNSphere(radius: 0.1)
//        spikeGeometry.materials.first?.diffuse.contents = UIColor.red
//        let spikeGeometryNode = SCNNode(geometry: spikeGeometry)
//        spikeGeometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
//        spikeGeometryNode.position = fieldOriginOffset
//        gameScene.rootNode.addChildNode(spikeGeometryNode)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            fieldNode.removeFromParentNode()
        }
    }
    
    @objc func rightButtonClicked(){
        print("right button clicked")
        for _ in 1...20 {
            createBubble(position: SCNVector3(x: worldWidth/2-3, y: -worldHeight/2 + 2.5, z: 0))
        }
        let fieldOriginOffset = SCNVector3(x: worldWidth/2-3, y: -worldHeight/2, z: 0)
        
        
        //Just to see the center
//        let spikeGeometry:SCNGeometry = SCNSphere(radius: 0.1)
//        spikeGeometry.materials.first?.diffuse.contents = UIColor.red
//        let spikeGeometryNode = SCNNode(geometry: spikeGeometry)
//        spikeGeometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
//        spikeGeometryNode.position = fieldOriginOffset
//        gameScene.rootNode.addChildNode(spikeGeometryNode)
        
        
        
        let fieldNode:SCNNode = attachImpulseField(strength: 800, offset: fieldOriginOffset, fieldType: SCNPhysicsField.electric())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            fieldNode.removeFromParentNode()
        }
    }
    
    
    func createRightButton() {
        let rightButton = UIButton(type: UIButtonType.custom)
        
        let x_ButtonPosition:Float = -20
        let y_ButtonPosition:Float = 0
        
        rightButton.setImage(UIImage(named: "button_test.png"), for: [])
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        rightButton.addTarget(self, action: #selector(rightButtonClicked), for: UIControlEvents.touchDown)
        
        gameView.addSubview(rightButton)
        
        //set constrains:
        NSLayoutConstraint.activate([
            rightButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: CGFloat(x_ButtonPosition)),
            rightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat(y_ButtonPosition)),
            rightButton.widthAnchor.constraint(equalToConstant: 100),
            rightButton.heightAnchor.constraint(equalToConstant: 100)
            ])
    }
    
    func attachImpulseField(strength: Float, offset: SCNVector3, fieldType: SCNPhysicsField) -> SCNNode {
        let fieldNode = SCNNode()
        fieldNode.physicsField = fieldType
        fieldNode.physicsField?.strength = CGFloat(strength)
        fieldNode.physicsField?.offset = offset
        gameScene.rootNode.addChildNode(fieldNode)
        return fieldNode
    }
    
    func createRings() {
        for _ in 1...5 {
            createRing()
        }
    }
    
    func createRing() {
        let ringRadius:Float = 1.0
        let geometry:SCNGeometry = SCNTorus(ringRadius: CGFloat(ringRadius), pipeRadius: 0.1)
        let geometryNode = SCNNode(geometry: geometry)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        geometryNode.physicsBody?.charge = 1
        geometry.materials.first?.diffuse.contents = UIColor.blue
        
        gameScene.rootNode.addChildNode(geometryNode)
        
        let randomPosition:Float = Float(arc4random_uniform(UInt32(worldWidth - 2 * ringRadius) * 100) / 100) - worldWidth/2 - ringRadius;
        
        geometryNode.position = SCNVector3(x:randomPosition, y:-8, z:0)
        
        let randomDirection:Float = arc4random_uniform(2) == 0 ? -1.0 : 1
        //        let force = SCNVector3(x:randomDirection, y:20, z:0)
        //
        //geometryNode.physicsBody?.applyForce(force, at: SCNVector3(x: 0.1, y: 0.4, z:0.05), asImpulse: true)
        
    }
    
    func createBubble(position: SCNVector3) {
        let bubblesRadius:Float = Float(arc4random_uniform(800)) / 1000
        let geometry:SCNGeometry = SCNSphere(radius: CGFloat(bubblesRadius))
        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.position = position
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        geometry.materials.first?.diffuse.contents = UIColor.yellow

        
        gameScene.rootNode.addChildNode(geometryNode)
        
//        let randomPosition:Float = Float(arc4random_uniform(UInt32(worldWidth - 2 * ringRadius))) - worldWidth/2 - ringRadius;
        
//        geometryNode.position = SCNVector3(x:randomPosition, y:-8, z:0)
        
        let randomDirection:Float = arc4random_uniform(2) == 0 ? -1.0 : 1
        
        let force = SCNVector3(x:randomDirection, y:70, z:0)
    
        geometryNode.physicsBody?.applyForce(force, at: SCNVector3(x: 0.1, y: 0.4, z:0.05), asImpulse: true)
    }
    
    func createSpikes() {
        let spikeGeometry:SCNGeometry = SCNCylinder(radius: 1.0, height: 4.0)
        
        spikeGeometry.materials.first?.diffuse.contents = UIColor.red
        
        let spikeGeometryNode = SCNNode(geometry: spikeGeometry)
        spikeGeometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        gameScene.rootNode.addChildNode(spikeGeometryNode)
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//        if time > targetCreationTime {
//            createRings()
//            targetCreationTime = time + 0.6
//        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}

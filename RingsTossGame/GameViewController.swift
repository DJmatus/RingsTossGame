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
    
    let bottom_height:Float = 0
    let top_height:Float = 19
    let left_depth:Float = -9
    let right_depth:Float = 9
    

    var gameView:SCNView!
    var gameScene:SCNScene!
    var cameraNode:SCNNode!
    var targetCreationTime:TimeInterval = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initScene()
        initCamera()
        
        createBounderies()
        createSpikes()
        createRings()
    }
    
    func initView() {
        gameView = self.view as! SCNView
        gameView.allowsCameraControl = true
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
        
        cameraNode.position = SCNVector3(x:0, y:5, z:30)
        
        gameScene.rootNode.addChildNode(cameraNode)
        
        
//        cameraNode.camera?.zFar;
//        cameraNode.camera?.zNear;
//        cameraNode.camera?.fieldOfView;
//        print(cameraNode.camera?.fieldOfView)
//        print(cameraNode.camera?.xFov)
//        print(cameraNode.camera?.yFov)
    
    }
    
    func createBounderies() {
        createTopBoundery()
        createBottomBoundery()
        createLeftBoundery()
        createRightBoundery()
        createFrontBoundery()
    }
    
    func createTopBoundery () {
        let boundingWallTop:SCNGeometry = SCNPlane(width: 20, height: 10)

        boundingWallTop.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallTop)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        let transferToYZPlane = SCNVector3(Float.pi/2, 0 , 0);

        geometryNode.eulerAngles = transferToYZPlane
        geometryNode.position = SCNVector3(x:0, y:19, z:0)
        gameScene.rootNode.addChildNode(geometryNode)
    }
    
    func createBottomBoundery () {
        let boundingWallBottom:SCNGeometry = SCNPlane(width: 20, height: 10)
        
        boundingWallBottom.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallBottom)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        let transferToYZPlane = SCNVector3(Float.pi/2, 0 , 0);
        
        geometryNode.eulerAngles = transferToYZPlane
        geometryNode.position = SCNVector3(x:0, y:-12, z:0)
        gameScene.rootNode.addChildNode(geometryNode)
        
    }
    
    func createLeftBoundery () {
        let boundingWallLeft:SCNGeometry = SCNPlane(width: 10, height: 35)
        
        boundingWallLeft.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallLeft)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        let transferToYZPlane = SCNVector3(0, Float.pi/2, 0);
        
        geometryNode.eulerAngles = transferToYZPlane
        geometryNode.position = SCNVector3(x:right_depth, y:0, z:0)
        gameScene.rootNode.addChildNode(geometryNode)
        
    }
    
    func createRightBoundery () {
        let boundingWallRight:SCNGeometry = SCNPlane(width: 10, height: 35)
        
        boundingWallRight.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallRight)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        let transferToYZPlane = SCNVector3(0, Float.pi/2, 0);
        
        geometryNode.eulerAngles = transferToYZPlane
        geometryNode.position = SCNVector3(x:left_depth, y:0, z:0)
        gameScene.rootNode.addChildNode(geometryNode)
        
    }
    
    func createFrontBoundery() {
        let boundingWallFront:SCNGeometry = SCNPlane(width: 20, height: 35)
        
        boundingWallFront.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallFront)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
//        
//        let transferToYZPlane = SCNVector3(0, Float.pi/2, 0);
//        
//        geometryNode.eulerAngles = transferToYZPlane
//        geometryNode.position = SCNVector3(x:left_depth, y:0, z:0)
        gameScene.rootNode.addChildNode(geometryNode)
    }
    
    func createBoundingWallTemplate() -> SCNGeometry {
        let boundingWall: SCNGeometry = SCNPlane(width: 10, height: 10)
        boundingWall.materials.first?.diffuse.contents = UIColor.white
        
        return boundingWall
    }
    
    func createRings() {
        for _ in 1...5 {
            createOneRing()
        }
    }
    
    func createOneRing() {
        let geometry:SCNGeometry = SCNTorus(ringRadius: 1.0, pipeRadius: 0.1)
        
        geometry.materials.first?.diffuse.contents = UIColor.blue
        
        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
        gameScene.rootNode.addChildNode(geometryNode)
        
        let randomPosition:Float = Float(arc4random_uniform(UInt32(right_depth - left_depth))) + left_depth;
        geometryNode.position = SCNVector3(x:randomPosition, y:-11, z:0)
        
        
//
//        let randomDirection:Float = arc4random_uniform(2) == 0 ? -1.0 : 1
//        let force = SCNVector3(x:randomDirection, y:20, z:0)
//
//        geometryNode.physicsBody?.applyForce(force, at: SCNVector3(x: 0.1, y: 0.4, z:0.05), asImpulse: true)
        
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

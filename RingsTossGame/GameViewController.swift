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
    
    //    TO DO: We might not need this since it can be calculated based on world(...) constants.
    let bottom_height:Float = 0
    let top_height:Float = 19
    let left_depth:Float = -9.5
    let right_depth:Float = 9.5
    
    
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
        
        createBounderies()
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
    
    func createBounderies() {
        createTopBoundery()
        createBottomBoundery()
        createLeftBoundery()
        createRightBoundery()
        createFrontBoundery()
        createBackBoundery()
        
//        let box:Any = [createRightBoundery(), createLeftBoundery(), createTopBoundery(), createBottomBoundery(), createFrontBoundery(), createBackBoundery()]
        
        
    }
    
    func createTopBoundery () {
        let boundingWallTop:SCNGeometry = SCNPlane(width: CGFloat(worldWidth), height: CGFloat(worldDepth))

        boundingWallTop.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallTop)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        //rotation:
        let transferToYZPlane = SCNVector3(Float.pi/2, 0 , 0);
        geometryNode.eulerAngles = transferToYZPlane
        
        geometryNode.position = SCNVector3(x:0, y:worldHeight/2 + 5, z:0)
        
        gameScene.rootNode.addChildNode(geometryNode)
        
    }
    
    func createBottomBoundery () {
        let boundingWallBottom:SCNGeometry = SCNPlane(width: CGFloat(worldWidth), height: CGFloat(worldDepth))
        
        boundingWallBottom.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallBottom)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        let transferToYZPlane = SCNVector3(Float.pi/2, 0 , 0);
        geometryNode.eulerAngles = transferToYZPlane
        
        geometryNode.position = SCNVector3(x:0, y:-worldHeight/2 + 5, z:0)
        
        gameScene.rootNode.addChildNode(geometryNode)
        
    }
    
    func createLeftBoundery () {
        let boundingWallLeft:SCNGeometry = SCNPlane(width: CGFloat(worldDepth), height: CGFloat(worldHeight))
        
        boundingWallLeft.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallLeft)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        let transferToYZPlane = SCNVector3(0, Float.pi/2, 0);
        geometryNode.eulerAngles = transferToYZPlane
        
        geometryNode.position = SCNVector3(x:worldWidth/2, y:5, z:0)
        
        gameScene.rootNode.addChildNode(geometryNode)
        
    }
    
    func createRightBoundery () {
        let boundingWallRight:SCNGeometry = SCNPlane(width: CGFloat(worldDepth), height: CGFloat(worldHeight))
        
        boundingWallRight.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallRight)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        let transferToYZPlane = SCNVector3(0, Float.pi/2, 0);
        geometryNode.eulerAngles = transferToYZPlane
        
        geometryNode.position = SCNVector3(x:-worldWidth/2, y:5, z:0)
        
        gameScene.rootNode.addChildNode(geometryNode)
        
    }
    
    func createFrontBoundery() {
        let boundingWallFront:SCNGeometry = SCNPlane(width: CGFloat(worldWidth), height: CGFloat(worldHeight))
        
        boundingWallFront.materials.first?.diffuse.contents = UIColor.white.withAlphaComponent(0)
        
        let geometryNode = SCNNode(geometry:boundingWallFront)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
//
//        let transferToYZPlane = SCNVector3(0, Float.pi/2, 0);
//
//        geometryNode.eulerAngles = transferToYZPlane
        geometryNode.position = SCNVector3(x:0, y:5, z:worldDepth/2)
        
        gameScene.rootNode.addChildNode(geometryNode)
    }
    
    func createBackBoundery() {
        
        let boundingWallFront:SCNGeometry = SCNPlane(width: CGFloat(worldWidth), height: CGFloat(worldHeight))
        
        boundingWallFront.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallFront)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        //
        //        let transferToYZPlane = SCNVector3(0, Float.pi/2, 0);
        //
        //        geometryNode.eulerAngles = transferToYZPlane
        
        geometryNode.position = SCNVector3(x:0, y:5, z:-worldDepth/2)
        
        gameScene.rootNode.addChildNode(geometryNode)
        
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
        let y_ButtonPosition:Float = -20
        
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
    }

    func createRightButton() {
        let rightButton = UIButton(type: UIButtonType.custom)
        
        let x_ButtonPosition:Float = -20
        let y_ButtonPosition:Float = -20
        
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
    
    @objc func rightButtonClicked(){
        print("right button clicked")
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
        geometry.materials.first?.diffuse.contents = UIColor.blue
        
        gameScene.rootNode.addChildNode(geometryNode)
        
//        let randomPosition:Float = Float(arc4random_uniform(UInt32(worldWidth - 2 * ringRadius))) - worldWidth/2 - ringRadius;

        let randomPosition:Float = Float(arc4random_uniform(UInt32(right_depth - left_depth))) + left_depth;
        
        geometryNode.position = SCNVector3(x:randomPosition, y:-11, z:0)
    
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

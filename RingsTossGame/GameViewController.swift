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
//import SpriteKit

class GameViewController: UIViewController, SCNSceneRendererDelegate {
    
    let worldHeight:Float = 30
    let worldWidth:Float = 19
    let worldDepth:Float = 3

    var gameView:SCNView!
    var gameScene:SCNScene!
    var cameraNode:SCNNode!
    var targetCreationTime:TimeInterval = 0
    
    var ringShape: SCNNode!
    var rings: [SCNNode] = []
    
    let physics = Physics()
//    let buttons = Buttons()
    
    let queue = DispatchQueue(label: "removeBubble")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initScene()
        initCamera()
        
        createBoundaries()
        createSpikes()
        createRings()
        
        createButtons()
        createDragField()
    }
    
    
    
    func initView() {
//        gameView = SCNView(frame: self.view.frame)
        gameView = self.view as! SCNView
        gameView.allowsCameraControl = false
        gameView.autoenablesDefaultLighting = true
        gameView.delegate = self
        gameView.showsStatistics = true
    }
    
    func initScene() {
        gameScene = SCNScene()
        gameView.scene = gameScene
        gameScene.background.contents = UIImage(named:"sea.png")
        
        gameView.isPlaying = true
    }
    
    func initCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        cameraNode.position = SCNVector3(x:0, y:0, z:30)
        
        gameScene.rootNode.addChildNode(cameraNode)
        
    }
    
    //Get random float between two integers
    func getRandomFloat(floor: UInt32, ceiling: UInt32) -> Float {
        return Float(arc4random_uniform((ceiling-floor) * 1000) + floor * 1000) / Float(1000)
    }
    
    
    func createDragField() {
        createField(strength: 0.5, offset: SCNVector3(x: 0, y: 0, z:0), fieldType: SCNPhysicsField.drag())
    }
    
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
        let y_ButtonPosition:Float = -10

        leftButton.setImage(UIImage(named: "button.png"), for: [])
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.addTarget(self, action: #selector(leftButtonClicked), for: UIControlEvents.touchDown)

        gameView.addSubview(leftButton)

        //set constrains:
        NSLayoutConstraint.activate([
            leftButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(x_ButtonPosition)),
            leftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat(y_ButtonPosition)),
            leftButton.widthAnchor.constraint(equalToConstant: 100),
            leftButton.heightAnchor.constraint(equalToConstant: 82)
            ])
    }

    @objc func leftButtonClicked(){
        print("Left button clicked")
        for _ in 1...10 {
            createBubble(position: SCNVector3(x: -worldWidth/2+3, y: -worldHeight/2 + 2.5, z: 0))
        }
        let fieldOriginOffset = SCNVector3(x: -worldWidth/2+3, y: -worldHeight/2, z: 0)
        let fieldNode:SCNNode = createField(strength: 800, offset: fieldOriginOffset, fieldType: SCNPhysicsField.electric())


        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            fieldNode.removeFromParentNode()
        }
    }

    @objc func rightButtonClicked(){
        print("right button clicked")
        for _ in 1...10 {
            createBubble(position: SCNVector3(x: worldWidth/2-3, y: -worldHeight/2 + 2.5, z: 0))
        }
        let fieldOriginOffset = SCNVector3(x: worldWidth/2-3, y: -worldHeight/2, z: 0)

        let fieldNode:SCNNode = createField(strength: 800, offset: fieldOriginOffset, fieldType: SCNPhysicsField.electric())

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            fieldNode.removeFromParentNode()
        }
    }


    func createRightButton() {
        let rightButton = UIButton(type: UIButtonType.custom)

        let x_ButtonPosition:Float = -20
        let y_ButtonPosition:Float = -10

        rightButton.setImage(UIImage(named: "button.png"), for: [])
        rightButton.translatesAutoresizingMaskIntoConstraints = false

        rightButton.addTarget(self, action: #selector(rightButtonClicked), for: UIControlEvents.touchDown)

        gameView.addSubview(rightButton)

        //set constrains:
        NSLayoutConstraint.activate([
            rightButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: CGFloat(x_ButtonPosition)),
            rightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat(y_ButtonPosition)),
            rightButton.widthAnchor.constraint(equalToConstant: 100),
            rightButton.heightAnchor.constraint(equalToConstant: 82)
            ])
    }

    func createField(strength: Float, offset: SCNVector3, fieldType: SCNPhysicsField) -> SCNNode {
        let fieldNode = SCNNode()
        fieldNode.physicsField = fieldType
        fieldNode.physicsField?.strength = CGFloat(strength)
        fieldNode.physicsField?.offset = offset
        gameScene.rootNode.addChildNode(fieldNode)
        return fieldNode
    }

    //Polygon as compound node for physics shape of the ring
    func ringCompoundShape (radius: CGFloat, pipeRadius: CGFloat, numOfVertices: Int) -> SCNNode {
        // a node to hold the compound geometry
        let parent = SCNNode()


        let centerAngle: Float = Float.pi * 2 / Float(numOfVertices)

        // one node with a cyclinder edge
        let edgeLength = CGFloat(tan(centerAngle / Float(2))) * radius * 2 + radius/5
        let cylinder = SCNNode(geometry: SCNCylinder(radius: pipeRadius, height: edgeLength))
        cylinder.geometry?.materials.first?.diffuse.contents = UIColor.yellow


        // inner func to clone the cylinder to a specific position
        func edge(x : CGFloat, y: CGFloat, z: CGFloat, rotation: SCNVector3) -> SCNNode {
            let node = cylinder.clone()
            node.position = SCNVector3(x: Float(x), y: Float(y), z: Float(z))
            node.eulerAngles = rotation
            return node
        }




        for i in 0...numOfVertices {
            let centerDisplacementAngle = Double((Float(i)) * centerAngle)
            let edgeRotation = -(Float(numOfVertices - 2) / Float(numOfVertices) * Float.pi * Float(i))
            let rotateOnZ: SCNVector3 = SCNVector3(0, 0, edgeRotation)

            parent.addChildNode(edge(x:  radius * CGFloat(cos(centerDisplacementAngle)), y:  radius * CGFloat(sin(centerDisplacementAngle)), z: 0, rotation: rotateOnZ))
        }

        parent.eulerAngles = SCNVector3(Float.pi/2 , 0 , 0)
        return parent
    }

    func createRings() {
        for _ in 1...5 {
//            createRing()
            rings.append(createRing())
        }
    }
    
    func createRing() -> SCNNode{
        
        // Rings design
        let ringRadius:Float = 1.0
        let geometry: SCNGeometry = SCNTorus(ringRadius: CGFloat(ringRadius), pipeRadius: 0.1)
        let geometryNode = SCNNode(geometry: geometry)
        
        if (ringShape == nil){
            ringShape = ringCompoundShape(radius: CGFloat(ringRadius), pipeRadius: 0.1, numOfVertices: 8)
            
        }
        
        let physicshape: SCNPhysicsShape = SCNPhysicsShape(node: ringShape.clone() , options: [SCNPhysicsShape.Option.keepAsCompound: true])
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: physicshape)

        geometryNode.physicsBody?.charge = 1
        geometry.materials.first?.diffuse.contents = UIColor(red:1.00, green:0.35, blue:0.37, alpha:1.0)
        gameScene.rootNode.addChildNode(geometryNode)
//        gameScene.rootNode.addChildNode(nodeCompound)
        
        
        // Collision
        geometryNode.physicsBody?.categoryBitMask =    physics.ringCategoryMask
        geometryNode.physicsBody?.collisionBitMask =   physics.ringCategoryMask | physics.spikeCategoryMask | physics.bubblesCategoryMask | physics.otherBoundariesCategoryMask | physics.topBoundaryCategoryMask
        
        
        // Rings position after opening the app
        let randomPosition:Float = Float(arc4random_uniform(UInt32(worldWidth / 2 - ringRadius + worldWidth / 2 + ringRadius))) - worldWidth / 2 + ringRadius;
        geometryNode.position = SCNVector3(x:randomPosition, y:-8, z:0)
//        geometryNode.position = SCNVector3(x:randomPosition, y:-8, z:0)
        
        return geometryNode
    }
    
    
    func createBubble(position: SCNVector3) {
        let bubblesRadius:Float = getRandomFloat(floor: 4, ceiling: 8) / 10
        let geometry:SCNGeometry = SCNSphere(radius: CGFloat(bubblesRadius))
        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.position = position

        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        geometry.materials.first?.diffuse.contents = UIColor(red:0.23, green:0.56, blue:0.65, alpha:0.5)

        gameScene.rootNode.addChildNode(geometryNode)


//        let randomPosition:Float = Float(arc4random_uniform(UInt32(worldWidth - 2 * ringRadius))) - worldWidth/2 - ringRadius;

//        geometryNode.position = SCNVector3(x:randomPosition, y:-8, z:0)

        let forceXDirection:Float = Float(arc4random_uniform(20)) - Float(10)
        let force = SCNVector3(x:forceXDirection, y:40, z:0)
        
        // Collision
        geometryNode.physicsBody?.applyForce(force, at: SCNVector3(x: 0.1, y: 0.4, z:0.05), asImpulse: true)
        geometryNode.physicsBody?.categoryBitMask =    physics.bubblesCategoryMask
        geometryNode.physicsBody?.collisionBitMask =   physics.otherBoundariesCategoryMask | physics.ringCategoryMask | physics.spikeCategoryMask | physics.bubblesCategoryMask
        queue.asyncAfter(deadline: .now() + 1) {
            geometryNode.removeFromParentNode()
        }
    }
    
    func createSpikes() {
        createSpike(position: SCNVector3(x: 0, y: 0, z: 0))
    }
    
    func createSpike(position: SCNVector3) {
        let spikeLength:CGFloat = 4;
        let spikeGeometry:SCNGeometry = SCNCylinder(radius: 0.3, height: 4.0)
        let baseSphereRadius:CGFloat = 1
        let spikeColor = UIColor(red:0.01, green:0.18, blue:0.25, alpha:1.0)
        let geometryNode = SCNNode()
        
        spikeGeometry.materials.first?.diffuse.contents =
            UIColor(red:0.01, green:0.18, blue:0.25, alpha:1.0)
        
        let spikeGeometryNode = SCNNode(geometry: spikeGeometry)
        spikeGeometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        geometryNode.physicsBody?.categoryBitMask =    physics.spikeCategoryMask
        
        gameScene.rootNode.addChildNode(spikeGeometryNode)
        
        //Base of the spike, a sphere
        let spikeBaseGeometry:SCNGeometry = SCNSphere(radius: baseSphereRadius)
        spikeBaseGeometry.materials.first?.diffuse.contents = spikeColor
        let spikeBaseGeometryNode = SCNNode(geometry: spikeBaseGeometry)
        spikeBaseGeometryNode.position = SCNVector3(x: position.x, y: position.y - Float(spikeLength/2 + baseSphereRadius) + 0.1, z: position.z)
        spikeBaseGeometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        spikeBaseGeometryNode.physicsBody?.categoryBitMask = physics.spikeCategoryMask
        
        gameScene.rootNode.addChildNode(spikeGeometryNode)
        gameScene.rootNode.addChildNode(spikeBaseGeometryNode)
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

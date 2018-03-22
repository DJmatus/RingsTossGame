//
//  BoundryBox.swift
//  RingsTossGame
//
//  Created by Daria Matusik on 3/18/18.
//  Copyright © 2018 Daria Matusik. All rights reserved.
//

import UIKit
import SceneKit

class BoundaryBox {
    
    let boxHeight:Float
    let boxWidth:Float
    let boxDepth:Float
    
    init (boxHeight: Float, boxWidth: Float, boxDepth: Float) {
        self.boxHeight = boxHeight
        self.boxWidth = boxWidth
        self.boxDepth = boxDepth + 2
    }
    
    func createTopBoundary () -> SCNNode {
//        let boundingWallTop:SCNGeometry = SCNPlane(width: CGFloat(boxWidth), height: CGFloat(boxDepth))
        let boundingWallTop:SCNGeometry = SCNBox(width: CGFloat(boxWidth + 10), height: CGFloat(boxDepth + 10), length : 1, chamferRadius: 0)
        
        boundingWallTop.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallTop)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
//        geometryNode.physicsBody?.categoryBitMask = geometryNode.physicsBody!.categoryBitMask ^ 0b10
        
        geometryNode.categoryBitMask = 0b0000000000000000000000000000000000000000000000000000000000010000
        
        //rotation:
        let transferToYZPlane = SCNVector3(Float.pi/2, 0 , 0);
        geometryNode.eulerAngles = transferToYZPlane
        
        geometryNode.position = SCNVector3(x:0, y:boxHeight/2, z:0)
        
        return geometryNode
        
    }
    
    func createBottomBoundary () -> SCNNode {
//        let boundingWallBottom:SCNGeometry = SCNPlane(width: CGFloat(boxWidth), height: CGFloat(boxDepth))
        let boundingWallBottom:SCNGeometry = SCNBox(width: CGFloat(boxWidth + 10), height: CGFloat(boxDepth + 10), length : 1, chamferRadius: 0)
        
        boundingWallBottom.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry: boundingWallBottom)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        let transferToYZPlane = SCNVector3(.pi / 2.0, 0, 0);
        geometryNode.eulerAngles = transferToYZPlane
        
        geometryNode.position = SCNVector3(x: 0, y: -boxHeight / 2, z: 0)
        
        return geometryNode
        
    }
    
    func createLeftBoundary () -> SCNNode {
//        let boundingWallLeft:SCNGeometry = SCNPlane(width: CGFloat(boxDepth), height: CGFloat(boxHeight))
        let boundingWallLeft:SCNGeometry = SCNBox(width: CGFloat(boxDepth + 10), height: CGFloat(boxHeight + 10), length : 1, chamferRadius: 0)
        
        boundingWallLeft.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallLeft)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        let transferToYZPlane = SCNVector3(0, Float.pi/2, 0);
        geometryNode.eulerAngles = transferToYZPlane
        
        geometryNode.position = SCNVector3(x:boxWidth/2, y:0, z:0)
        
        return geometryNode
        
    }
    
    func createRightBoundary () -> SCNNode {
//        let boundingWallRight:SCNGeometry = SCNPlane(width: CGFloat(boxDepth), height: CGFloat(boxHeight))
        let boundingWallRight:SCNGeometry = SCNBox(width: CGFloat(boxDepth + 10), height: CGFloat(boxHeight + 10), length : 1, chamferRadius: 0)
        
        boundingWallRight.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallRight)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        let transferToYZPlane = SCNVector3(0, Float.pi/2, 0);
        geometryNode.eulerAngles = transferToYZPlane
        
        geometryNode.position = SCNVector3(x:-boxWidth/2, y:0, z:0)
        
        return geometryNode
        
    }
    
    func createFrontBoundary() -> SCNNode {
//        let boundingWallFront:SCNGeometry = SCNPlane(width: CGFloat(boxWidth), height: CGFloat(boxHeight))
        let boundingWallFront:SCNGeometry = SCNBox(width: CGFloat(boxWidth + 10), height: CGFloat(boxHeight + 10), length : 1, chamferRadius: 0)
        
        boundingWallFront.materials.first?.diffuse.contents = UIColor.white.withAlphaComponent(0)
        
        let geometryNode = SCNNode(geometry:boundingWallFront)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        //
        //        let transferToYZPlane = SCNVector3(0, Float.pi/2, 0);
        //
        //        geometryNode.eulerAngles = transferToYZPlane
        geometryNode.position = SCNVector3(x:0, y:0, z:boxDepth/2)
        
        return geometryNode
    }
    
    func createBackBoundary() -> SCNNode {
        
//        let boundingWallFront:SCNGeometry = SCNPlane(width: CGFloat(boxWidth), height: CGFloat(boxHeight))
        let boundingWallFront:SCNGeometry = SCNBox(width: CGFloat(boxWidth + 10), height: CGFloat(boxHeight + 10), length : 1, chamferRadius: 0)
        
        boundingWallFront.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallFront)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        //
        //        let transferToYZPlane = SCNVector3(0, Float.pi/2, 0);
        //
        //        geometryNode.eulerAngles = transferToYZPlane
        
        geometryNode.position = SCNVector3(x:0, y:0, z:-boxDepth/2)
        
        return geometryNode
        
    }
}

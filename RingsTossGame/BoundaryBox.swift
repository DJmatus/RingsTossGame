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
        self.boxDepth = boxDepth
    }
    
    func createTopBoundary () -> SCNNode {
        let boundingWallTop:SCNGeometry = SCNPlane(width: CGFloat(boxWidth), height: CGFloat(boxDepth))
        
        boundingWallTop.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallTop)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        //rotation:
        let transferToYZPlane = SCNVector3(Float.pi/2, 0 , 0);
        geometryNode.eulerAngles = transferToYZPlane
        
        geometryNode.position = SCNVector3(x:0, y:boxHeight/2, z:0)
        
        return geometryNode
        
    }
    
    func createBottomBoundary () -> SCNNode {
        let boundingWallBottom:SCNGeometry = SCNPlane(width: CGFloat(boxWidth), height: CGFloat(boxDepth))
        
        boundingWallBottom.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry: boundingWallBottom)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        let transferToYZPlane = SCNVector3(.pi / 2.0, 0, 0);
        geometryNode.eulerAngles = transferToYZPlane
        
        geometryNode.position = SCNVector3(x: 0, y: -boxHeight / 2, z: 0)
        
        return geometryNode
        
    }
    
    func createLeftBoundary () -> SCNNode {
        let boundingWallLeft:SCNGeometry = SCNPlane(width: CGFloat(boxDepth), height: CGFloat(boxHeight))
        
        boundingWallLeft.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallLeft)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        let transferToYZPlane = SCNVector3(0, Float.pi/2, 0);
        geometryNode.eulerAngles = transferToYZPlane
        
        geometryNode.position = SCNVector3(x:boxWidth/2, y:0, z:0)
        
        return geometryNode
        
    }
    
    func createRightBoundary () -> SCNNode {
        let boundingWallRight:SCNGeometry = SCNPlane(width: CGFloat(boxDepth), height: CGFloat(boxHeight))
        
        boundingWallRight.materials.first?.diffuse.contents = UIColor.white
        
        let geometryNode = SCNNode(geometry:boundingWallRight)
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        let transferToYZPlane = SCNVector3(0, Float.pi/2, 0);
        geometryNode.eulerAngles = transferToYZPlane
        
        geometryNode.position = SCNVector3(x:-boxWidth/2, y:0, z:0)
        
        return geometryNode
        
    }
    
    func createFrontBoundary() -> SCNNode {
        let boundingWallFront:SCNGeometry = SCNPlane(width: CGFloat(boxWidth), height: CGFloat(boxHeight))
        
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
        
        let boundingWallFront:SCNGeometry = SCNPlane(width: CGFloat(boxWidth), height: CGFloat(boxHeight))
        
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

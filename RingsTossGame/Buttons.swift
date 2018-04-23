////
////  File.swift
////  RingsTossGame
////
////  Created by Daria Matusik on 4/9/18.
////  Copyright © 2018 Daria Matusik. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//
//class Buttons: UIViewController {
//    
//    func createLeftButton() {
//        let leftButton = UIButton(type: UIButtonType.custom)
//        
//        let x_ButtonPosition:Float = 20
//        let y_ButtonPosition:Float = -10
//        
//        leftButton.setImage(UIImage(named: "button.png"), for: [])
//        leftButton.translatesAutoresizingMaskIntoConstraints = false
//        leftButton.addTarget(self, action: #selector(leftButtonClicked), for: UIControlEvents.touchDown)
//        
//        self.gameView.addSubview(leftButton)
//        
//        //set constrains:
//        NSLayoutConstraint.activate([
//            leftButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(x_ButtonPosition)),
//            leftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat(y_ButtonPosition)),
//            leftButton.widthAnchor.constraint(equalToConstant: 100),
//            leftButton.heightAnchor.constraint(equalToConstant: 82)
//            ])
//    }
//    
//    @objc func leftButtonClicked(){
//        print("Left button clicked")
//        for _ in 1...10 {
//            createBubble(position: SCNVector3(x: -worldWidth/2+3, y: -worldHeight/2 + 2.5, z: 0))
//        }
//        let fieldOriginOffset = SCNVector3(x: -worldWidth/2+3, y: -worldHeight/2, z: 0)
//        let fieldNode:SCNNode = createField(strength: 800, offset: fieldOriginOffset, fieldType: SCNPhysicsField.electric())
//        
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            fieldNode.removeFromParentNode()
//        }
//    }
//    
//    @objc func rightButtonClicked(){
//        print("right button clicked")
//        for _ in 1...10 {
//            createBubble(position: SCNVector3(x: worldWidth/2-3, y: -worldHeight/2 + 2.5, z: 0))
//        }
//        let fieldOriginOffset = SCNVector3(x: worldWidth/2-3, y: -worldHeight/2, z: 0)
//        
//        let fieldNode:SCNNode = createField(strength: 800, offset: fieldOriginOffset, fieldType: SCNPhysicsField.electric())
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            fieldNode.removeFromParentNode()
//        }
//    }
//    
//    
//    func createRightButton() {
//        let rightButton = UIButton(type: UIButtonType.custom)
//        
//        let x_ButtonPosition:Float = -20
//        let y_ButtonPosition:Float = -10
//        
//        rightButton.setImage(UIImage(named: "button.png"), for: [])
//        rightButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        rightButton.addTarget(self, action: #selector(rightButtonClicked), for: UIControlEvents.touchDown)
//        
//        gameView.addSubview(rightButton)
//        
//        //set constrains:
//        NSLayoutConstraint.activate([
//            rightButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: CGFloat(x_ButtonPosition)),
//            rightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat(y_ButtonPosition)),
//            rightButton.widthAnchor.constraint(equalToConstant: 100),
//            rightButton.heightAnchor.constraint(equalToConstant: 82)
//            ])
//    }
//}
//

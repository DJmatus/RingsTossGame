//
//  Physics.swift
//  RingsTossGame
//
//  Created by Daria Matusik on 3/26/18.
//  Copyright © 2018 Daria Matusik. All rights reserved.
//

import Foundation

class Physics {
    let spikeCategoryMask : Int =              0b0000000000000000000000000000000000000000000000000000000000000010
    let bubblesCategoryMask : Int =            0b0000000000000000000000000000000000000000000000000000000000000100
    let ringCategoryMask : Int =               0b0000000000000000000000000000000000000000000000000000000000001000
    let topBoundaryCategoryMask : Int =        0b0000000000000000000000000000000000000000000000000000000000010000
    let otherBoundariesCategoryMask : Int =    0b0000000000000000000000000000000000000000000000000000000000000001
}

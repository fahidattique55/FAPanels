//
//  Array+FAPanel.swift
//  FAPanels
//
//  Created by Fahid Attique on 26/07/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit
import GameplayKit


extension Collection {
   
    func shuffled() -> [Iterator.Element] {
        let shuffledArray = (self as? NSArray)?.shuffled()
        let outputArray = shuffledArray as? [Iterator.Element]
        return outputArray ?? []
    }
    
    mutating func shuffle() {
        if let selfShuffled = self.shuffled() as? Self {
            self = selfShuffled
        }
    }
}



extension ClosedRange where Bound : FloatingPoint {

    public func random() -> Bound {
        let range = self.upperBound - self.lowerBound
        let randomValue = (Bound(arc4random_uniform(UINT32_MAX)) / Bound(UINT32_MAX)) * range + self.lowerBound
        return randomValue
    }
}

//
//  UIView+FAPanel.swift
//  FAPanels
//
//  Created by Fahid Attique on 25/07/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit


public extension UIView {

    
    
    //  Snapshot of ViewController (View + Navigation bar)

    var snapshot: UIImage {
        
        UIGraphicsBeginImageContext(bounds.size)

        let context = UIGraphicsGetCurrentContext()
        layer.render(in: context!)
        
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return snapshot
    }
}

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
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)

        let context = UIGraphicsGetCurrentContext()
        layer.render(in: context!)
        
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return snapshot
    }
    
    
    
    

    
    //  Add subviews in a view

    func addSubviews(_ views: [UIView]) {
        
        for view in views {
            self.addSubview(view)
        }
    }

    
    
    
    
    
    //  Remove all from super view
    
    class func removeAllFromSuperview(_ views: [UIView]) {

        for view in views {
            view.removeFromSuperview()
        }
    }

    
    
    
    
    
    
    //  Add image in a view
    
    func addImage(_ image: UIImage) -> UIImageView {
        
        let imageView = UIImageView(image: image)
        imageView.frame = frame
        addSubview(imageView)
        
        return imageView
    }

}

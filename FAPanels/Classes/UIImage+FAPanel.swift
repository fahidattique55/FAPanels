//
//  UIImage+FAPanel.swift
//  FAPanels
//
//  Created by Fahid Attique on 25/07/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit


public extension UIImage {
    
    
    
    //  Get Array of imageViews containing the sliced images as per number of rows and columns specified
    
    func slicesWith(rows: UInt, AndColumns columns: UInt ) -> [UIImageView] {
        
        var slicedImageViews = [UIImageView]()
        let imageSize: CGSize = size

        var xPos: CGFloat = 0.0, yPos: CGFloat = 0.0
        
        let width: CGFloat  = imageSize.width/CGFloat(rows)
        let height: CGFloat = imageSize.height/CGFloat(columns)

        for y in 0..<columns {
            
            xPos = 0.0
            
            for x in 0..<rows {
                
                let rect: CGRect  = CGRect(x: xPos, y: yPos, width: width, height: height)
                let cImage: CGImage = cgImage!.cropping(to: rect)!
                let dImage: UIImage = UIImage(cgImage: cImage)
                    
                let imageView: UIImageView = UIImageView(frame: CGRect(x: CGFloat(x)*width, y: CGFloat(y)*height, width: width, height: height))
                imageView.image = dImage
                imageView.layer.borderColor = UIColor.clear.cgColor
                imageView.layer.borderWidth = 0.0

                slicedImageViews.append(imageView)
                
                xPos += width
            }
            
            yPos += height
        }

        return slicedImageViews
    }
}

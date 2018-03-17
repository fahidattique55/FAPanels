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
    
    func slicesWith(rows: UInt, AndColumns columns: UInt, borderWidth: CGFloat = 0.0, borderColor: UIColor = .black, alpha: CGFloat = 1.0 ) -> [UIImageView] {
        
        var slicedImageViews = [UIImageView]()
        let imageSize: CGSize = size

        var xPos: CGFloat = 0.0, yPos: CGFloat = 0.0
        
        let width: CGFloat  = imageSize.width/CGFloat(columns)
        let height: CGFloat = imageSize.height/CGFloat(rows)

        let imageViewWidth : CGFloat = UIScreen.main.bounds.size.width  / CGFloat(columns)
        let imageViewheight: CGFloat = UIScreen.main.bounds.size.height / CGFloat(rows)
        
        for y in 0..<rows {
            
            xPos = 0.0
            
            for x in 0..<columns {
                
                let rect: CGRect  = CGRect(x: xPos, y: yPos, width: width * scale, height: height * scale)
                let cImage: CGImage = cgImage!.cropping(to: rect)!
                let dImage: UIImage = UIImage(cgImage: cImage)
                    
                let imageView: UIImageView = UIImageView(frame: CGRect(x: CGFloat(x)*width, y: CGFloat(y)*height, width: imageViewWidth, height: imageViewheight))

                imageView.image = dImage
                imageView.layer.borderColor = borderColor.cgColor
                imageView.layer.borderWidth = borderWidth
                imageView.alpha = alpha
                
                slicedImageViews.append(imageView)
                
                xPos += width * scale
            }
            
            yPos += height * scale
        }

        return slicedImageViews
    }
}

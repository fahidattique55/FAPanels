//
//  UIViewController+FAPanel.swift
//  FAPanels
//
//  Created by Fahid Attique on 25/06/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit



public extension UIViewController {
    
    
    
    //  Get Current Active Panel
    
    var panel: FAPanelController? {
        
        get{
            var iter:UIViewController? = self.parent
            
            while (iter != nil) {
                
                if iter is FAPanelController {
                    return iter as? FAPanelController
                }
                else if (iter?.parent != nil && iter?.parent != iter) {
                    iter = iter?.parent
                }
                else {
                    iter = nil
                }
            }
            return nil
        }
    }
    
    
    
    
    
    
    
    
    //  Check Current Visible Controller is On Top

    
    func isTopVC(_ root: UIViewController?) -> Bool {
        
        if root is UINavigationController {
            let nav: UINavigationController = root as! UINavigationController
            return nav.viewControllers.count == 1
        }
        else if root is UITabBarController {
            let tab: UITabBarController = root as! UITabBarController
            return  isTopVC(tab.selectedViewController!)
        }
        return root != nil
    }
    
    
    
    
    
    
    

    //  Snapshot of ViewController (View + Navigation bar)

    var snapshot: UIImage {
        
        let screenRect: CGRect = UIScreen.main.bounds
        
        UIGraphicsBeginImageContextWithOptions(screenRect.size, false, 0.0)

        let context: CGContext = UIGraphicsGetCurrentContext()!
        UIColor.black.set()
        context.fill(screenRect);
        
        var window: UIWindow? = nil
        if #available(iOS 13.0, *) {
            window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        } else {
            window = UIApplication.shared.keyWindow!
        }
        window?.layer.render(in: context)

        let snapshot: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return snapshot
    }
}

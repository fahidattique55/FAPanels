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
    
}




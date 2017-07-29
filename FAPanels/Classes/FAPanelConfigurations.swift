//
//  FAPaenl+Configurations.swift
//  FAPanels
//
//  Created by Fahid Attique on 25/06/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit





// Enum to get visible state of panels

public enum FAPanelVisibleState:Int {
    case center = 0, left, right
}








// Configurations for Panels

public struct FAPanelConfigurations {
    
    
    // overrides leftPanelGapPercentage
    
    var leftPanelWidth : CGFloat = 280
    var rightPanelWidth: CGFloat = 280
    
    var leftPanelGapPercentage : CGFloat = 0.8
    var rightPanelGapPercentage: CGFloat = 0.8
    
    
    
    
    // resizes all subviews as well
    
    var resizeLeftPanel : Bool = false
    var resizeRightPanel: Bool = false
    
    
    
    // Adds push animation on side panels
    
    var pusheSidePanels: Bool = false
    
    
    
    
    // Bounce effects on panel animations
    
    var bounceOnLeftPanelOpen  : Bool = true
    var bounceOnRightPanelOpen : Bool = true
    var bounceOnCenterPanelOpen: Bool = true
    
    
    var bounceOnLeftPanelClose   : Bool = false
    var bounceOnRightPanelClose  : Bool = false
    var bounceOnCenterPanelChange: Bool = true
    
    var bouncePercentage : CGFloat = 0.075
    var bounceDuration   : CGFloat = 0.1
    
    
    
    
    //  Panning Gesture
    
    var canRecognizePanGesture: Bool = true
    
    var panFromEdge          : Bool = false
    var minEdgeForLeftPanel  : CGFloat = 70.0
    var minEdgeForRightPanel : CGFloat = 70.0
    
    var canLeftSwipe : Bool = true
    var canRightSwipe: Bool = true
    
    
    
    
    // restricts panning gesture to work for top VC of Navigation/TabBar Controller
    
    var restrictPanningToTopVC: Bool = true
    
    
    
    
    // Handles the interface auto rotation of visible panel
    
    var handleAutoRotation: Bool = true
    
    
    
    
    // Applies corner radius to panels
    
    var cornerRadius: CGFloat = 0.0
    
    
    
    
    // Remove panels from super view when possible
    
    var unloadRightPanel: Bool = false
    var unloadLeftPanel : Bool = false
    
    
    
    
    // Max animation duration for animations of side panels
    
    var maxAnimDuration  : CGFloat = 0.15
    
    
    
    
    // percentage of screen's width to the centerPanel.view must move for panGesture to succeed
    
    var minMovePercentage: CGFloat = 0.15
    
    
    
    
    // Only Center Panel Change animation
    
    var changeCenterPanelAnimated : Bool = true
    var centerPanelTransitionType : FAPanelTransitionType = .boxFade
    var centerPanelTransitionDuration: TimeInterval = 0.40
    
}







// Enum for center panel transition type

public enum FAPanelTransitionType: UInt {
    
    case
    
    flipFromLeft = 0,
    flipFromRight,
    flipFromTop,
    flipFromBottom,
    
    curlUp,
    curlDown,
    
    crossDissolve,

    moveRight,
    moveLeft,
    moveUp,
    moveDown,

    splitHorizontally,
    splitVertically,

    
    dumpFall,
    
    boxFade

    
    func transitionOption() -> Any {
        
        switch self {
            
            
        case .flipFromLeft:
            return UIViewAnimationOptions.transitionFlipFromLeft
            
        case .flipFromRight:
            return UIViewAnimationOptions.transitionFlipFromRight
            
        case .flipFromTop:
            return UIViewAnimationOptions.transitionFlipFromTop
            
        case .flipFromBottom:
            return UIViewAnimationOptions.transitionFlipFromBottom
            
            
            
            
            
        case .curlUp:
            return UIViewAnimationOptions.transitionCurlUp
            
        case .curlDown:
            return UIViewAnimationOptions.transitionCurlDown
            
            
            
            
            
        case .crossDissolve:
            return UIViewAnimationOptions.transitionCrossDissolve
            
            
            
            
            
        case .moveRight:
            return FAPanelTransitionType.moveRight

        case .moveLeft:
            return FAPanelTransitionType.moveLeft

        case .moveUp:
            return FAPanelTransitionType.moveUp

        case .moveDown:
            return FAPanelTransitionType.moveDown

            
            
            
            
            
        case .splitHorizontally:
            return FAPanelTransitionType.splitHorizontally

        case .splitVertically:
            return FAPanelTransitionType.splitVertically
         


        
        case .dumpFall:
            return FAPanelTransitionType.dumpFall

            
            
        case .boxFade:
            return FAPanelTransitionType.boxFade

        }
    }
}

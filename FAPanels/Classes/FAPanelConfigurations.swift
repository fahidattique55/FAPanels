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

public class FAPanelConfigurations: NSObject {
    
    
    override public init() {
        super.init()
    }
    
    // overrides leftPanelGapPercentage
    
    public var leftPanelWidth : CGFloat = 280
    public var rightPanelWidth: CGFloat = 280
    
    public var leftPanelGapPercentage : CGFloat = 0.8
    public var rightPanelGapPercentage: CGFloat = 0.8
    
    
    
    
    // resizes all subviews as well
    
    public var resizeLeftPanel : Bool = false
    public var resizeRightPanel: Bool = false
    
    
    
    // Adds push animation on side panels
    
    public var pusheSidePanels: Bool = false
    
    
    
    
    // Bounce effects on panel animations
    
    public var bounceOnLeftPanelOpen  : Bool = true
    public var bounceOnRightPanelOpen : Bool = true
    public var bounceOnCenterPanelOpen: Bool = true
    
    
    public var bounceOnLeftPanelClose   : Bool = false
    public var bounceOnRightPanelClose  : Bool = false
    public var bounceOnCenterPanelChange: Bool = true
    
    public var bouncePercentage : CGFloat = 0.075
    public var bounceDuration   : CGFloat = 0.1
    
    
    
    
    //  Panning Gesture
    
    public var canRecognizePanGesture: Bool = true
    
    public var panFromEdge          : Bool = false
    public var minEdgeForLeftPanel  : CGFloat = 70.0
    public var minEdgeForRightPanel : CGFloat = 70.0
    
    public var canLeftSwipe : Bool = true
    public var canRightSwipe: Bool = true
    
    
    
    
    // restricts panning gesture to work for top VC of Navigation/TabBar Controller
    
    public var restrictPanningToTopVC: Bool = true
    
    
    
    
    // Handles the interface auto rotation of visible panel
    
    public var handleAutoRotation: Bool = true
    
    
    
    
    // Applies corner radius to panels
    
    public var cornerRadius: CGFloat = 0.0
    
    
    
    
    // Remove panels from super view when possible
    
    public var unloadRightPanel: Bool = false
    public var unloadLeftPanel : Bool = false
    
    
    
    
    // Max animation duration for animations of side panels
    
    public var maxAnimDuration  : CGFloat = 0.15
    
    
    
    
    // percentage of screen's width to the centerPanel.view must move for panGesture to succeed
    
    public var minMovePercentage: CGFloat = 0.15
    
    
    
    
    // Only Center Panel Change animation
    
    public var changeCenterPanelAnimated : Bool = true
    public var centerPanelTransitionType : FAPanelTransitionType = .boxFade
    public var centerPanelTransitionDuration: TimeInterval = 0.40
    
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

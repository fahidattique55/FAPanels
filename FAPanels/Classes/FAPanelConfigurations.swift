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

public enum FAPanelVisibleState: Int {
    case center = 0, left, right
}







// Configurations for Panels

open class FAPanelConfigurations: NSObject {
    
    
    public override init() {
        super.init()
    }

    
    // overrides leftPanelGapPercentage
    
    open var leftPanelWidth : CGFloat = 280
    open var rightPanelWidth: CGFloat = 280
    
    open var leftPanelGapPercentage : CGFloat = 0.8
    open var rightPanelGapPercentage: CGFloat = 0.8
    
    
    
    
    // resizes all subviews as well
    
    open var resizeLeftPanel : Bool = false
    open var resizeRightPanel: Bool = true
    
    
    
    // Adds push animation on side panels
    
    open var pusheSidePanels: Bool = false
    
    
    
    
    // Bounce effects on panel animations
    
    open var bounceOnLeftPanelOpen  : Bool = true
    open var bounceOnRightPanelOpen : Bool = true
    open var bounceOnCenterPanelOpen: Bool = true
    
    
    open var bounceOnLeftPanelClose   : Bool = false
    open var bounceOnRightPanelClose  : Bool = false
    open var bounceOnCenterPanelChange: Bool = true
    
    open var bouncePercentage : CGFloat = 0.075
    open var bounceDuration   : CGFloat = 0.1
    
    
    
    
    //  Panning Gesture
    
    open var canRecognizePanGesture: Bool = true
    
    open var panFromEdge          : Bool = false
    open var minEdgeForLeftPanel  : CGFloat = 70.0
    open var minEdgeForRightPanel : CGFloat = 70.0
    
    open var canLeftSwipe : Bool = true
    open var canRightSwipe: Bool = true
    
    
    
    
    // restricts panning gesture to work for top VC of Navigation/TabBar Controller
    
    open var restrictPanningToTopVC: Bool = true
    
    
    
    
    // Handles the interface auto rotation of visible panel
    
    open var handleAutoRotation: Bool = true
    
    
    
    
    // Applies corner radius to panels
    
    open var cornerRadius: CGFloat = 0.0
    
    
    
    
    // Shadow configurations
    
    open var shadowColor   : CGColor = UIColor.black.cgColor
    open var shadowOffset  : CGSize  = CGSize(width: 5.0, height: 0.0)
    open var shadowOppacity: Float = 0.7

    
    
    
    // Remove panels from super view when possible
    
    open var unloadRightPanel: Bool = false
    open var unloadLeftPanel : Bool = false
    
    
    
    
    // Max animation duration for animations of side panels
    
    open var maxAnimDuration  : CGFloat = 0.15
    
    
    
    
    // percentage of screen's width to the centerPanel.view must move for panGesture to succeed
    
    open var minMovePercentage: CGFloat = 0.15
    
    
    
    
    // Only Center Panel Change animation
    
    open var changeCenterPanelAnimated : Bool = true
    open var centerPanelTransitionType : FAPanelTransitionType = .boxFade
    open var centerPanelTransitionDuration: TimeInterval = 0.40
    
    
    
    
    @available(*,deprecated, message: "Please use 'shouldAnimateWithPan' & 'colorForTapView' for overlays while panning.")
    open var showDarkOverlayUnderLeftPanelOnTop : Bool = true
    @available(*,deprecated, message: "Please use 'shouldAnimateWithPan' & 'colorForTapView' for overlays while panning.")
    open var darkOverlayUnderLeftPanelOnTopColor : UIColor = UIColor.black.withAlphaComponent(0.5)
    @available(*,deprecated, message: "Please use 'shouldAnimateWithPan' & 'colorForTapView' for overlays while panning.")
    open var showDarkOverlayUnderRightPanelOnTop : Bool = true
    @available(*,deprecated, message: "Please use 'shouldAnimateWithPan' & 'colorForTapView' for overlays while panning.")
    open var darkOverlayUnderRightPanelOnTopColor : UIColor = UIColor.black.withAlphaComponent(0.5)

    
    // Tap View Properties

    open var colorForTapView: UIColor = UIColor.black.withAlphaComponent(0.35)
    open var shouldAnimateWithPan: Bool = true
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
            return UIView.AnimationOptions.transitionFlipFromLeft
            
        case .flipFromRight:
            return UIView.AnimationOptions.transitionFlipFromRight
            
        case .flipFromTop:
            return UIView.AnimationOptions.transitionFlipFromTop
            
        case .flipFromBottom:
            return UIView.AnimationOptions.transitionFlipFromBottom
            
            
            
            
            
        case .curlUp:
            return UIView.AnimationOptions.transitionCurlUp
            
        case .curlDown:
            return UIView.AnimationOptions.transitionCurlDown
            
            
            
            
            
        case .crossDissolve:
            return UIView.AnimationOptions.transitionCrossDissolve
            
            
            
            
            
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

//
//  FAPanel+Gestures.swift
//  FAPanels
//
//  Created by Fahid Attique on 25/06/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit



extension FAPanelController: UIGestureRecognizerDelegate {
    
    
    
    //  GestureRecognizer Delegate
    
    
    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer.view == tapView {
            return true
        }
        else if configs.restrictPanningToTopVC && !isTopVC(centerPanelVC!) {
            return false
        }
        else if gestureRecognizer is UIPanGestureRecognizer {
            
            let pan: UIPanGestureRecognizer = gestureRecognizer as! UIPanGestureRecognizer
            
            let translate: CGPoint = pan.translation(in: centerPanelContainer)
            
            // determine if right swipe is allowed
            if (translate.x < 0 && !configs.canRightSwipe) {
                return false
            }
            // determine if left swipe is allowed
            if (translate.x > 0 && !configs.canLeftSwipe) {
                return false
            }
            
            let possible: Bool  = translate.x != 0 && ((fabsf(Float(translate.y)) / fabsf(Float(translate.x))) < 1.0)
            if (possible && ((translate.x > 0 && (leftPanelVC != nil)) || (translate.x < 0 && (rightPanelVC != nil)))) {
                
                if configs.panFromEdge {
                    
                    let touchPoint: CGPoint  = pan.location(in: pan.view!)
                    let touchPointX = touchPoint.x

                    if translate.x > 0 {
                        if touchPointX > configs.minEdgeForLeftPanel {
                            return false
                        }
                    }
                    else{
                        if touchPointX < view.frame.size.width - configs.minEdgeForRightPanel {
                            return false
                        }
                    }
                }
                return true
            }
        }
        return false
    }
    
    
    
    
    
    
    
    
    
    
    
    //  Adding Pan Gesture
    
    
    internal func addPanGesture(toView: UIView) {
        
        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan))
        
        panGesture.delegate = self
        panGesture.maximumNumberOfTouches = 1
        panGesture.minimumNumberOfTouches = 1
        toView.addGestureRecognizer(panGesture)
    }
    
    







    //  Handle Opacity Tap View
    
    internal func handleTapViewOpacity() {
        
        if state == .left && isLeftPanelOnFront {
            handleTapViewOpacityFromLeftPanelContainer()
        }
        else if state == .center && isLeftPanelOnFront && (paningStartDirection == .right) {
            handleTapViewOpacityFromLeftPanelContainer()
        }
        else if state == .right && isRightPanelOnFront {
            handleTapViewOpacityFromRightPanelContainer()
        }
        else if state == .center && isRightPanelOnFront && (paningStartDirection == .left) {
            handleTapViewOpacityFromRightPanelContainer()
        }
        else {
            handleTapViewOpacityFromCenterPanelContainer()
        }
    }
    
    internal func handleTapViewOpacityFromLeftPanelContainer() {
        
        print(abs((leftPanelContainer.frame.origin.x+leftPanelContainer.frame.width)/leftPanelContainer.frame.width))
        tapView?.alpha = abs((leftPanelContainer.frame.origin.x+leftPanelContainer.frame.width)/leftPanelContainer.frame.width)
    }
    
    internal func handleTapViewOpacityFromRightPanelContainer() {
        
        print(abs((centerPanelContainer.frame.width - rightPanelContainer.frame.origin.x)/rightPanelContainer.frame.width))
        tapView?.alpha = abs((centerPanelContainer.frame.width - rightPanelContainer.frame.origin.x)/rightPanelContainer.frame.width)
    }
    
    internal func handleTapViewOpacityFromCenterPanelContainer() {
        
        print(abs(centerPanelContainer.frame.origin.x/centerPanelContainer.frame.width))
        tapView?.alpha = abs(centerPanelContainer.frame.origin.x/centerPanelContainer.frame.width)
    }
    

    
    
    
    
    
    
    
    
    
    //  Handle Pan Gesture

    @objc internal func handlePan(_ gesture: UIGestureRecognizer) {
        
        if !configs.canRecognizePanGesture { return }
        
        if gesture is UIPanGestureRecognizer {
            
            let pan: UIPanGestureRecognizer = gesture as! UIPanGestureRecognizer
            let translation: CGPoint = pan.translation(in: centerPanelContainer)

            if configs.shouldAnimateWithPan {
                handleTapViewOpacity()
            }
            
            if pan.state == .began {
                
                paningStartDirection = translation.x < 0 ? .left : .right
                centerPanelOriginBeforePan = centerPanelContainer.frame.origin
                leftPanelOriginBeforePan   = leftPanelContainer.frame.origin
                rightPanelOriginBeforePan  = rightPanelContainer.frame.origin
            }
            else if pan.state == .changed {
                
                if state == .left && isLeftPanelOnFront {
                    updateLeftPanelForTranslation(translation)
                }
                else if state == .center && isLeftPanelOnFront && (paningStartDirection == .right) {
                    
                    loadLeftPanel()
                    updateLeftPanelForTranslation(translation)
                    return
                }
                else if state == .right && isRightPanelOnFront {
                    updateRightPanelForTranslation(translation)
                }
                else if state == .center && isRightPanelOnFront && (paningStartDirection == .left) {
                    
                    loadRightPanel()
                    updateRightPanelForTranslation(translation)
                    return
                }
                else {
                    updateCenterPanelForTranslation(translation)
                }
          }
            if gesture.state == .ended {
                
                let movement = calculateMovementInX()
                
                if shouldCompletePanFor(movement: movement) {
                    completePanFor(movement)
                }
                else {
                    undoPanAndLayoutSidePanels()
                }
            }
            else if gesture.state == .cancelled {
                undoPanAndLayoutSidePanels()
            }
        }
    }
    
    
    
    
    internal func calculateMovementInX() -> CGFloat {
        
        var movementInX: CGFloat =  centerPanelContainer.frame.origin.x - centerPanelOriginBeforePan.x
        
        if state == .center && isLeftPanelOnFront && (paningStartDirection == .right) {
            movementInX = leftPanelContainer.frame.origin.x - leftPanelOriginBeforePan.x
        }
        else if state == .left && isLeftPanelOnFront{
            movementInX = leftPanelContainer.frame.origin.x - leftPanelOriginBeforePan.x
        }
        else if state == .center && isRightPanelOnFront && (paningStartDirection == .left) {
            movementInX = rightPanelContainer.frame.origin.x - rightPanelOriginBeforePan.x
        }
        else if state == .right && isRightPanelOnFront{
            movementInX = rightPanelContainer.frame.origin.x - rightPanelOriginBeforePan.x
        }

        return movementInX
    }

    
    
    internal func undoPanAndLayoutSidePanels() {
        
        slideLeftPanelOutIfNeeded()
        slideRightPanelOutIfNeeded()
        undoPan()
    }
    
    
    
    internal func slideLeftPanelOutIfNeeded() {
        
        if state == .center && isLeftPanelOnFront {
            if paningStartDirection == .right { slideLeftPanelOut(animated: true, afterThat: nil) }
        }
    }

    
    internal func slideRightPanelOutIfNeeded() {
        
        if state == .center && isRightPanelOnFront {
            if paningStartDirection == .left { slideRightPanelOut(animated: true, afterThat: nil) }
        }
    }

    
    
    internal func updateLeftPanelForTranslation(_ translation: CGPoint) {
        
        var frame: CGRect = leftPanelContainer.frame
        frame.origin.x = CGFloat(roundf(Float(xPositionForLeftPanel(translation.x))))
        leftPanelContainer.frame = frame
    }


    internal func updateRightPanelForTranslation(_ translation: CGPoint) {
        
        var frame: CGRect = rightPanelContainer.frame
        frame.origin.x = CGFloat(roundf(Float(xPositionForRightPanel(translation.x))))
        rightPanelContainer.frame = frame
    }

    
    
    internal func updateCenterPanelForTranslation(_ translation: CGPoint) {
        
        var frame: CGRect = centeralPanelSlidingFrame
        frame.origin.x += CGFloat(roundf(Float(xPositionFor(translation.x))))
        
        if isLeftPanelOnFront && frame.origin.x > 0.0 {
            frame.origin.x = 0.0
        }
        else if isRightPanelOnFront && frame.origin.x < 0.0 {
            frame.origin.x = 0.0
        }

        centerPanelContainer.frame = frame
        
        if frame.origin.x > 0.0 { loadLeftPanel() }
        else if frame.origin.x < 0.0 { loadRightPanel() }
        if configs.pusheSidePanels { layoutSideContainers(withDuration: 0.0, animated: false) }
    }

    
    
    
    
    
    
    
    
    
    

    //  Pan Gesture Decisions According To Movement

    internal func completePanFor( _ movementInX: CGFloat) {
        
        switch state {
            
        case .center:
            
            if movementInX > 0.0 {
                openLeft(animated: true, shouldBounce: configs.bounceOnLeftPanelOpen)
            }
            else {
                openRight(animated: true, shouldBounce: configs.bounceOnRightPanelOpen)
            }
            break
            
        case .left:
            
            if isLeftPanelOnFront {
                slideLeftPanelOut(animated: true, afterThat: nil)
            }
            else {
                openCenter(animated: true, shouldBounce: configs.bounceOnLeftPanelClose, afterThat: nil)
            }
            break
            
        case .right:

            if isRightPanelOnFront {
                slideRightPanelOut(animated: true, afterThat: nil)
            }
            else {
                openCenter(animated: true, shouldBounce: configs.bounceOnRightPanelClose, afterThat: nil)
            }
            break
        }
    }
    
    
    
    
    
    
    
    
    
    
    //  Cancel Pan Gesture

    internal func undoPan() {
        
        switch state {
            
        case .center:
            openCenter(animated: true, shouldBounce: false, afterThat: nil)
            break
            
        case .left:
            openLeft(animated: true, shouldBounce: false)
            break
            
        case .right:
            openRight(animated: true, shouldBounce: false)
            break
        }
    }
    
    
    
    
    
    
    
    
    
    
    //  Tap Gesture Functions
    
    
    internal func addTapGestureToView(view: UIView) {
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self._centerPanelTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc internal func _centerPanelTapped(gesture: UIGestureRecognizer){
        
        if state == .left {
            if isLeftPanelOnFront {
                slideLeftPanelOut(animated: true, afterThat: nil)
                return
            }
        }
        else if state == .right {
            if isRightPanelOnFront {
                slideRightPanelOut(animated: true, afterThat: nil)
                return
            }
        }

        openCenter(animated: true, shouldBounce: false, afterThat: nil)
    }
}

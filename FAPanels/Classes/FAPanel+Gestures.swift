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
    
    
    
    
    
    
    
    
    
    
    //  Handle Pan Gesture

    
    internal func handlePan(_ gesture: UIGestureRecognizer) {
        
        if !configs.canRecognizePanGesture {
            return
        }
        
        if gesture is UIPanGestureRecognizer {
            
            let pan: UIPanGestureRecognizer = gesture as! UIPanGestureRecognizer
            let translate: CGPoint = pan.translation(in: centerPanelContainer)

            if pan.state == .began {
                
                paningStartDirection = translate.x < 0 ? .left : .right
                
                centerPanelOriginBeforePan = centerPanelContainer.frame.origin
                leftPanelOriginBeforePan   = leftPanelContainer.frame.origin
                
                print("leftPanelOriginBeforePan : \(leftPanelOriginBeforePan)")
                
            }
            else if pan.state == .changed {
                
                
                if state == .left && isLeftPanelOnFront{
                    
                    var frame: CGRect = leftPanelContainer.frame
                    frame.origin.x = CGFloat(roundf(Float(xPositionForLeftPanel(translate.x))))
                    leftPanelContainer.frame = frame
                    return
                }
                
                
                if state == .center {

                    if isLeftPanelOnFront {
                        
                        if paningStartDirection == .right {

                            loadLeftPanel()
                            
                            var newFrame: CGRect = leftPanelContainer.frame
                            newFrame.origin.x = CGFloat(roundf(Float(xPositionForLeftPanel(translate.x))))
                            leftPanelContainer.frame = newFrame
                            return
                        }
                    }
                }

                var frame: CGRect = centeralPanelSlidingFrame
                frame.origin.x += CGFloat(roundf(Float(xPositionFor(translate.x))))
                centerPanelContainer.frame = frame
                
                if frame.origin.x > 0.0 {
                    loadLeftPanel()
                }
                else if frame.origin.x < 0.0 {
                    loadRightPanel()
                }

                // adjust side panel locations, if needed
                if configs.pusheSidePanels {
                    layoutSideContainers(withDuration: 0.0, animated: false)
                }
            }
            if gesture.state == .ended {
                
                var movementInX: CGFloat =  centerPanelContainer.frame.origin.x - centerPanelOriginBeforePan.x

                if state == .center && isLeftPanelOnFront{

                    if paningStartDirection == .right {
                        movementInX = leftPanelContainer.frame.origin.x - leftPanelOriginBeforePan.x
                    }
                }
                else if state == .left && isLeftPanelOnFront{
                    movementInX = leftPanelContainer.frame.origin.x - leftPanelOriginBeforePan.x
                }
                
                
                
                if shouldCompletePanFor(movement: movementInX) {
                    completePanFor(movementInX)
                }
                else {
                    slideLeftPanelOutIfNeeded()
                    undoPan()
                }
            }
            else if gesture.state == .cancelled {
                slideLeftPanelOutIfNeeded()
                undoPan()
            }
        }
    }
    
    
    func slideLeftPanelOutIfNeeded() {
        
        if state == .center && isLeftPanelOnFront {
            if paningStartDirection == .right { slideLeftPanelOut(animated: true) }
        }
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
                slideLeftPanelOut(animated: true)
            }
            else {
                openCenter(animated: true, shouldBounce: configs.bounceOnLeftPanelClose)
            }
            break
            
        case .right:
            
            openCenter(animated: true, shouldBounce: configs.bounceOnRightPanelClose)
            break
        }
    }
    
    
    
    
    
    
    
    
    
    
    //  Cancel Pan Gesture

    internal func undoPan() {
        
        switch state {
            
        case .center:
            openCenter(animated: true, shouldBounce: false)
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
    
    
    internal func _centerPanelTapped(gesture: UIGestureRecognizer){
        
        if state == .left {
            if isLeftPanelOnFront {
                slideLeftPanelOut(animated: true)
                return
            }
        }

        openCenter(animated: true, shouldBounce: false)
    }
}

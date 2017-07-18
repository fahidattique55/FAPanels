//
//  FAPanel+Animations.swift
//  FAPanels
//
//  Created by Fahid Attique on 25/06/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit


extension FAPanelController {
    
    
    
    
    //  Swap Center Panel
    
    internal func swapCenter(animated:Bool, FromVC fromVC: UIViewController?, ofState previousState: FAPanelVisibleState, withVC nextVC: UIViewController?){
        
        if fromVC != nextVC {
            
            if nextVC != nil {
            
                fromVC?.willMove(toParentViewController: nil)
                fromVC?.view.removeFromSuperview()
                fromVC?.removeFromParentViewController()
                
                loadCenterPanel(FromState: previousState)
                addChildViewController(nextVC!)
                centerPanelContainer.addSubview(nextVC!.view)
                nextVC!.didMove(toParentViewController: self)
                
                if animated {
                    
                    let transitionOption = configs.centerPanelTransitionType.transitionOption() as! UIViewAnimationOptions
                    UIView.transition(with: view, duration: configs.centerPanelTransitionDuration, options: transitionOption, animations: nil, completion: nil)
                }
            }
        }
    }


//    open fileprivate(set) var bubble = UIView()
//
//    open var startingPoint = CGPoint.zero {
//        didSet {
//            bubble.center = startingPoint
//        }
//    }

    
    func frameForBubble(_ originalCenter: CGPoint, size originalSize: CGSize, start: CGPoint) -> CGRect {
        let lengthX = fmax(start.x, originalSize.width - start.x)
        let lengthY = fmax(start.y, originalSize.height - start.y)
        let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
        let size = CGSize(width: offset, height: offset)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }

    

    
    
    //  Loading of panels
    
    internal func loadCenterPanel(FromState: FAPanelVisibleState) {
        
        centerPanelVC!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        centerPanelVC!.view.frame = centerPanelContainer.bounds
        applyStyle(onView: centerPanelVC!.view)
    }
    
    
    
    internal func loadLeftPanel() {
        
        rightPanelContainer.isHidden = true
        
        if leftPanelContainer.isHidden && leftPanelVC != nil {
            
            if leftPanelVC!.view.superview == nil {
                
                layoutSidePanelVCs()
                leftPanelVC!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                applyStyle(onView: leftPanelVC!.view)
                leftPanelContainer.addSubview(leftPanelVC!.view)
            }
            leftPanelContainer.isHidden = false
        }
    }
    
    
    internal func loadRightPanel() {
        
        leftPanelContainer.isHidden = true
        
        if rightPanelContainer.isHidden && rightPanelVC != nil {
            
            if rightPanelVC!.view.superview == nil {
                
                layoutSidePanelVCs()
                rightPanelVC!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                applyStyle(onView: rightPanelVC!.view)
                rightPanelContainer.addSubview(rightPanelVC!.view)
            }
            rightPanelContainer.isHidden = false
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    //  Showing panels
    
    
    internal func openLeft(animated: Bool, shouldBounce bounce:Bool) {
        
        if leftPanelVC != nil {
            centerPanelVC?.view.endEditing(true)
            state = .left
            loadLeftPanel()
            slideCenterPanel(animated: animated, bounce: bounce)
            handleScrollsToTopForContainers(centerEnabled: false, leftEnabled: true, rightEnabled: false)
        }
    }
    
    
    internal func openRight(animated: Bool, shouldBounce bounce:Bool) {
        
        if rightPanelVC != nil {
            centerPanelVC?.view.endEditing(true)
            state = .right
            loadRightPanel()
            slideCenterPanel(animated: animated, bounce: bounce)
            handleScrollsToTopForContainers(centerEnabled: false, leftEnabled: false, rightEnabled: true)
        }
    }
    
    
    internal func openCenter(animated: Bool, shouldBounce bounce: Bool) {
        
        state = .center
        _ = updateCenterPanelSlidingFrame()
        
        if animated {
            animateCenterPanel(shouldBounce: bounce, completion: { (finished) in
                self.leftPanelContainer.isHidden = true
                self.rightPanelContainer.isHidden = true
                self.unloadPanels()
            })
        }
        else {
            updateCenterPanelContainer()
            leftPanelContainer.isHidden = true
            rightPanelContainer.isHidden = true
            unloadPanels()
        }
        
        tapView = nil
        handleScrollsToTopForContainers(centerEnabled: true, leftEnabled: false, rightEnabled: false)
    }
    
    
    private func slideCenterPanel(animated: Bool, bounce:Bool) {
        
        _ = updateCenterPanelSlidingFrame()
        if animated {
            animateCenterPanel(shouldBounce: bounce, completion: { (finished) in
            })
        }
        else {
            updateCenterPanelContainer()
        }
        tapView = UIView()
    }


    private func updateCenterPanelContainer() {
        
        centerPanelContainer.frame = centeralPanelSlidingFrame
        applyStyle(onContainer: centerPanelContainer, withDuration: 0.0, animated: false)
        if configs.pusheSidePanels {
            layoutSideContainers(withDuration: 0.0, animated: false)
        }
    }
    
    
    
    
    

    
    
    //  Hiding panels
    
    internal func hideCenterPanel() {
        centerPanelContainer.isHidden = true
        if centerPanelVC!.isViewLoaded {
            centerPanelVC!.view.removeFromSuperview()
        }
    }
    
    internal func unhideCenterPanel() {
        
        centerPanelContainer.isHidden = false
        if centerPanelVC!.view.superview == nil {
            
            centerPanelVC!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            centerPanelVC!.view.frame = centerPanelContainer.bounds
            applyStyle(onView: centerPanelVC!.view)
            centerPanelContainer.addSubview(centerPanelVC!.view)
        }
    }
    
    
    
    
    
    
    
    
    

    
    //  Unloading Panels
    
    internal func unloadPanels() {
        
        if configs.unloadLeftPanel {
            if leftPanelVC != nil {
                if leftPanelVC!.isViewLoaded {
                    leftPanelVC!.view.removeFromSuperview()
                }
            }
        }

        if configs.unloadRightPanel {
            if rightPanelVC != nil {
                if rightPanelVC!.isViewLoaded {
                    rightPanelVC!.view.removeFromSuperview()
                }
            }
        }
    }
    
    
    
    
    
    
    
    

    
    
    //  Layout Containers & Panels
    
    
    internal func layoutSideContainers( withDuration: TimeInterval, animated: Bool) {
        
        var leftFrame: CGRect  = view.bounds
        var rightFrame: CGRect = view.bounds
        
        if (configs.pusheSidePanels && !centerPanelHidden) {
            leftFrame.origin.x = centerPanelContainer.frame.origin.x - widthForLeftPanelVC
            rightFrame.origin.x = centerPanelContainer.frame.origin.x + centerPanelContainer.frame.size.width
        }
        
        leftPanelContainer.frame = leftFrame
        rightPanelContainer.frame = rightFrame
        applyStyle(onContainer: leftPanelContainer, withDuration: withDuration, animated: animated)
        applyStyle(onContainer: rightPanelContainer, withDuration: withDuration, animated: animated)
    }
    
    
    internal func layoutSidePanelVCs() {
        
        if let rightPanelVC = self.rightPanelVC {
            
            if rightPanelVC.isViewLoaded {
                
                var frame: CGRect  = rightPanelContainer.bounds
                
                if configs.resizeRightPanel {
                    
                    if !configs.pusheSidePanels {
                        frame.origin.x = rightPanelContainer.bounds.size.width - widthForRightPanelVC
                    }
                    frame.size.width = widthForRightPanelVC
                }
                rightPanelVC.view.frame = frame
            }
        }

        if let leftPanelVC = self.leftPanelVC {

            if leftPanelVC.isViewLoaded {
                
                var frame: CGRect  = leftPanelContainer.bounds
                if configs.resizeLeftPanel {
                    frame.size.width = widthForLeftPanelVC
                }
                leftPanelVC.view.frame = frame
            }
        }
    }
    
    
    internal func updateCenterPanelSlidingFrame() -> CGRect{
        
        var frame: CGRect  = view.bounds
        
        switch state {
            
        case .center:
            frame.origin.x = 0.0
            break
            
        case .left:
            frame.origin.x = widthForLeftPanelVC
            break
            
        case .right:
            frame.origin.x = -widthForRightPanelVC
            break
        }
        
        centeralPanelSlidingFrame = frame
        return centeralPanelSlidingFrame
    }
    
    
    
    
    
    
    
    
    

    
    //  Handle Scrolling

    
    internal func handleScrollsToTopForContainers(centerEnabled: Bool, leftEnabled:Bool, rightEnabled:Bool) {
        
        if (UI_USER_INTERFACE_IDIOM() == .phone) {
            
            _ = handleScrollsToTop(enabled: centerEnabled, forView: centerPanelContainer)
            _ = handleScrollsToTop(enabled: leftEnabled, forView: leftPanelContainer)
            _ = handleScrollsToTop(enabled: rightEnabled, forView: rightPanelContainer)
        }
    }
    
    
    internal func handleScrollsToTop(enabled: Bool, forView view: UIView) -> Bool {
        
        if view is UIScrollView {
            let scrollView: UIScrollView = view as! UIScrollView
            scrollView.scrollsToTop = enabled
            return true
        }
        else{
            for subView: UIView in view.subviews {
                if handleScrollsToTop(enabled: enabled, forView: subView) {
                    return true
                }
            }
        }
        return false
    }
    
    
    
    
    
    
    
    
    
    
    
    //  Panel Animations

    
    internal func animateCenterPanel(shouldBounce: Bool, completion: @escaping (_ finished: Bool) -> Void) {
        
        var bounceAllowed = shouldBounce
        let bounceDistance: CGFloat = (centeralPanelSlidingFrame.origin.x - centerPanelContainer.frame.origin.x) * configs.bouncePercentage
        if centeralPanelSlidingFrame.size.width > centerPanelContainer.frame.size.width {
            bounceAllowed = false
        }
        
        let duration: TimeInterval = TimeInterval(configs.maxAnimDuration)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear, .layoutSubviews], animations: {
            self.centerPanelContainer.frame = self.centeralPanelSlidingFrame
            self.applyStyle(onContainer: self.centerPanelContainer, withDuration: duration, animated: true)
            if self.configs.pusheSidePanels {
                self.layoutSideContainers(withDuration: 0.0, animated: false)
            }
        }, completion:{ (finished) in
            
            if (bounceAllowed) {
                
                if self.state == .center {
                    if bounceDistance > 0.0 {
                        self.loadLeftPanel()
                    } else {
                        self.loadRightPanel()
                    }
                }
                
                UIView.animate(withDuration: TimeInterval(self.configs.bounceDuration), delay: 0.0, options: .curveEaseInOut, animations: {
                    var bounceFrame: CGRect = self.centeralPanelSlidingFrame
                    bounceFrame.origin.x += bounceDistance
                    self.centerPanelContainer.frame = bounceFrame
                }, completion: { (finished) in
                    
                    UIView.animate(withDuration: TimeInterval(self.configs.bounceDuration), delay: 0.0, options: .curveEaseIn, animations: {
                        self.centerPanelContainer.frame = self.centeralPanelSlidingFrame
                    }, completion: completion)
                })
            }
            else {
                completion(finished)
            }
        })
    }
    
    
    
    internal func xPositionFor( _ translationInX: CGFloat) -> CGFloat {
        
        let position: CGFloat = centeralPanelSlidingFrame.origin.x + translationInX
        
        if state == .center {
            
            if (position > 0.0 && self.leftPanelVC == nil) || (position < 0.0 && self.rightPanelVC == nil) {
                return 0.0
            }
            else if position > widthForLeftPanelVC {
                return widthForLeftPanelVC
            }
            else if position < -widthForRightPanelVC {
                return -widthForRightPanelVC
            }
        }
        else if state == .right {
        
            if position < -widthForRightPanelVC {
                return 0.0
            }
            else if configs.pusheSidePanels && position > 0.0 {
                return -centeralPanelSlidingFrame.origin.x
            }
            else if position > rightPanelContainer.frame.origin.x {
                return rightPanelContainer.frame.origin.x - centeralPanelSlidingFrame.origin.x
            }
        }
        else if state == .left {
        
            if position > widthForLeftPanelVC {
                return 0.0
            }
            else if configs.pusheSidePanels && position < 0.0 {
                return -centeralPanelSlidingFrame.origin.x
            }
            else if position < leftPanelContainer.frame.origin.x {
                return leftPanelContainer.frame.origin.x - centeralPanelSlidingFrame.origin.x
            }
        }
        return translationInX
    }
    
    
    
    
    
    
    
    

    
    
    //  Handle Panning Decisions

    
    internal func shouldCompletePanFor(movement: CGFloat) -> Bool {
        
        let minimum: CGFloat = CGFloat(floorf(Float(view.bounds.size.width * configs.minMovePercentage)))
        
        switch state {
        case .left:
            return movement <= -minimum
            
        case .center:
            return fabsf(Float(movement)) >= Float(minimum)
            
        case .right:
            return movement >= minimum
        }
    }
}


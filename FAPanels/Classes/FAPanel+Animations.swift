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
    
    internal func swapCenter(animated:Bool, FromVC fromVC: UIViewController?, withVC nextVC: UIViewController?){
        
        if fromVC != nextVC {
            
            if nextVC != nil {
                
                if !animated {
                    swap(fromVC, withVC: nextVC)
                }
                else {
                    
                    let transitionOption = configs.centerPanelTransitionType.transitionOption()
                    
                    if transitionOption is UIView.AnimationOptions {
                        
                        swap(fromVC, withVC: nextVC)
                        performNativeTransition()
                    }
                    else {
                        
                        let snapshot = self.snapshot
                        swap(fromVC, withVC: nextVC)
                        
                        
                        let transOption = transitionOption as! FAPanelTransitionType
                        
                        switch transOption {
                            
                        case .moveRight:
                            
                            moveRight(snapshot)
                            break
                            
                        case .moveLeft:
                            moveLeft(snapshot)
                            break
                            
                        case .moveUp:
                            moveUp(snapshot)
                            break
                            
                        case .moveDown:
                            moveDown(snapshot)
                            break
                            
                            
                            
                        case .splitHorizontally:
                            splitHorizontally(snapshot)
                            break
                            
                            
                        case .splitVertically:
                            splitVertically(snapshot)
                            break
                            
                            
                        case .dumpFall:
                            dumpFall(snapshot)
                            break
                            
                            
                        case .boxFade:
                            
                            let snapshotAfterSwap = self.snapshot
                            
                            boxFade(snapshot, to: snapshotAfterSwap)
                            break

                            
                            
                        default:
                            return
                        }
                    }
                }
                
            }
        }
    }
    
    
    
    private func swap( _ fromVC: UIViewController?, withVC toVC: UIViewController?) {
        
        fromVC?.willMove(toParent: nil)
        fromVC?.view.removeFromSuperview()
        fromVC?.removeFromParent()
        loadCenterPanel()
        addChild(toVC!)
        centerPanelContainer.addSubview(toVC!.view)
        if tapView != nil {
            centerPanelContainer.bringSubviewToFront(tapView!)
        }
        toVC!.didMove(toParent: self)
    }
    
    
    
    private func performNativeTransition() {
        
        let transitionOption = configs.centerPanelTransitionType.transitionOption() as! UIView.AnimationOptions
        UIView.transition(with: view, duration: configs.centerPanelTransitionDuration, options: transitionOption, animations: nil, completion: nil)
    }
    
    
    private func moveRight( _ snapShot: UIImage) {
        
        let snapShotView = UIImageView(frame: view.frame)
        snapShotView.image = snapShot
        view.addSubview(snapShotView)
        
        UIView.transition(with: view, duration: configs.centerPanelTransitionDuration, options: [], animations: {
            
            var origin = snapShotView.frame.origin
            origin.x = snapShotView.frame.size.width
            snapShotView.frame.origin = origin
            
        }, completion: { (finished) in
            
            snapShotView.removeFromSuperview()
        })
    }
    
    
    private func moveLeft( _ snapShot: UIImage) {
        
        let snapShotView = UIImageView(frame: view.frame)
        snapShotView.image = snapShot
        view.addSubview(snapShotView)
        
        UIView.transition(with: view, duration: configs.centerPanelTransitionDuration, options: [], animations: {
            
            var origin = snapShotView.frame.origin
            origin.x = -snapShotView.frame.size.width
            snapShotView.frame.origin = origin
            
        }, completion: { (finished) in
            
            snapShotView.removeFromSuperview()
        })
    }
    
    
    private func moveUp( _ snapShot: UIImage) {
        
        let snapShotView = UIImageView(frame: view.frame)
        snapShotView.image = snapShot
        view.addSubview(snapShotView)
        
        UIView.transition(with: view, duration: configs.centerPanelTransitionDuration, options: [], animations: {
            
            var origin = snapShotView.frame.origin
            origin.y = -snapShotView.frame.size.height
            snapShotView.frame.origin = origin
            
        }, completion: { (finished) in
            
            snapShotView.removeFromSuperview()
        })
    }
    
    
    private func moveDown( _ snapShot: UIImage) {
        
        let snapShotView = UIImageView(frame: view.frame)
        snapShotView.image = snapShot
        view.addSubview(snapShotView)
        
        UIView.transition(with: view, duration: configs.centerPanelTransitionDuration, options: [], animations: {
            
            var origin = snapShotView.frame.origin
            origin.y = snapShotView.frame.size.height
            snapShotView.frame.origin = origin
            
        }, completion: { (finished) in
            
            snapShotView.removeFromSuperview()
        })
    }
    
    
    private func splitHorizontally( _ snapShot: UIImage) {
        
        let slicedImages = snapShot.slicesWith(rows: 1, AndColumns: 2)
        let leftSnapShotView  = slicedImages[0]
        let rightSnapShotView = slicedImages[1]
        
        view.addSubviews(slicedImages)
        
        UIView.animate(withDuration: configs.centerPanelTransitionDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            
            var leftSnapOrigin = leftSnapShotView.frame.origin
            leftSnapOrigin.x = -leftSnapShotView.frame.size.width
            leftSnapShotView.frame.origin = leftSnapOrigin
            
            var rightSnapOrigin = rightSnapShotView.frame.origin
            rightSnapOrigin.x = rightSnapShotView.frame.size.width*2
            rightSnapShotView.frame.origin = rightSnapOrigin

        }) { (finished) in
            
            UIView.removeAllFromSuperview(slicedImages)
        }
    }
    
    
    private func splitVertically( _ snapShot: UIImage) {
        
        let slicedImages = snapShot.slicesWith(rows: 2, AndColumns: 1)
        let topSnapShotView    = slicedImages[0]
        let bottomSnapShotView = slicedImages[1]
        
        view.addSubviews(slicedImages)

        UIView.animate(withDuration: configs.centerPanelTransitionDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            
            var topSnapOrigin = topSnapShotView.frame.origin
            topSnapOrigin.y = -topSnapShotView.frame.size.height
            topSnapShotView.frame.origin = topSnapOrigin
            
            var bottomSnapOrigin = bottomSnapShotView.frame.origin
            bottomSnapOrigin.y = bottomSnapShotView.frame.size.height*2
            bottomSnapShotView.frame.origin = bottomSnapOrigin
            
        }) { (finished) in
            UIView.removeAllFromSuperview(slicedImages)
        }
    }
    
    
    
    
    private func dumpFall( _ snapShot: UIImage) {
        
        var rows : UInt = 17
        var colms: UInt = 11
        
        if UIDevice.current.orientation != .portrait {
            colms = 17
            rows  = 11
        }

        let slicedImages = snapShot.slicesWith(rows: rows, AndColumns: colms, borderWidth: 0.5)
        view.addSubviews(slicedImages)
        
        let shuffledImages = slicedImages.shuffled()

        
        UIView.transition(with: view, duration: configs.centerPanelTransitionDuration, options: [], animations: {
            
            for (index, element) in shuffledImages.enumerated() {
                
                var elemenOrigin = element.frame.origin
                
                if index % 2 == 0 {
                    
                    element.transform = CGAffineTransform(rotationAngle: 10.0)
                    elemenOrigin.x = self.view.frame.size.width * 2
                }
                else {
                    
                    element.transform = CGAffineTransform(rotationAngle: -10.0)
                    elemenOrigin.x = -self.view.frame.size.width * 2
                }
                
                elemenOrigin.y = self.view.frame.size.height * 3
                element.frame.origin = elemenOrigin
            }
            
        }, completion: { (finished) in
            
            UIView.removeAllFromSuperview(slicedImages)
        })
    }
    
    
    
    
    private func boxFade( _ snapShot: UIImage, to snapshotAfterSwap: UIImage) {
        
        let imageBeforeSwap = view.addImage(snapShot)

        var rows : UInt = 20
        var colms: UInt = 11

        if UIDevice.current.orientation != .portrait {
            colms = 20
            rows  = 11
        }
        
        let slicedImages = snapshotAfterSwap.slicesWith(rows: rows, AndColumns: colms, alpha: 0.0)
        view.addSubviews(slicedImages)
        view.isUserInteractionEnabled = false
        
        DispatchQueue.main.async {
            
            let serviceGroup = DispatchGroup()
            let shuffledImages = slicedImages.shuffled()
            var delayForOddImages  = 0.0
            var delayForEvenImages = 0.0
            var delay = 0.0

            for index in 0..<shuffledImages.count {
                
                serviceGroup.enter()
                
                let view = shuffledImages[index]
                view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                delayForOddImages  = (0.5...3.0).random()
                delayForEvenImages = (0.1...1.3).random()

                if index % 2 == 0 {
                    delay = delayForEvenImages
                }
                else {
                    delay = delayForOddImages
                }

                UIView.animate(withDuration: self.configs.centerPanelTransitionDuration, delay: TimeInterval(delay), options: .curveEaseIn, animations: {
                    
                    view.alpha = 1
                    view.transform = CGAffineTransform(scaleX: 1, y: 1)
                    
                }, completion: { (finished) in
                    serviceGroup.leave()
                })
            }
            
            
            
            serviceGroup.notify(queue: DispatchQueue.main) {
                
                imageBeforeSwap.removeFromSuperview()
                UIView.removeAllFromSuperview(slicedImages)
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //  Loading of panels
    
    internal func loadCenterPanel() {
        
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
        
        if isLeftPanelOnFront {
            view.bringSubviewToFront(leftPanelContainer)
        }
        else {
            view.sendSubviewToBack(leftPanelContainer)
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
        
        if isRightPanelOnFront {
            view.bringSubviewToFront(rightPanelContainer)
        }
        else {
            view.sendSubviewToBack(rightPanelContainer)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    //  Showing panels
    
    
    internal func openLeft(animated: Bool, shouldBounce bounce:Bool) {
        
        if leftPanelVC != nil {
            centerPanelVC?.view.endEditing(true)
            
            state = .left
            loadLeftPanel()
            
            if isLeftPanelOnFront {
                slideLeftPanelIn(animated: animated)
            }
            else {
                slideCenterPanel(animated: animated, bounce: bounce)
                handleScrollsToTopForContainers(centerEnabled: false, leftEnabled: true, rightEnabled: false)
            }
        }
    }
    
    
    internal func openRight(animated: Bool, shouldBounce bounce:Bool) {
        
        if rightPanelVC != nil {
            centerPanelVC?.view.endEditing(true)
            state = .right
            loadRightPanel()
            
            if isRightPanelOnFront {
                slideRightPanelIn(animated: animated)
            }
            else {
                slideCenterPanel(animated: animated, bounce: bounce)
                handleScrollsToTopForContainers(centerEnabled: false, leftEnabled: false, rightEnabled: true)
            }
        }
    }
    
    
    internal func openCenter(animated: Bool, shouldBounce bounce: Bool, afterThat completion: (() -> Void)?) {
        
        state = .center
        _ = updateCenterPanelSlidingFrame()
        if animated {
            animateCenterPanel(shouldBounce: bounce, completion: { (finished) in
                self.leftPanelContainer.isHidden = true
                self.rightPanelContainer.isHidden = true
                self.unloadPanels()
                completion?()
            })
        }
        else {
            updateCenterPanelContainer()
            leftPanelContainer.isHidden = true
            rightPanelContainer.isHidden = true
            unloadPanels()
            completion?()
        }
        
//        tapView = nil
        tapView?.alpha = 0.0

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
//        tapView = UIView()
        handleTapViewOpacity()
    }

    
    internal func slideLeftPanelIn(animated: Bool) {

        if animated {

            let duration: TimeInterval = TimeInterval(configs.maxAnimDuration)
            UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
                
                var frame = self.leftPanelContainer.frame
                frame.origin.x = 0.0
                self.leftPanelContainer.frame = frame
                
            }, completion:{ (finished) in
                
            })
        }
        else {
            
            var frame = self.leftPanelContainer.frame
            frame.origin.x = 0.0
            self.leftPanelContainer.frame = frame
        }
        
//        tapView = UIView()
        handleTapViewOpacity()
    }

    
    internal func slideLeftPanelOut(animated: Bool, afterThat completion: (() -> Void)?) {
        
        if animated {
            
            let duration: TimeInterval = TimeInterval(configs.maxAnimDuration)
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
                
                var frame = self.leftPanelContainer.frame
                frame.origin.x = -self.widthForLeftPanelVC
                self.leftPanelContainer.frame = frame
            
            }, completion:{ (finished) in
                self.view.sendSubviewToBack(self.leftPanelContainer)
                self.unloadPanels()
                self.state = .center
                completion?()
            })
        }
        else {
            
            var frame = leftPanelContainer.frame
            frame.origin.x = -widthForLeftPanelVC
            leftPanelContainer.frame = frame
            view.sendSubviewToBack(leftPanelContainer)
            unloadPanels()
            state = .center
            completion?()
        }
        
//        tapView = nil
        tapView?.alpha = 0.0

        handleScrollsToTopForContainers(centerEnabled: true, leftEnabled: false, rightEnabled: false)
    }

    
    internal func slideRightPanelIn(animated: Bool) {
        
        if animated {
            
            let duration: TimeInterval = TimeInterval(configs.maxAnimDuration)
            UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
                
                var frame = self.rightPanelContainer.frame
                frame.origin.x = self.view.frame.size.width - self.widthForRightPanelVC
                self.rightPanelContainer.frame = frame
                
            }, completion:{ (finished) in
                
            })
        }
        else {
            
            var frame = self.rightPanelContainer.frame
            frame.origin.x = self.view.frame.size.width - widthForRightPanelVC
            self.rightPanelContainer.frame = frame
        }
        
//        tapView = UIView()
        handleTapViewOpacity()
    }
    
    
    internal func slideRightPanelOut(animated: Bool, afterThat completion: (() -> Void)?) {
        
        if animated {
            
            let duration: TimeInterval = TimeInterval(configs.maxAnimDuration)
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
                
                var frame = self.rightPanelContainer.frame
                frame.origin.x = self.view.frame.size.width
                self.rightPanelContainer.frame = frame
                
            }, completion:{ (finished) in
                self.view.sendSubviewToBack(self.rightPanelContainer)
                self.unloadPanels()
                self.state = .center
                completion?()
            })
        }
        else {
            
            var frame = rightPanelContainer.frame
            frame.origin.x = self.view.frame.size.width
            rightPanelContainer.frame = frame
            view.sendSubviewToBack(rightPanelContainer)
            unloadPanels()
            state = .center
            completion?()
        }
        
//        tapView = nil
        tapView?.alpha = 0.0

        handleScrollsToTopForContainers(centerEnabled: true, leftEnabled: false, rightEnabled: false)
    }

    
    
    
    
    private func updateCenterPanelContainer() {
        
        centerPanelContainer.frame = centeralPanelSlidingFrame
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

        var rightFrame: CGRect = rightPanelContainer.frame
        var leftFrame: CGRect  = leftPanelContainer.frame

        if !isLeftPanelOnFront { leftFrame = view.bounds }
        if !isRightPanelOnFront { rightFrame = view.bounds }

        
        if (configs.pusheSidePanels && !centerPanelHidden) {
            leftFrame.origin.x = centerPanelContainer.frame.origin.x - widthForLeftPanelVC
            rightFrame.origin.x = centerPanelContainer.frame.origin.x + centerPanelContainer.frame.size.width
        }
        
        leftPanelContainer.frame = leftFrame
        rightPanelContainer.frame = rightFrame
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
            
            if leftPanelPosition == .front {
                frame.origin.x = 0
            }
            else {
                frame.origin.x = widthForLeftPanelVC
            }
            
            break
            
        case .right:
            
            if rightPanelPosition == .front {
                frame.origin.x = 0
            }
            else {
                frame.origin.x = -widthForRightPanelVC
            }
            break
        }
        
        centeralPanelSlidingFrame = frame
        return centeralPanelSlidingFrame
    }
    
    
    
    
    
    
    
    
    
    
    
    //  Handle Scrolling
    
    
    internal func handleScrollsToTopForContainers(centerEnabled: Bool, leftEnabled:Bool, rightEnabled:Bool) {
        
        if UIDevice().userInterfaceIdiom == .phone {
            
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

    
    internal func xPositionForLeftPanel( _ translationInX: CGFloat) -> CGFloat {
        
        if state == .center {

            let newPosition = -widthForLeftPanelVC + translationInX
            if newPosition > 0.0 { return 0.0 }
            else if newPosition < -widthForLeftPanelVC { return -widthForLeftPanelVC }
            else { return newPosition }
        }
        else if state == .left {

            if translationInX > 0.0 { return 0.0 }
            else if translationInX < -widthForLeftPanelVC { return -widthForLeftPanelVC }
            else { return translationInX }
        }
        else { return 0.0 }
    }

    
    internal func xPositionForRightPanel( _ translationInX: CGFloat) -> CGFloat {

        let widthOfView = view.frame.size.width

        if state == .center {

            let newPosition = widthOfView + translationInX
            if newPosition > widthOfView { return widthOfView }
            else if newPosition < (widthOfView - widthForRightPanelVC) { return (widthOfView - widthForRightPanelVC) }
            else { return newPosition }
        }
        else if state == .right {

            let leftBareer = widthOfView - widthForRightPanelVC
            let newPosition = leftBareer + translationInX

            if translationInX < 0.0 { return leftBareer }
            else if translationInX > widthForRightPanelVC { return widthOfView }
            else { return newPosition }
        }
        else { return 0.0 }
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


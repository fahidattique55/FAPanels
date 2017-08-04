//
//  FAPanel.swift
//  FAPanels
//
//  Created by Fahid Attique on 10/06/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit



open class FAPanelController: UIViewController {

    
    
    
    //  MARK:- Open
    
    
    open var configs = FAPanelConfigurations()


    open func center( _ controller: UIViewController) -> FAPanelController {
        
        centerPanelVC = controller
        return self
    }


    open func left( _ controller: UIViewController) -> FAPanelController {
        
        leftPanelVC = controller
        return self
    }

    
    open func right( _ controller: UIViewController) -> FAPanelController {
        
        rightPanelVC = controller
        return self
    }


    open func openLeft(animated:Bool) {

        openLeft(animated: animated, shouldBounce: configs.bounceOnLeftPanelOpen)
    }
    
    
    open func openRight(animated:Bool) {
        
        openRight(animated: animated, shouldBounce: configs.bounceOnRightPanelOpen)
    }
    
    
    open func openCenter(animated:Bool) {     //  Can be used for the same menu option selected
        
        if centerPanelHidden {
            centerPanelHidden = false
            unhideCenterPanel()
        }
        openCenter(animated: animated, shouldBounce: configs.bounceOnCenterPanelOpen)
    }

    
    

    
    
    
    
    
    
    

    // MARK:- Life Cycle
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override open func viewDidLoad() {

        super.viewDidLoad()
        viewConfigurations()
    }

    
    override open func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        layoutSideContainers(withDuration: 0.0, animated: false)
        layoutSidePanelVCs()
        centerPanelContainer.frame = updateCenterPanelSlidingFrame()
        applyStyle(onContainer: centerPanelContainer, withDuration: 0.0, animated: false)
    }

    
    override open func viewDidAppear(_ animated: Bool) {
    
        super.viewDidAppear(animated)
        _ = updateCenterPanelSlidingFrame()
    }

    
    
    deinit {
        if centerPanelVC != nil {
            centerPanelVC!.removeObserver(self, forKeyPath: keyPathOfView)
        }
    }
    
    
    
    private func viewConfigurations() {
        
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        centerPanelContainer = UIView(frame: view.bounds)
        centeralPanelSlidingFrame = self.centerPanelContainer.frame
        centerPanelHidden = false
        leftPanelContainer = UIView(frame: view.bounds)
        leftPanelContainer.isHidden = true
        rightPanelContainer = UIView(frame: view.bounds)
        rightPanelContainer.isHidden = true
        containersConfigurations()
        view.addSubview(centerPanelContainer)
        view.addSubview(leftPanelContainer)
        view.addSubview(rightPanelContainer)
        state = .center
        swapCenter(animated: false, FromVC: nil, ofState: .center, withVC: centerPanelVC)
        view.bringSubview(toFront: centerPanelContainer)
    }
    
    
    private func containersConfigurations() {
        
        leftPanelContainer.autoresizingMask   = [.flexibleHeight, .flexibleRightMargin]
        rightPanelContainer.autoresizingMask  = [.flexibleHeight, .flexibleLeftMargin]
        centerPanelContainer.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        centerPanelContainer.frame =  view.bounds
    }


    
    
    
    
    

    
    
    
    
    
    
    
    //  MARK:- internal Properties

    
    internal var leftPanelContainer  : UIView!
    internal var rightPanelContainer : UIView!
    internal var centerPanelContainer: UIView!

    internal var visiblePanelVC: UIViewController! {
        didSet {
            
            if let bgColor = visiblePanelVC.view?.backgroundColor {
                centerPanelContainer.backgroundColor =  bgColor
            }
        }
    }

    internal var centeralPanelSlidingFrame: CGRect = CGRect.zero
    internal var originBeforePan: CGPoint = CGPoint.zero

    internal let keyPathOfView = "view"
    internal static var kvoContext: Character!
    
    
    internal var _leftPanelVC: UIViewController? = nil
    internal var leftPanelVC : UIViewController? {
        
        get{
            return _leftPanelVC
        }
        set{
            
            if newValue != _leftPanelVC {
                
                _leftPanelVC?.willMove(toParentViewController: nil)
                _leftPanelVC?.view.removeFromSuperview()
                _leftPanelVC?.removeFromParentViewController()
                
                _leftPanelVC = newValue
                if _leftPanelVC != nil {
                    addChildViewController(_leftPanelVC!)
                    _leftPanelVC!.didMove(toParentViewController: self)
                }
                if state == .left {
                    visiblePanelVC = _leftPanelVC
                }
            }
        }
    }
    
    
    internal var _rightPanelVC: UIViewController? = nil
    internal var rightPanelVC : UIViewController? {
        
        get{
            return _rightPanelVC
        }
        set{
            
            if newValue != _rightPanelVC {
                
                _rightPanelVC?.willMove(toParentViewController: nil)
                _rightPanelVC?.view.removeFromSuperview()
                _rightPanelVC?.removeFromParentViewController()
                
                _rightPanelVC = newValue
                if _rightPanelVC != nil {
                    addChildViewController(_rightPanelVC!)
                    _rightPanelVC?.didMove(toParentViewController: self)
                }
                if state == .right {
                    visiblePanelVC = _rightPanelVC
                }
            }
        }
    }
    
    
    internal var _centerPanelVC: UIViewController? = nil
    internal var centerPanelVC : UIViewController? {
        
        get{
            return _centerPanelVC
        }
        set{
            
            let previousVC: UIViewController? = _centerPanelVC
            
            if _centerPanelVC != newValue {
                
                _centerPanelVC?.removeObserver(self, forKeyPath: keyPathOfView)
                _centerPanelVC = newValue
                _centerPanelVC!.addObserver(self, forKeyPath: keyPathOfView, options: NSKeyValueObservingOptions.initial, context: &FAPanelController.kvoContext)
                
                if state == .center {
                    visiblePanelVC = _centerPanelVC
                }
            }
            
            if isViewLoaded && state == .center {
                swapCenter(animated: configs.changeCenterPanelAnimated, FromVC: previousVC, ofState: .center, withVC: _centerPanelVC!)
            }
            else if (self.isViewLoaded) {
                
                let previousState: FAPanelVisibleState = state
                state = .center
                
                UIView.animate(withDuration: 0.2, animations: {
                    
                    if self.configs.bounceOnCenterPanelChange {
                        let x: CGFloat  = (previousState == .left) ? self.view.bounds.size.width : -self.view.bounds.size.width
                        self.centeralPanelSlidingFrame.origin.x = x
                    }
                    self.centerPanelContainer.frame = self.centeralPanelSlidingFrame
                    
                }, completion: { (finised) in
  
                    self.swapCenter(animated: false,FromVC: previousVC, ofState: previousState, withVC: self._centerPanelVC)
                    self.openCenter(animated: true, shouldBounce: false)
                })
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //  tap view on centeral panel, to dismiss side panels if visible
    
    
    internal var _tapView: UIView? = nil
    internal var tapView: UIView? {
        
        get{
            return _tapView
        }
        set{
            if newValue != _tapView {
                _tapView?.removeFromSuperview()
                _tapView = newValue
                if _tapView != nil {
                    
                    _tapView?.frame = centerPanelContainer.bounds
                    _tapView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    addTapGestureToView(view: _tapView!)
                    if configs.canRecognizePanGesture {
                        addPanGesture(toView: _tapView!)
                    }
                    centerPanelContainer.addSubview(_tapView!)
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    //  visible widths for side panels
    
    
    internal var widthForLeftPanelVC: CGFloat  {
        get{
            if centerPanelHidden && configs.resizeLeftPanel {
                return view.bounds.size.width
            }
            else {
                return configs.leftPanelWidth == 0.0 ? CGFloat(floorf(Float(view.bounds.size.width * configs.leftPanelGapPercentage))) : configs.leftPanelWidth
            }
        }
    }
    
    
    internal var widthForRightPanelVC: CGFloat {
        get{
            if centerPanelHidden && configs.resizeRightPanel {
                return view.bounds.size.width
            }
            else {
                return configs.rightPanelWidth == 0 ? CGFloat(floorf(Float(view.bounds.size.width * configs.rightPanelGapPercentage))) : configs.rightPanelWidth
            }
        }
    }
    

    
    
    
    
    
    
    
    
    //  style for panels
    
    internal func applyStyle(onContainer: UIView, withDuration duration: TimeInterval, animated: Bool) {
        
        let shadowPath: UIBezierPath = UIBezierPath(roundedRect: onContainer.bounds, cornerRadius: 0.0)
        
        if animated {
            
            let animation = CABasicAnimation(keyPath: "shadowPath")
            animation.fromValue = onContainer.layer.shadowPath
            animation.toValue = shadowPath.cgPath
            animation.duration = duration
            onContainer.layer.add(animation, forKey: "shadowPath")
        }
        onContainer.layer.shadowPath = shadowPath.cgPath
        onContainer.layer.shadowColor = UIColor.black.cgColor
        onContainer.layer.shadowRadius = 8.0
        onContainer.layer.shadowOpacity = 0.70
        onContainer.clipsToBounds = false
    }
    
    
    internal func applyStyle(onView: UIView) {
        
        onView.layer.cornerRadius = configs.cornerRadius
        onView.clipsToBounds = true
    }
    
    
    

    

    
    
    
    //  Panel States

    internal  var _state: FAPanelVisibleState = .center
    internal  var  state: FAPanelVisibleState {
        get{
            return _state
        }
        set{
            if _state != newValue {
                _state = newValue
                switch _state {
                    
                case .center:
                    visiblePanelVC = centerPanelVC
                    leftPanelContainer.isUserInteractionEnabled  = false
                    rightPanelContainer.isUserInteractionEnabled = false
                    break
                    
                case .left:
                    visiblePanelVC = leftPanelVC
                    leftPanelContainer.isUserInteractionEnabled   = true
                    break
                    
                case .right:
                    visiblePanelVC = rightPanelVC
                    rightPanelContainer.isUserInteractionEnabled  = true
                    break
                }
                
                setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    
    
    
    
    
    
    
    //  Center Panel Hiding Functions

    
    internal var _centerPanelHidden: Bool = false
    internal var centerPanelHidden: Bool {
        get{
            return _centerPanelHidden
        }
        set{
            setCenterPanelHidden(newValue, animated: false, duration: 0.0)
        }
    }
    
    
    internal func setCenterPanelHidden(_ hidden: Bool, animated: Bool, duration: TimeInterval) {
        
        if hidden != _centerPanelHidden && state != .center {
            _centerPanelHidden = hidden
            let animationDuration = animated ? duration : 0.0
            if hidden {
                
                
                UIView.animate(withDuration: animationDuration, animations: {
                    
                    var frame: CGRect = self.centerPanelContainer.frame
                    frame.origin.x = self.state == .left ? self.centerPanelContainer.frame.size.width : -self.centerPanelContainer.frame.size.width
                    self.centerPanelContainer.frame = frame
                    self.layoutSideContainers(withDuration: 0.0, animated: false)
                    
                    if self.configs.resizeLeftPanel || self.configs.resizeRightPanel {
                        self.layoutSidePanelVCs()
                    }
                }, completion: { (finished) in
                    
                    if self._centerPanelHidden {
                        self.hideCenterPanel()
                    }
                })
                
                
            }
            else {
                unhideCenterPanel()
                
                UIView.animate(withDuration: animationDuration, animations: {
                    
                    if self.state == .left {
                        self.openLeft(animated: false)
                    }
                    else {
                        self.openRight(animated: false)
                    }
                    if self.configs.resizeLeftPanel || self.configs.resizeRightPanel {
                        self.layoutSidePanelVCs()
                    }
                })
            }
        }
    }
}






![Alt text](http://i.imgur.com/i0G92dq.png "FAPanel-Image")


<p align="center">
    <a href="http://i.imgur.com/ZN13eaf.gif">
        <img src="http://i.imgur.com/ZN13eaf.gif" height="450">
    </a>
</p>



[![Swift version](https://img.shields.io/badge/swift-3.0-orange.svg?style=flat.svg)](https://img.shields.io/badge/swift-3.0-orange.svg?style=flat.svg)
[![Support Dependecy Manager](https://img.shields.io/badge/support-CocoaPods-red.svg?style=flat.svg)](https://img.shields.io/badge/support-CocoaPods-red.svg?style=flat.svg)
[![Version](https://img.shields.io/cocoapods/v/FAPanels.svg?style=flat)](http://cocoapods.org/pods/FAPanels)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat.svg)](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat.svg)
[![Platform](https://img.shields.io/cocoapods/p/FAPanels.svg?style=flat)](http://cocoapods.org/pods/FAPanels)



## New Features Added ( > 0.2.1 only)
---

- [x] Left panel position (front/back) to center panel
- [x] Shadow on left panel, if left panel position is front 
- [x] FAPanel State Delegate feature


### Left Panel Position

| back | front | 
| --- | --- |
| ![](http://i.imgur.com/f7slmmx.gif) |  ![](http://i.imgur.com/T7AgNl1.gif)


### Usage



```swift

//  Set the Left Panel position

let rootController: FAPanelController = window?.rootViewController as! FAPanelController

rootController.leftPanelPosition = .front
rootController.leftPanelPosition = .back


```


## Features
---

- [x] Implementation with code & storyboard
- [x] Left, right and center panel supported 
- [x] Change left, right or center panel
- [x] Open left, right or center panel
- [x] Supports Animations   
- [x] Multiple Panel configurations
- [x] Supports status bar preffered style for all panels



### Transitions supported
---

- [x] Flip From Left
- [x] Flip From Right
- [x] Flip From Top
- [x] Flip From Bottom
- [x] Curl Up
- [x] Curl Down
- [x] Cross Dissolve
- [x] Move Up 
- [x] Move Down
- [x] Move Left
- [x] Move Right
- [x] Split Horizontally 
- [x] Split Vertically 
- [x] Dump Fall
- [x] Box Fade



### Panel configurations

```swift


// Panels width

var leftPanelWidth : CGFloat = 280  //  It will override the gap percentage value
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


// Shadow configurations

open var shadowColor   : CGColor = UIColor.black.cgColor
open var shadowOffset  : CGSize  = CGSize(width: 10.0, height: 0.0)
open var shadowOppacity: Float = 0.5


// Remove panels from super view when possible

var unloadRightPanel: Bool = false
var unloadLeftPanel : Bool = false


// Max animation duration for animations of side panels

var maxAnimDuration  : CGFloat = 0.20


// percentage of screen's width to the centerPanel.view must move for panGesture to succeed

var minMovePercentage: CGFloat = 0.15


// Only Center Panel Change animation

var changeCenterPanelAnimated : Bool = true
var centerPanelTransitionType : FAPanelTransitionType = .crossDissolve
var centerPanelTransitionDuration: TimeInterval = 0.60

```









## Installation

### Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```


To integrate FAPanel into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
pod 'FAPanels'
end
```

Then, run the following command:

```bash
$ pod install
```


### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate FAPanels into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "fahidattique55/FAPanels" >= 0.2.0
```

Run `carthage update` to build the framework and drag the built `FAPanels.framework` into your Xcode project.






## Usage


### Step 1 

- Set the root window as FAPanel controller as shown in below image,

![Alt text](http://i.imgur.com/OkPdbBi.png "FAPanel-Image-Usage")


### Step 2 

- Add the following code in ``` AppDelegate.swift ``` file,


```swift

//  Load the Controllers 

let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

let leftMenuVC: LeftMenuVC = mainStoryboard.instantiateViewController(withIdentifier: "LeftMenuVC") as! LeftMenuVC

let rightMenuVC: RightMenuVC = mainStoryboard.instantiateViewController(withIdentifier: "RightMenuVC") as! RightMenuVC

let centerVC: CenterVC = mainStoryboard.instantiateViewController(withIdentifier: "CenterVC1") as! CenterVC
let centerNavVC = UINavigationController(rootViewController: centerVC)




//  Set the Panel controllers with just two lines of code

let rootController: FAPanelController = window?.rootViewController as! FAPanelController
rootController.center(centerNavVC).left(leftMenuVC).right(rightMenuVC)

```

- All done! Run the code and see the magic.



### Step 2 (Continue - Panel Controllers) 

- Don't want to set RightMenuVC then just remove the right panel code i.e, 

```swift

//  This is the code to set all panels 

rootController.center(centerNavVC).left(leftMenuVC).right(rightMenuVC)


//  Updated code which have only left and center panels 

rootController.center(centerNavVC).left(leftMenuVC)


//  Similarly, if left panel is not needed the remove the left panel code.

rootController.center(centerNavVC).right(rightMenuVC)


//  In case you only want the center panel, then update code to

rootController.center(centerNavVC)

```


### Step 2 (Continue - Panel Configurations) 

- Configre the Panels before setting the panels

```swift


rootController.configs.rightPanelWidth = 80
rootController.configs.bounceOnRightPanelOpen = false



//  Should Pan from edge? Add these lines of code, 

rootController.configs.panFromEdge = false
rootController.configs.minEdgeForLeftPanel  = 70
rootController.configs.minEdgeForRightPanel = 70


rootController.center(centerNavVC).left(leftMenuVC).right(rightMenuVC)


//  For more configurations and their details, Please have a look into ``` FAPanelConfigurations.swift ``` file 

```




### Access Panel  

- Panel can be accessed from any view controller,

```swift

panel?.configs = FAPanelConfigurations()


```



### Open/Close Panels  

- Open Left or Right panels with/without animations

```swift

panel?.openLeft(animated: true)
panel?.openRight(animated: true)


```

- Open/Close Panels Preview

<p align="center">
    <a href="http://i.imgur.com/1IYEdMn.gif">
        <img src="http://i.imgur.com/1IYEdMn.gif" height="450">
    </a>
</p>





### Change/Remove Panels

- Change Left, Right or Center Panel from any view controller


```swift

//  Change Center panel

let centerVC: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "CenterVC2")
let centerNavVC = UINavigationController(rootViewController: centerVC)

panel!.center(centerNavVC)



//  Change Left panel

let leftVC: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "LeftVC")
panel!.left(leftVC)


//  Remove Left panel

panel!.left(nil)


```

- Preview, when changing center panel from left/right panels

<p align="center">
    <a href="http://i.imgur.com/C7S8Q7h.gif">
        <img src="http://i.imgur.com/C7S8Q7h.gif" height="450">
    </a>
</p>




### Change Center Panel (With custom transitions and durations)

- Change Left, Right or Center Panel from any view controller


```swift

//  Specify the transition type

panel!.configs.centerPanelTransitionType = .transitionOption     // Transitions supported are mentioned in FAPanelTransitionType


//  Specify the transition duration

panel!.configs.centerPanelTransitionDuration = 0.60


//  Update the center panel

panel!.center(centerNavVC)


```


- Transitions Preview

| flipFromLeft | flipFromRight | 
| --- | --- |
| ![](http://i.imgur.com/QNaDoVE.gif) | ![](http://i.imgur.com/QxPeUxF.gif) |



| flipFromTop | flipFromBottom 
| --- | --- |
| ![](http://i.imgur.com/SOoAYHQ.gif) | ![](http://i.imgur.com/dqqFPLE.gif) |



| curlUp | curlDown | 
| --- | --- |
| ![](http://i.imgur.com/9Hjhthp.gif) | ![](http://i.imgur.com/BALhgmX.gif)


| crossDissolve | moveRight | 
| --- | --- |
| ![](http://i.imgur.com/siaRAy3.gif) |  ![](http://i.imgur.com/1o4SILl.gif)


| moveLeft | moveUp | 
| --- | --- |
| ![](http://i.imgur.com/dH3HNyv.gif) |  ![](http://i.imgur.com/iENLd4n.gif)


| moveDown | splitVertically | 
| --- | --- |
| ![](http://i.imgur.com/GrQH53P.gif) |  ![](http://i.imgur.com/a7FbLUX.gif)


| splitHorizontally | dumpFall | 
| --- | --- |
| ![](http://i.imgur.com/gsYw0SX.gif) |  ![](http://i.imgur.com/miVZ2nB.gif)


| boxFade | 
| --- |
| ![](http://i.imgur.com/TjniRC2.gif) |




### Supports interface rotation

<p align="center">
    <a href="http://i.imgur.com/4dpN8d7.gif">
        <img src="http://i.imgur.com/4dpN8d7.gif" height="450">
    </a>
</p>





## License

FAPanels is licensed under the Apache License 2.0.

For more details visit http://www.apache.org/licenses/LICENSE-2.0


## Author

**Fahid Attique** - (https://github.com/fahidattique55)


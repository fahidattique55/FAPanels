//
//  CenterVC.swift
//  FAPanels
//
//  Created by Fahid Attique on 17/06/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit

class CenterVC: UIViewController {

    
    
    //  MARK:- IBOutlets

    
    @IBOutlet var centerPanelOnlyAnimOpts: UITextField!
    @IBOutlet var centerPanelOnlyAnimDuration: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet var leftAllowableEdge: UILabel!
    @IBOutlet var rightAllowableEdge: UILabel!
    
    @IBOutlet var sidePanelsOpenAnimDuration: UILabel!

    @IBOutlet var leftPanelPositionSwitch: UISwitch!
    
    
    
    //  MARK:- Class Properties

    fileprivate let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    var pickerDataSource: [String] = ["flipFromLeft", "flipFromRight", "flipFromTop", "flipFromBottom", "curlUp", "curlDown", "crossDissolve", "moveRight", "moveLeft", "moveUp", "moveDown", "splitHorizotally", "splitVertically", "dumpFall", "boxFade"]

    
    
    
    
    //  MARK:- Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewConfigurations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    
    // MARK: - Functions
    
    func viewConfigurations() {
    
        pickerView.delegate = self
        pickerView.dataSource = self
        centerPanelOnlyAnimOpts.delegate = self
        centerPanelOnlyAnimOpts.inputView = pickerView
        
        leftPanelPositionSwitch.setOn(panel!.isLeftPanelOnFront, animated: false)
        

        //  Resetting the Panel Configs...
        
        panel!.configs = FAPanelConfigurations()
        panel!.configs.rightPanelWidth = 80
        panel!.configs.bounceOnRightPanelOpen = false
    }
    
    
    func setCenterPanelAnimType( _ selectedRow: Int) {
        
        var animOptions: FAPanelTransitionType = .crossDissolve
        
        switch selectedRow {
        
        case 0:
            animOptions = .flipFromLeft
        case 1:
            animOptions = .flipFromRight
        case 2:
            animOptions = .flipFromTop
        case 3:
            animOptions = .flipFromBottom
        case 4:
            animOptions = .curlUp
        case 5:
            animOptions = .curlDown
        case 6:
            animOptions = .crossDissolve

        case 7:
            animOptions = .moveRight
        case 8:
            animOptions = .moveLeft
        case 9:
            animOptions = .moveUp
        case 10:
            animOptions = .moveDown

            
        case 11:
            animOptions = .splitHorizontally
        case 12:
            animOptions = .splitVertically

            
        case 13:
            animOptions = .dumpFall

            
        case 14:
            animOptions = .boxFade


        default:
            animOptions = .crossDissolve
        }
        
        panel!.configs.centerPanelTransitionType = animOptions
    }
    
    

    
    
    
    // MARK: - IBActions

    @IBAction func showRightVC(_ sender: Any) {
        panel?.openRight(animated: true)
    }
    
    @IBAction func showLeftVC(_ sender: Any) {
        panel?.openLeft(animated: true)
    }

    @IBAction func updateLeftPanelPosition(_ sender: UISwitch) {
        
        panel?.leftPanelPosition = sender.isOn ? .front : .back
    }
    
    @IBAction func changeCenterVC(_ sender: UIButton) {

        var identifier = ""

        if sender.isSelected {
            identifier = "CenterVC1"
        }
        else{
            identifier = "CenterVC2"
        }

        let centerVC: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: identifier)
        let centerNavVC = UINavigationController(rootViewController: centerVC)
        
        _ = panel!.center(centerNavVC)

        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func updateAnimDuration(_ sender: UIStepper) {
        
        let valueAsText = String(format: "%.2f", sender.value/100)
        centerPanelOnlyAnimDuration.text = valueAsText
        panel!.configs.centerPanelTransitionDuration = TimeInterval(Double(valueAsText)!)
    }
    
    @IBAction func updatePanFromEdge(_ sender: UISwitch) {
        panel!.configs.panFromEdge = sender.isOn
    }
    
    
    @IBAction func updateLeftEdgeValue(_ sender: UIStepper) {
        
        let sliderValueAsText = String(format: "%.0f", sender.value)
        leftAllowableEdge.text = sliderValueAsText
        panel!.configs.minEdgeForLeftPanel = CGFloat(Double(sliderValueAsText)!)
    }

    @IBAction func updateRightEdgeValue(_ sender: UIStepper) {
        
        let sliderValueAsText = String(format: "%.0f", sender.value)
        rightAllowableEdge.text = sliderValueAsText
        panel!.configs.minEdgeForRightPanel = CGFloat(Double(sliderValueAsText)!)
    }

    @IBAction func updateSidePanelsOpenAnimDuration(_ sender: UIStepper) {
        
        let sliderValueAsText = String(format: "%.2f", sender.value/100)
        sidePanelsOpenAnimDuration.text = sliderValueAsText
        panel!.configs.maxAnimDuration = CGFloat(Double(sliderValueAsText)!)
    }

    
}








extension CenterVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField === centerPanelOnlyAnimOpts {
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        if textField === centerPanelOnlyAnimOpts {
            
            let selectedRow = pickerView.selectedRow(inComponent: 0)
            textField.text = pickerDataSource[selectedRow]
            setCenterPanelAnimType(selectedRow)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}








extension CenterVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
}

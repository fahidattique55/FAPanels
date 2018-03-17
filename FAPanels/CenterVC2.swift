//
//  CenterVC2.swift
//  FAPanels
//
//  Created by Fahid Attique on 10/07/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit

class CenterVC2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func showRightVC(_ sender: Any) {
        panel?.openRight(animated: true)
    }
    
    @IBAction func showLeftVC(_ sender: Any) {
        panel?.openLeft(animated: true)
    }

}

//
//  RightMenuVC.swift
//  FAPanels
//
//  Created by Fahid Attique on 17/06/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit

class RightMenuVC: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewConfigurations()
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
    
    private func viewConfigurations() {
        
        tableView.register(UINib.init(nibName: "RightMenuCell", bundle: nil), forCellReuseIdentifier: "RightMenuCell")
    }

}

extension RightMenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RightMenuCell") as! RightMenuCell
        cell.menuOption.image = UIImage(named: "right_menu_" + String(indexPath.row + 1))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)

        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var identifier = ""
        
        if indexPath.row % 2 == 0 {
            identifier = "CenterVC1"
        }
        else{
            identifier = "CenterVC2"
        }
        
        let centerVC: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: identifier)
        let centerNavVC = UINavigationController(rootViewController: centerVC)
        
        panel!.configs.bounceOnCenterPanelChange = false
        _ = panel!.center(centerNavVC)
    }
}

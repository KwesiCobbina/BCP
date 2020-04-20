//
//  RegulationnDetailViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 03/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import PageMenu

class RegulationDetailViewController: UIViewController {

    @IBOutlet weak var tncSegment: UISegmentedControl!
    @IBOutlet weak var container1: UIView!
    @IBOutlet weak var container2: UIView!
    
    var class_id: String?
    var selectedRegulation: Regulation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedRegulation = AppConstants.sharedInstance.regulate
        class_id = AppConstants.sharedInstance.policy_id
        print(selectedRegulation)
        if tncSegment.selectedSegmentIndex == 0 {
            
            container2.isHidden = false
            container1.isHidden = true
        }
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch tncSegment.selectedSegmentIndex {
        case 0:
            container2.isHidden = false
            container1.isHidden = true
        case 1:
            container2.isHidden = true
            container1.isHidden = false
        default:
            break
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

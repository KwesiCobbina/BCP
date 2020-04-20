//
//  TermsAndConditionsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 09/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class TermsAndConditionsViewController: UIViewController {

    @IBOutlet weak var tncLabel: UITextView!
    @IBOutlet weak var tncSegment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        if tncSegment.selectedSegmentIndex == 0 {
            tncLabel.attributedText = AppConstants.sharedInstance.governmentAgencyRegistration.htmlToAttributedString
        }

    }
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch tncSegment.selectedSegmentIndex {
        case 0:
            tncLabel.attributedText = AppConstants.sharedInstance.governmentAgencyRegistration.htmlToAttributedString
        case 1:
            tncLabel.attributedText = AppConstants.sharedInstance.businessIndividualsRegistration.htmlToAttributedString
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

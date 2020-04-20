//
//  AboutSectionViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 09/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class AboutSectionViewController: UIViewController {

    @IBOutlet weak var aboutLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        aboutLabel.attributedText = AppConstants.sharedInstance.about_bcp.htmlToAttributedString
//        aboutLabel.attributedText.
//        aboutLabel.font.withSize(15)
        // Do any additional setup after loading the view.
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

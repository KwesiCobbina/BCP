//
//  OverviewViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 24/04/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
class PrivacyStatementViewController: UIViewController {

	@IBOutlet weak var ps: UITextView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        ps.attributedText = AppConstants.sharedInstance.privacy.htmlToAttributedString
        
    }

	
}

//
//  AccountEditViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 24/04/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class TermsofUseViewController: UIViewController {

	@IBOutlet weak var tou: UITextView!
	override func viewDidLoad() {
        super.viewDidLoad()

        tou.attributedText = AppConstants.sharedInstance.terms_of_use.htmlToAttributedString
		
    }
}

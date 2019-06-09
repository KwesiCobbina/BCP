//
//  AccountEditViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 24/04/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class AccountEditViewController: UIViewController {

	@IBOutlet weak var fullNameTextField: DesignableUITextField!
	@IBOutlet weak var phoneNumberTextField: DesignableUITextField!
	@IBOutlet weak var occupationTextField: DesignableUITextField!
	@IBOutlet weak var aboutTextField: DesignableUITextField!
	@IBOutlet weak var saveChangesButton: UIButton!
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		let useDefaults = UserDefaults.standard
		let userName = useDefaults.string(forKey: "fullName")
		let email = useDefaults.string(forKey: "email")
		
		fullNameTextField.text = userName
		phoneNumberTextField.text = "+233 54 0777 59"
		occupationTextField.text = "Teaching"
		aboutTextField.text = "fw favw  vzerb bd bh b bd rhg rgd bnn df gart b dzbn b sfsd bxnfn gn dvds vnfg fb  nhfnd bfn gb dfbdf ds hnfbn dG Nfgb dfb fgn fgb xfg nd fssf."
		
    }
    


	@IBAction func saveChangesClicked(_ sender: UIButton) {
	}
}

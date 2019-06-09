//
//  OverviewViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 24/04/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {

	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var aboutLabel: UILabel!
	@IBOutlet weak var emailLabel: UILabel!
	@IBOutlet weak var mobileNumberLabel: UILabel!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		let useDefaults = UserDefaults.standard
		let userName = useDefaults.string(forKey: "fullName")
		let email = useDefaults.string(forKey: "email")
		
		self.emailLabel.text = email
		self.nameLabel.text = userName
		
    }
	
}

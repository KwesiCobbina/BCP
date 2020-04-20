//
//  InterestsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 01/03/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class LoginInterestsViewController: UIViewController {
	
	var interestModel = ViewInterests()
	
	@IBOutlet weak var finalizeButton: UIButton!
	@IBOutlet weak var interestsTable: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		interestsTable.delegate = self
//		interestsTable.dataSource = interestModel
		interestsTable?.allowsMultipleSelection = true
        // Do any additional setup after loading the view.
    }
	@IBAction func finalizeClicked(_ sender: UIButton) {
	}
	
}



extension LoginInterestsViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interestModel.items[indexPath.row].isSelected = true
	}
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		interestModel.items[indexPath.row].isSelected = false
	}
	
	
}

//
//  InterestsEditViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 24/04/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class InterestsEditViewController: UIViewController {

	var datas: [AllInterest] = []
	@IBOutlet weak var interestEditTableView: UITableView!
	@IBOutlet weak var saveBtn: UIButton!
	var stateArray = [customSwitchState]()
	var longerString = ""
	fileprivate var _selectedIndexPath: IndexPath?
	

	
	override func viewDidLoad() {
        super.viewDidLoad()

		interestEditTableView.delegate = self
		interestEditTableView.dataSource = self
        // Do any additional setup after loading the view.
		fetchAllInterests()
		saveBtn.isHidden = true
    }
	

	func fetchAllInterests() {
		var tempInterests: [AllInterest] = []
		//		production
		let defaultValues = UserDefaults.standard
		let private_individual = defaultValues.string(forKey: "userType")
		let BCP_userID = defaultValues.string(forKey: "userID")
		
		//		testing
//		let private_individual = "private_individual"
//		let BCP_userID = "6"
		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_get_interest.php")
		var request = URLRequest(url: url!)
		request.httpMethod = "POST"
		
		
		let params = "BCP_userID=\(BCP_userID)&BCP_userType=\(private_individual)"
		request.httpBody = params.data(using: String.Encoding.utf8)
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard let dataResponse = data,
				error == nil else {
					print(error?.localizedDescription ?? "Response Error")
					return }
			do{
				
				let interests = try JSONDecoder().decode([AllInterest].self, from: dataResponse)
				
				for data in interests {
					tempInterests.append(data)
//					print(data)
				}
				self.datas = []
				self.datas = tempInterests
				
				
				
			} catch let parsingError {
				print("Error", parsingError)
			}
			DispatchQueue.main.async {
				self.interestEditTableView.reloadData()
				self.saveBtn.isHidden = false
			}
		}
		task.resume()
	}
	
	
	@IBAction func saveInterestsClicked(_ sender: UIButton) {
		
//		bcp_update_interest.php
//		let indexPath = IndexPath(row: 0, section: 0)
//		let cell = interestEditTableView.cellForRow(at: indexPath) as! InterestEditTableViewCell
//		if cell.interestSwitch.isOn == true {
//			print(cell.interestNameLabel.text)
//		}
		longerString.insert(separator: "~", every: 1)
		print(longerString)
		DispatchQueue.main.async {
			self.longerString = ""
		}
		let cells = self.interestEditTableView.visibleCells as! Array<InterestEditTableViewCell>
		
		for cell in cells {
			// look at data
			if cell.interestSwitch.isOn == true {
				print(cell.interestNameLabel.text)
			}
		}
	}
}


extension InterestsEditViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return datas.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let data = datas[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "interestEditCell") as! InterestEditTableViewCell
		cell.interests = data
		cell.cellDelegate = self
		cell.interestSwitch.tag = indexPath.row
		return cell
	}
}


extension InterestsEditViewController: SettingCellDelegate {
	
	func didChangeSwitchState(sender: InterestEditTableViewCell, isOn: Bool) {
		let index = self.interestEditTableView.indexPath(for: sender)
		let data = datas[(index?.row)!]
	if self.longerString.contains(data.interest_id!) {
			print("BASAAA")
		} else {
			self.longerString.append(contentsOf: data.interest_id!)
//			print(data)
		}
	}
}


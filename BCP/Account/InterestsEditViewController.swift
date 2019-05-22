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
	var updatas: [AllInterestUpdate] = []
	@IBOutlet weak var interestEditTableView: UITableView!
	@IBOutlet weak var saveBtn: UIButton!
	var stateArray = [customSwitchState]()
	var sand = Bool()
	var longerString = ""
	fileprivate var _selectedIndexPath: IndexPath?
	

	
	override func viewDidLoad() {
        super.viewDidLoad()

		interestEditTableView.delegate = self
		interestEditTableView.dataSource = self
        // Do any additional setup after loading the view.
		fetchAllInterests()
		saveBtn.isHidden = true
		self.interestEditTableView.allowsMultipleSelection = true
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
		
//		for cell in cells {
			// look at data
//			var index = cell.interestSwitch.tag
//			if datas[index].isOn == true {
//				print(index)
//			}
//			if cell.interestSwitch.isOn == true {
//				print(cell.interestNameLabel.text)
//			}
//		}
	}
}


extension InterestsEditViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return datas.count
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "interestEditCell") as! InterestEditTableViewCell
//		if sand == true {
//			var data = AllInterestUpdate()
//			data = updatas[indexPath.row]
////			cell.interests = data
//			cell.cellDelegate = self
//			cell.interestNameLabel.text = data.interest_name
//			cell.backgroundColor = .red
//			print("true")
//		} else if sand == false {
			var data = AllInterest()
			print("false")
			data = datas[indexPath.row]
			cell.interests = data
			cell.cellDelegate = self
//		if data.person_interest != nil {
//			self.longerString = data.person_interest!
			self.longerString = "2~3~4"
			if let myId = data.interest_id {
				if self.longerString.contains(myId) {
					cell.setSelected(true, animated: false)
//					cell.accessoryType = UITableViewCell.AccessoryType.checkmark
				} else {
					cell.setSelected(false, animated: false)
//					cell.accessoryType = UITableViewCell.AccessoryType.checkmark
				}
			}
		
		if cell.isSelected {
			cell.accessoryType = .checkmark
		}
		else {
			cell.accessoryType = .none
		}
			
//		}
//		}
//		let data = datas[indexPath.row]
		
		
//		let sw = UISwitch(frame: CGRect())
//		sw.transform = CGAffineTransform(scaleX: 0.9, y: 0.9);
//		sw.tag = indexPath.row
//		sw.addTarget(self, action: #selector(InterestsEditViewController.switchTapped(_:)), for: UIControl.Event.valueChanged)
//		cell.accessoryView = sw
		cell.selectionStyle = .none
		
		return cell
	}
	
//	@IBAction func switchTapped(_ sender: UISwitch) {
//		let index = sender.tag
//		print(index)
//		self.sand = true
//		guard let id = datas[index].interest_id else {return}
//		guard let p = datas[index].person_interest?.contains(id) else {return}
//		if p == false {
//			print("switch on")
//		}
//
//	}
//	@objc func switchTapped(_ sender: UISwitch) {
//		let index = sender.tag
//		print(index)
//		self.sand = true
//		guard let id = datas[index].interest_id else {return}
//		guard let p = datas[index].person_interest?.contains(id) else {return}
//		if p == false {
//			print("switch on")
//		}
//
//	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.dequeueReusableCell(withIdentifier: "interestEditCell") as! InterestEditTableViewCell
		let data = self.datas[indexPath.row]
		if cell.accessoryType == UITableViewCell.AccessoryType.none {
			let idx = data.interest_id
			self.longerString.append(contentsOf: "~\(idx!)")
			print(self.longerString)
		} else {
//			let idx = data.interest_id
//			if let i = longerString.firstIndex(of: idx!) {
//				longerString.remove(at: i)
//			}
			
		}
	}
	
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		let cell = tableView.dequeueReusableCell(withIdentifier: "interestEditCell") as! InterestEditTableViewCell
		let data = self.datas[indexPath.row]
//		print(cell.accessoryType)
//		if cell.accessoryType == UITableViewCell.AccessoryType.checkmark {
			let idx = data.interest_id
			self.longerString = self.longerString.replacingOccurrences(of: "~\(idx!)", with: "")
			print(longerString)
//		}
		
	}
}


extension InterestsEditViewController: SettingCellDelegate {
	
	func didChangeSwitchState(sender: InterestEditTableViewCell, isOn: Bool) {
		self.sand = true
		let index = self.interestEditTableView.indexPath(for: sender)
		let data = datas[(index?.row)!]
//	if self.longerString.contains(data.interest_id!) {
//			print("BASAAA")
//		} else {
//			self.longerString.append(contentsOf: data.interest_id!)
////			print(data)
//		}
	}
}


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
	var selectedItems : [String] = []

	let child = SpinnerViewController()
	var idxx: [String] = []
	
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
		guard let private_individual = defaultValues.string(forKey: "userType") else {return}
		guard let BCP_userID = defaultValues.string(forKey: "userID") else {return}
		
		
		//		testing
		//		let private_individual = "private_individual"
		//		let BCP_userID = "6"
		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_get_interest.php")
		var request = URLRequest(url: url!)
		request.httpMethod = "POST"
//		guard let userId =
		
		
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
					self.idxx.append(data.interest_id!)
					
				}
				self.datas = []
				self.datas = tempInterests
//				if idxx.contains(tempInterests[0].)
				self.longerString = tempInterests[0].person_interest ?? ""
				self.selectedItems = self.longerString.components(separatedBy: "~")
				print(self.selectedItems)
				
				
				
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
	
//	func createSpinnerView() {
//		addChild(child)
//		child.view.frame = view.frame
//		view.addSubview(child.view)
//		child.didMove(toParent: self)
//	}
//
//	func removeSpinner(){
//		child.willMove(toParent: nil)
//		child.view.removeFromSuperview()
//		child.removeFromParent()
//	}
	
	@IBAction func saveInterestsClicked(_ sender: UIButton) {
//		print(selectedItems)
//		self.createSpinnerView()
		showSpinner(child: child)
		let sendArrayString = selectedItems.joined(separator: "~")
		print(sendArrayString)
		
		let defaultValues = UserDefaults.standard
		let private_individual = defaultValues.string(forKey: "userType")
		let BCP_userID = defaultValues.string(forKey: "userID")
		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_update_interest.php")
		var request = URLRequest(url: url!)
		request.httpMethod = "POST"
		let params = "BCP_userID=\(BCP_userID!)&BCP_userType=\(private_individual!)&interest=\(sendArrayString)"
		request.httpBody = params.data(using: String.Encoding.utf8)
		
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard let dataResponse = data,
				error == nil else {
					print(error?.localizedDescription ?? "Response Error")
					return }
			do{
				let decoder = JSONDecoder()
				let result = try decoder.decode(ErrorData.self, from: data!)
				if result.message! == "Interest Updated Successfully" {
//					DispatchQueue.main.async {
						DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) { // Change `2.0` to the desired number of seconds.
							self.showToast(message: "Interest Updated Successfully")
//							self.removeSpinner()
							self.hideSpinner(child: self.child)
						}
						
//					}
				}
				
			} catch let parsingError {
				print("Error", parsingError)
//				self.removeSpinner()
				self.hideSpinner(child: self.child)
			}
			DispatchQueue.main.async {
				self.interestEditTableView.reloadData()
			}
		}
		task.resume()
	}
}

//func fetchInterests() {
//	var tempInterests: [Interest] = []
//	//		production
//	let defaultValues = UserDefaults.standard
//	let private_individual = defaultValues.string(forKey: "userType")
//	let BCP_userID = defaultValues.string(forKey: "userID")
//	print(defaultValues.string(forKey: "userType")!)
//
//	//		testing
//	//		let private_individual = "private_individual"
//	//		let BCP_userID = "6"
//
//	let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_consultation_interest.php")
//	var request = URLRequest(url: url!)
//	request.httpMethod = "POST"
//
//
//	let params = "BCP_userID=\(BCP_userID!)&BCP_userType=\(private_individual!)"
//	request.httpBody = params.data(using: String.Encoding.utf8)
//	let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//		guard let dataResponse = data,
//			error == nil else {
//				print(error?.localizedDescription ?? "Response Error")
//				return }
//		do{
//
//			let countries = try JSONDecoder().decode([Interest].self, from: dataResponse)
//
//			for data in countries {
//				tempInterests.append(data)
//				print(data)
//			}
//			self.datas = []
//			self.datas = tempInterests
//
//
//
//		} catch let parsingError {
//			print("Error", parsingError)
//		}
//		DispatchQueue.main.async {
//			self.interestsTableView.reloadData()
//		}
//	}
//	task.resume()
//}


extension InterestsEditViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return datas.count
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "interestEditCell") as! InterestEditTableViewCell
		let data = datas[indexPath.row]
		cell.interests = data
		cell.cellDelegate = self
		if selectedItems.contains(data.interest_id!) {
			cell.accessoryType = .checkmark
		}
		else {
			cell.accessoryType = .none
		}
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let data = self.datas[indexPath.row]
		if selectedItems.contains(data.interest_id!) {
			print("its here")
		} else {
			self.selectedItems.append(data.interest_id!)
			interestEditTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
		}
		print(selectedItems)
	}
	
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		let data = self.datas[indexPath.row]
		let selectedCellValue = data.interest_id!
		interestEditTableView.cellForRow(at: indexPath)?.accessoryType = .none
		for a in selectedItems {
			if a == selectedCellValue {
				selectedItems.remove(at: selectedItems.index(of: a)!)
			}
		}
		print(selectedItems)

	}
}


extension InterestsEditViewController: SettingCellDelegate {
	
	func didChangeSwitchState(sender: InterestEditTableViewCell, isOn: Bool) {
		self.sand = true
		let index = self.interestEditTableView.indexPath(for: sender)
		let data = datas[(index?.row)!]

	}
}


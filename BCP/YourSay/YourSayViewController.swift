////
////  YourSayViewController.swift
////  BCP
////
////  Created by Kwesi Adu Cobbina on 17/04/2019.
////  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
////
//
//import UIKit
//
//class YourSayViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
//
//	func numberOfComponents(in pickerView: UIPickerView) -> Int {
//		return 1
//	}
//
//	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//		return categories.count
//	}
//
//	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//		self.categoryTextField.text = categories[row].policy_type
//		self.fetchTopics(policy_type_id: categories[row].policy_type_id!)
//
//	}
//
//	func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//			return categories[row].policy_type
//		}
//
//	@IBOutlet weak var categoryTextField: UITextField!
//	@IBOutlet weak var yourSayTable: UITableView!
//	@IBOutlet weak var yourSayLabel: UILabel!
////	var delegate: SayDelegate?
//
////	let cell = sender as! UITableViewCell
////	let indexPath = tableView.indexPath(for: cell)
////	TSController.indexCell = indexPath.row
//
//	var categories:[Category] = []
//	var topics:[Topics] = []
//	var policy_id: String = "1000"
//	let categoryPicker = UIPickerView()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//		categoryPicker.delegate = self
//		categoryTextField.delegate = self
//		categoryTextField.inputView = categoryPicker
//		setupToolbar()
//		fetchCategories()
//		yourSayTable.delegate = self
//		yourSayTable.dataSource = self
//    }
//
//	func checkDatas() {
//		if topics.isEmpty {
//			yourSayTable.isHidden = true
//			yourSayLabel.isHidden = false
//
//		}
//		else {
//			yourSayTable.isHidden = false
//			DispatchQueue.main.async {
//				self.yourSayTable.reloadData()
//			}
//			yourSayLabel.isHidden = true
//		}
//	}
//
//
//	func fetchCategories(){
//		var tempcountry: [Category] = []
//
////		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_discussion_category.php")
//		let url = URL(string: "\(AppConstants.sharedInstance.devURL)bcp_discussion_category.php")
//		let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
//			guard let dataResponse = data,
//				error == nil else {
//					print(error?.localizedDescription ?? "Response Error")
//					return }
//			do{
//
//				let countries = try JSONDecoder().decode([Category].self, from: dataResponse)
//
//				for data in countries {
//					tempcountry.append(data)
//				}
//				self.categories = []
//				self.categories = tempcountry
//
//
//
//			} catch let parsingError {
//				print("Error", parsingError)
//			}
//			DispatchQueue.main.async {
//				self.categoryPicker.reloadAllComponents()
//			}
//		}
//		task.resume()
//	}
//
//	func fetchTopics(policy_type_id: String) {
//		var tempTopics: [Topics] = []
//
////		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_discussion_topics.php")
//		let url = URL(string: "\(AppConstants.sharedInstance.devURL)bcp_discussion_topics.php")
//		var request = URLRequest(url: url!)
//		request.httpMethod = "POST"
//
//
//		let params = "policy_type_id=\(policy_type_id)"
//		request.httpBody = params.data(using: String.Encoding.utf8)
//		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//			guard let dataResponse = data,
//				error == nil else {
//					print(error?.localizedDescription ?? "Response Error")
//					return }
//			do{
//
//				let countries = try JSONDecoder().decode([Topics].self, from: dataResponse)
//
//				for data in countries {
//					tempTopics.append(data)
//				}
//				self.topics = []
//				self.topics = tempTopics
//
//
//
//			} catch let parsingError {
//				print("Error", parsingError)
//			}
//			DispatchQueue.main.async {
//				self.yourSayTable.reloadData()
//			}
//		}
//		task.resume()
//	}
//
//
//	func setupToolbar(){
//		let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
//
//		toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
//
//		toolBar.barStyle = UIBarStyle.blackTranslucent
//
//		toolBar.tintColor = UIColor.white
//
//		toolBar.backgroundColor = UIColor.lightGray
//		let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.donePressed))
//		toolBar.setItems([okBarBtn], animated: true)
//		toolBar.isUserInteractionEnabled = true
//		categoryTextField.inputAccessoryView = toolBar
//
//	}
//
//	@objc func donePressed(_sender: UIBarButtonItem){
//		categoryTextField.resignFirstResponder()
//	}
//
//}
//
//
//
//extension YourSayViewController: UITableViewDelegate, UITableViewDataSource {
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		self.checkDatas()
//		return topics.count
//	}
//
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		let data = topics[indexPath.row]
//		let cell = tableView.dequeueReusableCell(withIdentifier: "sayCell") as! SayTableViewCell
//		cell.interestLabel.text = data.interest
//		cell.topicLabel.text = data.topic
//		return cell
//	}
//
//	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//		return 50
//	}
//
//
//	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		if segue.identifier == "toFullBio" {
//			let useDefaults = UserDefaults.standard
//			let cell = sender as! UITableViewCell
//			let indexPath = yourSayTable.indexPath(for: cell)
//			let indexCell = topics[indexPath!.row]
//			useDefaults.set(indexCell.forum_id, forKey: "forum_id")
//			useDefaults.synchronize()
//		}
//	}
//}



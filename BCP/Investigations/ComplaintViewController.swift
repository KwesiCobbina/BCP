//
//  ComplaintViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 15/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class ComplaintViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
	
	

	@IBOutlet weak var complaintitle: UITextField!
	@IBOutlet weak var companyName: UITextField!
	@IBOutlet weak var sector: UITextField!
	@IBOutlet weak var complainDescription: UITextField!
	@IBOutlet weak var country: UITextField!
	@IBOutlet weak var first_Name: UITextField!
	@IBOutlet weak var last_Name: UITextField!
	@IBOutlet weak var email: UITextField!
	@IBOutlet weak var phoneNumber: UITextField!
	@IBOutlet weak var complaint_Type: UITextField!
	
//	let surname = "Main"
//	let firstName = "Kwaku"
//	let number = "0234156789"
//	let emailt = "fisikadre@gmail.com"
//	let countryt = "Ghana"
//	let complaintType = "IDK"
	
	var countriesData: [Country] = []
	var sectorsData: [Country] = []
	var complaintTypeData: [Country] = []
	let countryPicker = UIPickerView()
	let sectorPicker = UIPickerView()
	let complaintTypePicker = UIPickerView()
	
	let defaultValues = UserDefaults.standard
	
	override func viewDidLoad() {
        super.viewDidLoad()

		setdelegates()
		fetchCountries()
		fetchSectors()
		fetchComplaintTypes()
		
//		set tags
		countryPicker.tag = 0
		sectorPicker.tag = 1
		complaintTypePicker.tag = 2
//		set delegates
		countryPicker.delegate = self
		sectorPicker.delegate = self
		complaintTypePicker.delegate = self
//		set input views
		country.inputView = countryPicker
		sector.inputView = sectorPicker
		complaint_Type.inputView = complaintTypePicker
		setupToolbar()
		

    }
	
	
	
	func setdelegates() {
		self.complaintitle.delegate = self
		self.companyName.delegate = self
		self.sector.delegate = self
		self.complainDescription.delegate = self
		self.country.delegate = self
		self.first_Name.delegate = self
		self.last_Name.delegate = self
		self.email.delegate = self
		self.phoneNumber.delegate = self
		self.complaint_Type.delegate = self
	}
	
	func clearTexts() {
		self.complaintitle.text?.removeAll()
		self.companyName.text?.removeAll()
		self.sector.text?.removeAll()
		self.complainDescription.text?.removeAll()
		self.country.text?.removeAll()
		self.first_Name.text?.removeAll()
		self.last_Name.text?.removeAll()
		self.email.text?.removeAll()
		self.phoneNumber.text?.removeAll()
		self.complaint_Type.text?.removeAll()
	}
	
	let child = SpinnerViewController()
	func createSpinnerView() {
		
		// add the spinner view controller
		addChild(child)
		child.view.frame = view.frame
		view.addSubview(child.view)
		child.didMove(toParent: self)
	}
	
	func removeSpinner(){
		child.willMove(toParent: nil)
//		DispatchQueue.main.async {
			self.child.view.removeFromSuperview()
			self.child.removeFromParent()
//		}
		
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	@IBAction func submitComplain(_ sender: UIButton) {
		
		createSpinnerView()
		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_sumit_complaint.php")
		var request = URLRequest(url: url!)
		request.httpMethod = "POST"
		
		
		let params = "surname=\(last_Name.text!)&fname=\(first_Name.text!)&tel=\(phoneNumber.text!)&email=\(email.text!)&companyname=\(companyName.text!)&country=\(country.text!)&sector=\(sector.text!)&complainttype=\(complaint_Type.text!)&complaintsubject=\(complaintitle.text!)&description=\(complainDescription.text!)"
		request.httpBody = params.data(using: String.Encoding.utf8)
		
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			if error != nil {
				self.removeSpinner()
				print(error?.localizedDescription as Any)
				return
			}
			do
			{
				let decoder = JSONDecoder()
				do {
					let result = try decoder.decode(ErrorData.self, from: data!)
					print(result.message)
					DispatchQueue.main.async {
						self.removeSpinner()
						self.showToast(message: result.message!)
						if result.message! == "Complaint sent successfully" {
							self.clearTexts()
						}
					}
					
					
				}
				catch DecodingError.typeMismatch {
					let result = try decoder.decode(ErrorData.self, from: data!)
					if result.message! == "Error sending complaint. Please try again later" {
						DispatchQueue.main.async {
							self.showToast(message: "Error sending complaint. Please try again later")
							self.removeSpinner()
						}
					}
					else if result.message! == "Account does not exist" {
						DispatchQueue.main.async {
							//						self.removeSpinner()
							self.showToast(message: "Account does not exist")
							self.removeSpinner()
						}
					}
				}
				
			} catch let parsingError {
				self.removeSpinner()
				print("Error", parsingError)
			}
			
		}
		task.resume()
		
	}
	

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if pickerView.tag == 0 {
			return countriesData.count
		}
		if pickerView.tag == 1 {
			return sectorsData.count
		}
		if pickerView.tag == 2 {
			return complaintTypeData.count
		}
		return 1
	}
	func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		if pickerView.tag == 0 {
			return countriesData[row].name
		}
		if pickerView.tag == 1 {
			return sectorsData[row].name
		}
		if pickerView.tag == 2 {
			return complaintTypeData[row].name
		}
//		return countriesData[row].name
		return nil
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if pickerView.tag == 0 {
			self.country.text = countriesData[row].name
		}
		if pickerView.tag == 1 {
			self.sector.text = sectorsData[row].name
		}
		if pickerView.tag == 2 {
			self.complaint_Type.text = complaintTypeData[row].name
		}
		
	}
	
	
	func fetchCountries(){
		var tempcountry: [Country] = []
		
		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_get_country.php")
		let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
			guard let dataResponse = data,
				error == nil else {
					print(error?.localizedDescription ?? "Response Error")
					return }
			do{
				
				let countries = try JSONDecoder().decode([Country].self, from: dataResponse)
				
				for data in countries {
					tempcountry.append(data)
				}
				self.countriesData = []
				self.countriesData = tempcountry
				
				
				
			} catch let parsingError {
				print("Error", parsingError)
			}
			DispatchQueue.main.async {
				self.countryPicker.reloadAllComponents()
			}
		}
		task.resume()
	}
	
	func fetchSectors(){
		var tempsectors: [Country] = []
		
		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_get_sector.php")
		let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
			guard let dataResponse = data,
				error == nil else {
					print(error?.localizedDescription ?? "Response Error")
					return }
			do{
				
				let countries = try JSONDecoder().decode([Country].self, from: dataResponse)
				
				for data in countries {
					tempsectors.append(data)
				}
				self.sectorsData = []
				self.sectorsData = tempsectors
				
				
				
			} catch let parsingError {
				print("Error", parsingError)
			}
			DispatchQueue.main.async {
				self.sectorPicker.reloadAllComponents()
			}
		}
		task.resume()
	}
	
	func fetchComplaintTypes(){
		var tempcomplaint: [Country] = []
		
		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_get_complaint_type.php")
		let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
			guard let dataResponse = data,
				error == nil else {
					print(error?.localizedDescription ?? "Response Error")
					return }
			do{
				
				let countries = try JSONDecoder().decode([Country].self, from: dataResponse)
				
				for data in countries {
					tempcomplaint.append(data)
				}
				self.complaintTypeData = []
				self.complaintTypeData = tempcomplaint
				
				
				
			} catch let parsingError {
				print("Error", parsingError)
			}
			DispatchQueue.main.async {
				self.complaintTypePicker.reloadAllComponents()
			}
		}
		task.resume()
	}
	
	
	func setupToolbar(){
		let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))

		toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)

		toolBar.barStyle = UIBarStyle.blackTranslucent

		toolBar.tintColor = UIColor.white

		toolBar.backgroundColor = UIColor.lightGray
//		let toolBar = UIToolbar()
//		toolBar.barStyle = UIBarStyle.default
//		toolBar.isTranslucent = false
//		toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
//		toolBar.sizeToFit()
		
//		let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.donePressed))
		let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.donePressed))
		
		toolBar.setItems([okBarBtn], animated: true)
		toolBar.isUserInteractionEnabled = true
		
		country.inputAccessoryView = toolBar
		sector.inputAccessoryView = toolBar
		complaint_Type.inputAccessoryView = toolBar
	}
	
	@objc func donePressed(_sender: UIBarButtonItem){
		complaint_Type.resignFirstResponder()
		sector.resignFirstResponder()
		country.resignFirstResponder()
	}
}

//
//  LoginViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 15/03/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import Alamofire
import Locksmith

class LoginViewController: UIViewController {

	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	
	let defaultValues = UserDefaults.standard
	
	override func viewDidLoad() {
        super.viewDidLoad()

       
    }
	
	let child = SpinnerViewController()
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
//
	
	@IBAction func signInClicked(_ sender: UIButton) {
		if emailField.text != "" && passwordField.text != "" {
//			createSpinnerView()
			showSpinner(child: child)
			let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/authenticate.php")
			var request = URLRequest(url: url!)
			request.httpMethod = "POST"
			let params = "email=\(emailField.text!)&password=\(passwordField.text!)"
			request.httpBody = params.data(using: String.Encoding.utf8)
			
			let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
				if error != nil {
					self.hideSpinner(child: self.child)
					print(error?.localizedDescription as Any)
					return
				}
				do
				{
					let decoder = JSONDecoder()
					do {
						let result = try decoder.decode(loginUser.self, from: data!)
						self.defaultValues.set(result.BCP_email!, forKey: "email")
						self.defaultValues.set(result.BCP_fullname!, forKey: "fullName")
						self.defaultValues.set(result.BCP_userID!, forKey: "userID")
						self.defaultValues.set(result.BCP_userType!, forKey: "userType")
						try Locksmith.saveData(data: ["currentUser": "\(result.BCP_email! + result.BCP_userID!)"], forUserAccount: "userAccount")
						print(result)
						DispatchQueue.main.async {
							self.performSegue(withIdentifier: "loginToHome", sender: nil)
							self.hideSpinner(child: self.child)
						}
					}
					catch DecodingError.typeMismatch {
						let result = try decoder.decode(ErrorData.self, from: data!)
						if result.message! == "Password is too short" {
							DispatchQueue.main.async {
								self.showToast(message: "Account does not exist")
								self.hideSpinner(child: self.child)
							}
						}
						else if result.message! == "Account does not exist" {
							DispatchQueue.main.async {
								//						self.removeSpinner()
								self.showToast(message: "Account does not exist")
								self.hideSpinner(child: self.child)
							}
						}
					}
				} catch let parsingError {
					self.hideSpinner(child: self.child)
					print("Error", parsingError)
					self.showToast(message: parsingError.localizedDescription)
				}
			}
			task.resume()
		}
		else {
			showToast(message: "Please ensure the fields are not empty")
		}
	}
	
	@IBAction func signUpClicked(_ sender: Any) {
		let url = URL(string: "https://www.index-holdings.com/bcp/register")
		UIApplication.shared.open(url!)
	}
	
}

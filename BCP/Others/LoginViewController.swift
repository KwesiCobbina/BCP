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
import SafariServices

class LoginViewController: UIViewController, SFSafariViewControllerDelegate {

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
			let url = URL(string: "\(AppConstants.sharedInstance.prodURL)authenticate.php")
//			let url = URL(string: "https://bcp.gov.gh/bcp_api/authenticate.php")
//			let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/authenticate.php")
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
					let outputStr  = String(data: data!, encoding: String.Encoding.utf8)
					print(outputStr!)
					let decoder = JSONDecoder()
					do {
						let result = try decoder.decode(loginUser.self, from: data!)
						self.defaultValues.set(result.BCP_email , forKey: "email")
						self.defaultValues.set(result.BCP_fullname , forKey: "fullName")
						self.defaultValues.set(result.BCP_userID , forKey: "userID")
						self.defaultValues.set(result.BCP_userType , forKey: "userType")
						self.defaultValues.set("About yourself. If you want to add a brief information about yourself, you can alick on the Account Tab then click on personal info then fill in the space provided and click on the button Save Changes. Thank You.", forKey: "about")
						self.defaultValues.set("12 Agbogba - Haatso", forKey: "location")
						try Locksmith.saveData(data: ["currentUser": "\(result.BCP_email + result.BCP_userID)"], forUserAccount: "userAccount")
							print(result)
						DispatchQueue.main.async {
                            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                            let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "HomeTabViewController") as! HomeTabViewController
                            appDelegate.window?.rootViewController = initialViewController
                            appDelegate.window?.makeKeyAndVisible()
							self.hideSpinner(child: self.child)
						}
					
					}
					catch DecodingError.typeMismatch {
						let result = try decoder.decode(ErrorData.self, from: data!)
						if result.message! == "Password is too short" {
							DispatchQueue.main.async {
//								self.showToast(message: "Please check your login credentials and try again. Thank you.")
                                let alert = UIAlertController(title: "Credential Error", message: "Please check your credentials and try again.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
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
						else if result.message! == "Password is too long" {
							DispatchQueue.main.async {
                                let alert = UIAlertController(title: "Credential Error", message: "Please check your credentials and try again.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
//								self.showToast(message: "Please check your login credentials and try again. Thank you.")
								self.hideSpinner(child: self.child)
							}
						}
						else if result.message! == "Account is not active" {
							DispatchQueue.main.async {
								self.showToast(message: "Account is not active.")
								self.hideSpinner(child: self.child)
							}
						}
					}
					catch DecodingError.keyNotFound(let key, let context) {
						print("\(key.stringValue) was not found, \(context.debugDescription)")
						let result = try decoder.decode(ErrorData.self, from: data!)
						if result.message! == "Password is too short" {
							DispatchQueue.main.async {
//								self.showToast(message: "Please check your login credentials and try again. Thank you.")
                                let alert = UIAlertController(title: "Credential Error", message: "Please check your credentials and try again.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
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
						else if result.message! == "Password is too long" {
							DispatchQueue.main.async {
//								self.showToast(message: "Please check your login credentials and try again. Thank you.")
                                let alert = UIAlertController(title: "Credential Error", message: "Please check your credentials and try again.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
								self.hideSpinner(child: self.child)
							}
						}
						else if result.message! == "Account is not active" {
							DispatchQueue.main.async {
								self.showToast(message: "Account is not active.")
								self.hideSpinner(child: self.child)
							}
						}
					}
					
				} catch let parsingError {
					self.hideSpinner(child: self.child)
					print("Error", parsingError)
//                    self.showToast(message: "Please check your login credentials and try again. Thank you.")
                    let alert = UIAlertController(title: "Credential Error", message: "Please check your credentials and try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
//					self.showToast(message: parsingError.localizedDescription)
				}
			}
			task.resume()
		}
		else {
//			showToast(message: "Please ensure the fields are not empty.")
            let alert = UIAlertController(title: "Credential Error", message: "Please ensure the fields are not empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
		}
	}
	
	@IBAction func signUpClicked(_ sender: Any) {
		let url = URL(string: "https://bcp.gov.gh/register")
//		https://bcp.gov.gh/register
		let safariVC = SFSafariViewController(url: url!)
		self.present(safariVC, animated: true, completion: nil)
		safariVC.delegate = self
		
//		UIApplication.shared.open(url!)
	}
	
	func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
		controller.dismiss(animated: true, completion: nil)
	}
	
}

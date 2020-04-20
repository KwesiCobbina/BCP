////
////  HomeTwoViewController.swift
////  BCP
////
////  Created by Kwesi Adu Cobbina on 30/03/2019.
////  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
////
//
//import UIKit
//import UserNotifications
//
//class HomeTwoViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler:{didAllow, error in
//		})
//    }
//	
//	override func viewWillAppear(_ animated: Bool) {
//		UINavigationBar.appearance().barTintColor = UIColor.red
//	}
//	
//	@IBAction func currentClicked(_ sender: UIButton) {
//		let storyboard = UIStoryboard(name: "Main", bundle: nil)
//		let viewController1: UConsultationsViewController = storyboard.instantiateViewController(withIdentifier: "UConsultationsViewController") as! UConsultationsViewController
//		self.navigationController?.pushViewController(viewController1, animated: true)
//		print("Current Clicked")
//	}
//	@IBAction func postedClicked(_ sender: UIButton) {
//		let storyboard = UIStoryboard(name: "Main", bundle: nil)
//		let viewController1: CCalenderViewController = storyboard.instantiateViewController(withIdentifier: "CCalenderViewController") as! CCalenderViewController
//		self.navigationController?.pushViewController(viewController1, animated: true)
//		print("Calander Clicked")
//	}
//	@IBAction func yourSayClicked(_ sender: UIButton) {
//		let content = UNMutableNotificationContent()
//		content.title = "BCP App"
//		content.subtitle = "National MSME Policy"
//		content.body = "Check it out now"
//		content.badge = 0
//		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
//		let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
//		UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//
//		print("Say Clicked")
//	}
//	@IBAction func interestClicked(_ sender: UIButton) {
//		let storyboard = UIStoryboard(name: "Main", bundle: nil)
//		let viewController1: InterestsViewController = storyboard.instantiateViewController(withIdentifier: "InterestsViewController") as! InterestsViewController
//		self.navigationController?.pushViewController(viewController1, animated: true)
//		print("Interest Clicked")
//	}
//	@IBAction func closedClicked(_ sender: UIButton) {
//		print("Policies Clicked")
//	}
//	@IBAction func submitClicked(_ sender: UIButton) {
//		let storyboard = UIStoryboard(name: "Main", bundle: nil)
//		let viewController1: ComplaintViewController = storyboard.instantiateViewController(withIdentifier: "ComplaintViewController") as! ComplaintViewController
//		self.navigationController?.pushViewController(viewController1, animated: true)
//		print("Submit Clicked")
//	}
//	
//	@IBAction func policiesClicked(_ sender: UIButton) {
//		let storyboard = UIStoryboard(name: "Main", bundle: nil)
//		let viewController1: HomeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//		self.navigationController?.pushViewController(viewController1, animated: true)
//		print("Submit Clicked")
//	}
//	
//	
//	func postToken(Token: String){
//		let defaultValues = UserDefaults.standard
//		//let private_individual = defaultValues.string(forKey: "userType")
//		let BCP_userID = defaultValues.string(forKey: "userID")
//		//		#if DEVELOPMENT
//		//Develop
//		if BCP_userID != nil {
//			let url = URL(string: "\(AppConstants.sharedInstance.prodURL)save_push_token.php")
////			let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/save_push_token.php")
//			//		#else
//			//Production
//			//let url = URL(string: "https://bcp.gov.gh/save_push_token.php")
//			var request = URLRequest(url: url!)
//			request.httpMethod = "POST"
//
//			let params = "token=\(Token)&userId=\(BCP_userID!)"
//			request.httpBody = params.data(using: String.Encoding.utf8)
//			let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//				guard let _ = data,
//					error == nil else {
//						print(error?.localizedDescription ?? "Response Error")
//						return }
//				do{
//					let decoder = JSONDecoder()
//					let res = try decoder.decode(ErrorData.self, from: data!)
//					print(res.message!)
//
//				} catch let parsingError {
//					print("Error", parsingError)
//				}
//			}
//			task.resume()
//		}
//
//
//	}
	
//}
//

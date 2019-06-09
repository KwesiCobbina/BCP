//
//  HomeTwoViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 30/03/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import UserNotifications

class HomeTwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler:{didAllow, error in
		})
    }
	
	@IBAction func currentClicked(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController1: UConsultationsViewController = storyboard.instantiateViewController(withIdentifier: "UConsultationsViewController") as! UConsultationsViewController
		self.navigationController?.pushViewController(viewController1, animated: true)
		print("Current Clicked")
	}
	@IBAction func postedClicked(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController1: CCalenderViewController = storyboard.instantiateViewController(withIdentifier: "CCalenderViewController") as! CCalenderViewController
		self.navigationController?.pushViewController(viewController1, animated: true)
		print("Calander Clicked")
	}
	@IBAction func yourSayClicked(_ sender: UIButton) {
		let content = UNMutableNotificationContent()
		content.title = "BCP App"
		content.subtitle = "National MSME Policy"
		content.body = "Check it out now"
		content.badge = 0
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
		let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
		UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

		print("Say Clicked")
	}
	@IBAction func interestClicked(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController1: InterestsViewController = storyboard.instantiateViewController(withIdentifier: "InterestsViewController") as! InterestsViewController
		self.navigationController?.pushViewController(viewController1, animated: true)
		print("Interest Clicked")
	}
	@IBAction func closedClicked(_ sender: UIButton) {
		print("Policies Clicked")
	}
	@IBAction func submitClicked(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController1: ComplaintViewController = storyboard.instantiateViewController(withIdentifier: "ComplaintViewController") as! ComplaintViewController
		self.navigationController?.pushViewController(viewController1, animated: true)
		print("Submit Clicked")
	}
	
	@IBAction func policiesClicked(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController1: HomeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
		self.navigationController?.pushViewController(viewController1, animated: true)
		print("Submit Clicked")
	}
	
}


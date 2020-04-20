//
//  NotificationsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 13/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {

	@IBOutlet weak var notificationTableView: UITableView!
	var sections = [Notification]()
    override func viewDidLoad() {
        super.viewDidLoad()

		notificationTableView.delegate = self
		notificationTableView.dataSource = self
//		var sections = [Notification]()
//		sections = [Notification(category: "balls", titles: titlesA), Notification(category: "fools", titles: titlesB), Notification(category: "hahahaha", titles: titlesC)]
		
		fetchIt()
		notificationTableView.reloadData()
		
    }
    

	func fetchIt(){
		
		sections = [Notification(category: "balls", titles: titlesA),
					Notification(category: "fools", titles: titlesB),
					Notification(category: "hahahaha", titles: titlesC)]
	}
	
	
	
//	var sections = [Notification]()
	
	let titlesA = [["title":"Food", "org": "GIMPA", "time": "3 days ago"],["title":"Rice", "org": "ACITY", "time": "2 days ago"], ["title":"Car", "org": "LEGON", "time": "3 days ago"],["title":"Food", "org": "GIMPA", "time": "3 days ago"],["title":"Rice", "org": "ACITY", "time": "2 days ago"], ["title":"Car", "org": "LEGON", "time": "3 days ago"],["title":"Food", "org": "GIMPA", "time": "3 days ago"],["title":"Rice", "org": "ACITY", "time": "2 days ago"], ["title":"Car", "org": "LEGON", "time": "3 days ago"]]
	let titlesB = [["title":"GFA", "org": "GIMPA", "time": "3 days ago"],["title":"BANKU", "org": "ACITY", "time": "2 days ago"], ["title":"BOAT", "org": "LEGON", "time": "3 days ago"],["title":"Food", "org": "GIMPA", "time": "3 days ago"],["title":"Rice", "org": "ACITY", "time": "2 days ago"], ["title":"Car", "org": "LEGON", "time": "3 days ago"],["title":"Food", "org": "GIMPA", "time": "3 days ago"],["title":"Rice", "org": "ACITY", "time": "2 days ago"], ["title":"Car", "org": "LEGON", "time": "3 days ago"]]
	let titlesC = [["title":"Food", "org": "GIMPA", "time": "3 days ago"],["title":"Rice", "org": "ACITY", "time": "2 days ago"], ["title":"Car", "org": "LEGON", "time": "3 days ago"]]
	
	
	
//	sections = [Notification()]
	

}

extension NotificationsViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let items = self.sections[section].titles
		return (items.count)
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationTableViewCell
		let items = self.sections[indexPath.section].titles
		let item = items[indexPath.row]
		cell.titleLable.text = item["title"]
		cell.daysLabel.text = item["time"]
		cell.organisationLabel.text = item["org"]
		print(item)
		return cell
		}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return self.sections.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return self.sections[section].category
	}


}

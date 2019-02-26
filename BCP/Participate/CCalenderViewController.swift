//
//  CCalenderViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 06/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import FSCalendar

class CCalenderViewController: UIViewController {

	@IBOutlet weak var consultTableView: UITableView!
	@IBOutlet weak var cCalenderView: FSCalendar!
	var posts: [BasicPost] = []
	var selectedPost: BasicPost?
	var topicTitleH: String?
	var institutionNameH: String?
	var daysLeftH: String?
	var detailsH: String?
	
	override func viewDidLoad() {
        super.viewDidLoad()

		consultTableView.dataSource = self
		consultTableView.delegate = self
		posts = createArray()
		cCalenderView.delegate = self
		
    }
	
	func createArray() -> [BasicPost] {
		var tempPosts: [BasicPost] = []
		
		let post1 = BasicPost(daysLeft: "5 days Left", postTitle: "IEEE 5th Congregation", organisationName: "Ghana Institute Of Management And Public Administration", postDetails: "IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?")
		let post2 = BasicPost(daysLeft: "5 days Left", postTitle: "IEEE 5th Congregation", organisationName: "Ghana Institute Of Management And Public Administration", postDetails: "IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?")
		
		tempPosts.append(post1)
		tempPosts.append(post2)
		
		return tempPosts
	}

}


extension CCalenderViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let post = posts[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "ConsultCell") as! ConsultationTableViewCell
		cell.setPost(post: post)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.selectedPost = self.posts[indexPath.row]
		topicTitleH = self.selectedPost?.postTitle
		institutionNameH = self.selectedPost?.organisationName
		daysLeftH = self.selectedPost?.daysLeft
		detailsH = self.selectedPost?.postDetails
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vcB = storyboard.instantiateViewController(withIdentifier: "MoreDetailsViewController") as! MoreDetailsViewController
		self.navigationController?.pushViewController(vcB, animated: true)
	}
	
//	sedToDetails
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "sedToDetails" {
			let vc = segue.destination as? MoreDetailsViewController
			vc?.t = false
		}
	}
	
	
}


extension CCalenderViewController: FSCalendarDelegate, FSCalendarDataSource {

	func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
		print(date)
	}
}

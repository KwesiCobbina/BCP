//
//  ActualHomeViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 08/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class ActualHomeViewController: UIViewController {

	@IBOutlet weak var homeSliderView: UIView!
	@IBOutlet weak var homePageControl: UIPageControl!
	@IBOutlet weak var homeTableView: UITableView!
	@IBOutlet weak var messageLabel: UILabel!
	@IBOutlet weak var tableBox: UIView!
	
	var posts: [HomePost] = []
	override func viewDidLoad() {
        super.viewDidLoad()
		
		homeTableView.delegate = self
		homeTableView.dataSource = self
		posts = createArray()

    }
	
	func fetchLatestPost() {
		
	}
    

	func createArray() -> [HomePost] {
		var tempPosts: [HomePost] = []
		
		let post1 = HomePost(daysLeft: "7th Febuary 2019.", postTitle: "IEEE 5th Congregation", organisationName: "Ghana Institute Of Management And Public Administration", postDetails: "IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?")
		
		let post2 = HomePost(daysLeft: "7th Febuary 2019", postTitle: "WiTE", organisationName: "Women In Technology and Engineering", postDetails: "IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?")
		
		let post3 = HomePost(daysLeft: "6th Febuary 2019", postTitle: "IEEE 25th Congregation", organisationName: "Ghana Institute Of Management And Public Administration", postDetails: "IEEE GreenTech was conceived to address this pressing challenge:")
		
		let post4 = HomePost(daysLeft: "5th Febuary 2019", postTitle: "IEEE Conference 2018", organisationName: "Ghana Institute Of Management And Public Administration", postDetails: "IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?")
		
		let post5 = HomePost(daysLeft: "5th Febuary 2019", postTitle: "IEEE 5th Congregation", organisationName: "Ghana Institute Of Management And Public Administration", postDetails: "IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?")
		
		tempPosts.append(post1)
		tempPosts.append(post2)
		tempPosts.append(post3)
		tempPosts.append(post4)
		tempPosts.append(post5)
		
		return tempPosts
	}
	
	

}


extension ActualHomeViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let post = posts[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell") as! HomeTableViewCell
		cell.setPost(post: post)
		
		return cell
	}
	
	
}

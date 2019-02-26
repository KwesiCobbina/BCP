//
//  HomeViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 02/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class LegislativeViewController: UIViewController {

	@IBOutlet weak var homeTableView: UITableView!
	var posts: [BasicPost] = []
    override func viewDidLoad() {
        super.viewDidLoad()

		homeTableView.delegate = self
		homeTableView.dataSource = self
		posts = createArray()
//		homeTableView.rowHeight = 160
        // Do any additional setup after loading the view.
    }
    

	func createArray() -> [BasicPost] {
		var tempPosts: [BasicPost] = []
		
		let post1 = BasicPost(daysLeft: "5 days Left", postTitle: "IEEE 5th Congregation", organisationName: "Ghana Institute Of Management And Public Administration", postDetails: "IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?")
		
		let post2 = BasicPost(daysLeft: "1 day Left", postTitle: "WiTE", organisationName: "Women In Technology and Engineering", postDetails: "IEEE GreenTech was conceived to address this pressing challenge")
		
		let post3 = BasicPost(daysLeft: "6 days Left", postTitle: "IEEE 25th Congregation", organisationName: "Ghana Institute Of Management And Public Administration", postDetails: "IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?")
		
		let post4 = BasicPost(daysLeft: "15 days Left", postTitle: "IEEE Conference 2018", organisationName: "Ghana Institute Of Management And Public Administration", postDetails: "IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?")
		
		let post5 = BasicPost(daysLeft: "25 days Left", postTitle: "IEEE 5th Congregation", organisationName: "Ghana Institute Of Management And Public Administration", postDetails: "IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?")
		
		tempPosts.append(post1)
		tempPosts.append(post2)
		tempPosts.append(post3)
		tempPosts.append(post4)
		tempPosts.append(post5)
		
		return tempPosts
	}

}



extension LegislativeViewController: UITableViewDelegate,UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let post = posts[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell") as! BasicTableViewCell
		cell.setPost(post: post)
		
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts.count
	}
}

//
//  ViewController2.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 03/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class RegulationsViewController: UIViewController {

	@IBOutlet weak var tableView2: UITableView!
	var policyPosts: [BasicPost] = []
	override func viewDidLoad() {
        super.viewDidLoad()

		
		tableView2.delegate = self
		tableView2.dataSource = self
		policyPosts = createArray()
		
    }
	
	func createArray() -> [BasicPost] {
		var tempPosts: [BasicPost] = []
		
		let post1 = BasicPost(daysLeft: "1 day Left", postTitle: "IEEE 5th Congregation", organisationName: "Ghana Institute Of Management And Public Administration", postDetails: "IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?")
		
		let post2 = BasicPost(daysLeft: "1 day Left", postTitle: "WiTE", organisationName: "Women In Technology and Engineering", postDetails: "IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?")
		
		/*let post3 = BasicPost(daysLeft: "30 days Left", postTitle: "IEEE 25th Congregation", organisationName: "Ghana Institute Of Management And Public Administration", postDetails: "IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?")
		
		let post4 = BasicPost(daysLeft: "50 days Left", postTitle: "IEEE Conference 2018", organisationName: "Ghana Institute Of Management And Public Administration", postDetails: "IEEE GreenTech was conceived to address this pressing challenge: How do we provide the reliable energy demanded by an environmentally sensitive world using energy resources in a sustainable and environmentally responsible manner?")
		*/
		
		tempPosts.append(post1)
		tempPosts.append(post2)
//		tempPosts.append(post3)
//		tempPosts.append(post4)
		
		return tempPosts
	}

	

}


extension RegulationsViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let post = policyPosts[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "PoliciesCell") as! BasicTableViewCell
		cell.setPost(post: post)
		
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return policyPosts.count
	}
}

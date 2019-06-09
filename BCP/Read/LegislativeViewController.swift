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
	@IBOutlet weak var appIcon: UIImageView!
	@IBOutlet weak var noDataLabel: UILabel!
	var posts: [Read] = []
    override func viewDidLoad() {
        super.viewDidLoad()

		homeTableView.delegate = self
		homeTableView.dataSource = self
//		posts = createArray()
//		homeTableView.rowHeight = 160
        // Do any additional setup after loading the view.
		fetchLegisilative()
    }
	
	func checkDatas() {
		if posts.isEmpty {
			homeTableView.isHidden = true
			noDataLabel.isHidden = false
			appIcon.isHidden = false
			
		}
		else {
			homeTableView.isHidden = false
			noDataLabel.isHidden = true
			appIcon.isHidden = true
		}
	}
	
	func fetchLegisilative() {
		var tempInterests: [Read] = []
		let menu_id = "5"
		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_read_menu_details.php")
		var request = URLRequest(url: url!)
		request.httpMethod = "POST"


		let params = "menu_id=\(menu_id)"
		request.httpBody = params.data(using: String.Encoding.utf8)
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard let dataResponse = data,
				error == nil else {
					print(error?.localizedDescription ?? "Response Error")
					return }
			do{

				let countries = try JSONDecoder().decode([Read].self, from: dataResponse)

				for data in countries {
					tempInterests.append(data)
					print(data)
				}
				self.posts = []
				self.posts = tempInterests



			} catch let parsingError {
				print("Error", parsingError)
			}
			DispatchQueue.main.async {
				self.homeTableView.reloadData()
			}
		}
		task.resume()
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
		checkDatas()
		return posts.count
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "legisToMore" {
			let indexPaths=self.homeTableView!.indexPathsForSelectedRows!
			let indexPath = indexPaths[0] as NSIndexPath
			let vc = segue.destination as? MoreOnPolicyViewController
			vc?.policy_id = self.posts[indexPath.row].policy_id!
		}
	}
}

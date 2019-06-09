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
	@IBOutlet weak var appIcon: UIImageView!
	@IBOutlet weak var noDataLabel: UILabel!
	var policyPosts: [Read] = []
	override func viewDidLoad() {
        super.viewDidLoad()

		
		tableView2.delegate = self
		tableView2.dataSource = self
		
    }
	override func viewWillAppear(_ animated: Bool) {
		fetchRegulations()
	}
	
	func checkDatas() {
		if policyPosts.isEmpty {
			tableView2.isHidden = true
			noDataLabel.isHidden = false
			appIcon.isHidden = false
			
		}
		else {
			tableView2.isHidden = false
			noDataLabel.isHidden = true
			appIcon.isHidden = true
		}
	}
	
	func fetchRegulations() {
		var tempAdminis: [Read] = []
		let menu_id = "3"
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
					tempAdminis.append(data)
					print(data)
				}
				self.policyPosts = []
				self.policyPosts = tempAdminis
				
				
				
			} catch let parsingError {
				print("Error", parsingError)
			}
			DispatchQueue.main.async {
				self.tableView2.reloadData()
			}
		}
		task.resume()
	}
	

}


extension RegulationsViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let post = policyPosts[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell") as! BasicTableViewCell
		cell.setPost(post: post)
		
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		checkDatas()
		return policyPosts.count
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "regulationsToMore" {
			let indexPaths=self.tableView2!.indexPathsForSelectedRows!
			let indexPath = indexPaths[0] as NSIndexPath
			let vc = segue.destination as? MoreOnPolicyViewController
			vc?.policy_id = self.policyPosts[indexPath.row].policy_id!
		}
	}
}

//
//  PoliciesViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 20/04/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class PoliciesViewController: UIViewController {

	@IBOutlet weak var policiesTableView: UITableView!
	@IBOutlet weak var appIcon: UIImageView!
	@IBOutlet weak var noDataLabel: UILabel!
	var datas: [Read] = []
	var policy_id = ""
    override func viewDidLoad() {
        super.viewDidLoad()

		policiesTableView.delegate = self
		policiesTableView.dataSource = self
		fetchPolicies()
        // Do any additional setup after loading the view.
    }
//
//	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		if segue.identifier == "policyToMore" {
//			self.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
//		}
//	}
	
	func checkDatas() {
		if datas.isEmpty {
			policiesTableView.isHidden = true
			noDataLabel.isHidden = false
			appIcon.isHidden = false
			
		}
		else {
			policiesTableView.isHidden = false
			noDataLabel.isHidden = true
			appIcon.isHidden = true
		}
	}
	
	func fetchPolicies() {
		var tempAdminis: [Read] = []
		let menu_id = "2"
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
				self.datas = []
				self.datas = tempAdminis
				
				
				
			} catch let parsingError {
				print("Error", parsingError)
			}
			DispatchQueue.main.async {
				self.policiesTableView.reloadData()
			}
		}
		task.resume()
	}
	

}

extension PoliciesViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let post = datas[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell") as! BasicTableViewCell
		cell.setPost(post: post)
		
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		checkDatas()
		return datas.count
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "policyToMore" {
			let indexPaths=self.policiesTableView!.indexPathsForSelectedRows!
			let indexPath = indexPaths[0] as NSIndexPath
			let vc = segue.destination as? MoreOnPolicyViewController
			vc?.policy_id = self.datas[indexPath.row].policy_id!
		}
	}
}

//
//  InterestsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 06/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class InterestsViewController: UIViewController {

	@IBOutlet weak var interestsTableView: UITableView!
	@IBOutlet weak var appIcon: UIImageView!
	@IBOutlet weak var noDataLabel: UILabel!
	
	var datas: [Interest] = []
	var datases: [Interest] = []
	var defaults = UserDefaults.standard
	override func viewDidLoad() {
        super.viewDidLoad()

		interestsTableView.delegate = self
		interestsTableView.dataSource = self
//		interestsTableView.reloadData()
		fetchInterests()
		
    }
	
	func checkDatas() {
		if datas.isEmpty {
			interestsTableView.isHidden = true
			noDataLabel.isHidden = false
			appIcon.isHidden = false
			
		}
		else {
			interestsTableView.isHidden = false
			noDataLabel.isHidden = true
			appIcon.isHidden = true
		}
	}
	
	func fetchInterests() {
		var tempInterests: [Interest] = []
//		production
		let defaultValues = UserDefaults.standard
		let private_individual = defaultValues.string(forKey: "userType")
		let BCP_userID = defaultValues.string(forKey: "userID")
		print(defaultValues.string(forKey: "userType")!)
		
//		testing
//		let private_individual = "private_individual"
//		let BCP_userID = "6"
		
		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_consultation_interest.php")
		var request = URLRequest(url: url!)
		request.httpMethod = "POST"
		
		
		let params = "BCP_userID=\(BCP_userID!)&BCP_userType=\(private_individual!)"
		request.httpBody = params.data(using: String.Encoding.utf8)
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard let dataResponse = data,
				error == nil else {
					print(error?.localizedDescription ?? "Response Error")
					return }
			do{
				
				let countries = try JSONDecoder().decode([Interest].self, from: dataResponse)
				
				for data in countries {
					tempInterests.append(data)
					print(data)
				}
				self.datas = []
				self.datas = tempInterests
				
				
				
			} catch let parsingError {
				print("Error", parsingError)
			}
			DispatchQueue.main.async {
				self.interestsTableView.reloadData()
			}
		}
		task.resume()
	}
	
	var d = IndexPath()
}


extension InterestsViewController: UITableViewDelegate,UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		datas = datases
		checkDatas()
		return datas.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let data = datas[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell1") as! InterestTableViewCell
		print(data.consultation_id!)
		cell.setData(post: data)
//		d = indexPath
		cell.addBtn.tag = indexPath.row
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "myInterestsToMore" {
			if let button = sender as? UIButton {
				let vc = segue.destination as? MoreDetailsViewController
				vc?.t = false
				vc?.daysLeft = self.datas[button.tag].period
				vc?.details = self.datas[button.tag].description
				vc?.institutionName = self.datas[button.tag].institution
				vc?.topicTitle = self.datas[button.tag].topic
				vc?.srtDate = self.datas[button.tag].start_date
				vc?.postedDate = self.datas[button.tag].created_on
				print(button.tag)
			}
			
		}
	}
	
	
}

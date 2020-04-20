//
//  InterestsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 06/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class MyInterestsViewController: UIViewController {

	@IBOutlet weak var interestsTableView: UITableView!
//	@IBOutlet weak var appIcon: UIImageView!
//	@IBOutlet weak var noDataLabel: UILabel!
	
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
//			noDataLabel.isHidden = false
//			appIcon.isHidden = false
			
		}
		else {
			interestsTableView.isHidden = false
//			noDataLabel.isHidden = true
//			appIcon.isHidden = true
		}
	}
	
	func fetchInterests() {
		var tempInterests: [Interest] = []
//		production
		let defaultValues = UserDefaults.standard
		let private_individual = defaultValues.string(forKey: "userType")
		let BCP_userID = defaultValues.string(forKey: "userID")
		print(defaultValues.string(forKey: "userType")!)
		print(BCP_userID!)

		
		let url = URL(string: "\(AppConstants.sharedInstance.prodURL)bcp_consultation_interest.php")
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


extension MyInterestsViewController: UITableViewDelegate,UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return datas.count
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 5.0
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let data = datas[indexPath.section]
            let cell = tableView.dequeueReusableCell(withIdentifier: "interestCell") as! InterestTableViewCell
            cell.setData(post: data)
    //        cell.addBtn.tag = indexPath.row
            cell.layer.shadowOffset = CGSize(width: -1, height: 1)
            cell.selectionStyle = .none
            cell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "myInterestToMore", sender: indexPath)
        }
    }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "myInterestToMore" {
                let consultsDetailView = segue.destination as? MoreDetailsViewController
                let indexPath = sender as! IndexPath
                let selectedRow = datas[indexPath.section]
                
                consultsDetailView?.t = false
//                consultsDetailView?.selectedRecent = selectedRow
                consultsDetailView?.topicTitle = selectedRow.topic
                consultsDetailView?.duration = selectedRow.period
                consultsDetailView?.details = selectedRow.description
                consultsDetailView?.institutionName = selectedRow.institution
                consultsDetailView?.srtDate = selectedRow.start_date
                consultsDetailView?.postedDate = selectedRow.created_on
                consultsDetailView?.endDate = selectedRow.end_date
            }
        }
    
	
	
}

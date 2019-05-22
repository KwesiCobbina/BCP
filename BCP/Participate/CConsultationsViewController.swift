//
//  CConsultationsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 06/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class CConsultationsViewController: UIViewController {

	@IBOutlet weak var monthSelector: UISegmentedControl!
	@IBOutlet weak var closedConsultTableView: UITableView!
	@IBOutlet weak var appIcon: UIImageView!
	@IBOutlet weak var noDataMessage: UILabel!
	
	var datas: [Consultations] = []
	var januaryArray: [Consultations] = []
	var februaryArray: [Consultations] = []
	var marchArray: [Consultations] = []
	var aprilArray: [Consultations] = []
	var mayArray: [Consultations] = []
	var juneArray: [Consultations] = []
	var julyArray: [Consultations] = []
	var augustArray: [Consultations] = []
	var septemberArray: [Consultations] = []
	var octoberArray: [Consultations] = []
	var novemberArray: [Consultations] = []
	var decemberArray: [Consultations] = []
	var ignore: [Consultations] = []
	
	override func viewDidLoad() {
        super.viewDidLoad()

		closedConsultTableView.delegate = self
		closedConsultTableView.dataSource = self
        // Do any additional setup after loading the view.
		self.monthSelector.isHidden = true
		fetchClosedConsultations()
    }
	
	func checkDatas() {
		if datas.isEmpty {
			closedConsultTableView.isHidden = true
			noDataMessage.isHidden = false
			appIcon.isHidden = false
			
		}
		else {
			closedConsultTableView.isHidden = false
			noDataMessage.isHidden = true
			appIcon.isHidden = true
		}
	}
	
	func fetchClosedConsultations(){
		var tempfact: [Consultations] = []
		
		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_closed_consultation.php")
		let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
			guard let dataResponse = data,
				error == nil else {
					print(error?.localizedDescription ?? "Response Error")
					return }
			do{
				
				let recentFactories = try JSONDecoder().decode([Consultations].self, from: dataResponse)
				
				for data in recentFactories {
					tempfact.append(data)
					//					print(factory)
//					if data.start_date!.contains("January") {
//						self.januaryArray.append(data)
//					}
//					else if data.start_date!.contains("February") {
//						self.februaryArray.append(data)
//					}
//					else if data.start_date!.contains("March") {
//						self.marchArray.append(data)
//					}
//					else if data.start_date!.contains("April") {
//						self.aprilArray.append(data)
//					}
//					else if data.start_date!.contains("May") {
//						self.mayArray.append(data)
//					}
//					else if data.start_date!.contains("June") {
//						self.juneArray.append(data)
//					}
//					else if data.start_date!.contains("July") {
//						self.julyArray.append(data)
//					}
//					else if data.start_date!.contains("August") {
//						self.augustArray.append(data)
//					}
//					else if data.start_date!.contains("September") {
//						self.septemberArray.append(data)
//					}
//					else if data.start_date!.contains("October") {
//						self.octoberArray.append(data)
//					}
//					else if data.start_date!.contains("November") {
//						self.novemberArray.append(data)
//					}
//					else if data.start_date!.contains("December") {
//						self.decemberArray.append(data)
//					}
//					else {
//						self.ignore.append(data)
//					}
				}
				
				self.datas = tempfact
				
			} catch let parsingError {
				print("Error", parsingError)
			}
			DispatchQueue.main.async {
				self.closedConsultTableView.reloadData()
			}
		}
		task.resume()
	}
   
	@IBAction func monthChanged(_ sender: UISegmentedControl) {
		self.closedConsultTableView.reloadData()
	}
	
}



extension CConsultationsViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		let index = monthSelector.selectedSegmentIndex
		
//		if index == 0 {
//			datas = januaryArray
//			checkDatas()
//		}
//		else if index == 1 {
//			datas = februaryArray
//			checkDatas()
//		}
//		else if index == 2 {
//			datas = marchArray
//			checkDatas()
//		}
//		else if index == 3 {
//			datas = aprilArray
//			checkDatas()
//		}
//		else if index == 4 {
//			datas = mayArray
//			checkDatas()
//		}
//		else if index == 5 {
//			datas = juneArray
//			checkDatas()
//		}
//		else if index == 6 {
//			datas = julyArray
//			checkDatas()
//		}
//		else if index == 7 {
//			datas = augustArray
//			checkDatas()
//		}
//		else if index == 8 {
//			datas = septemberArray
//			checkDatas()
//		}
//		else if index == 9 {
//			datas = octoberArray
//			checkDatas()
//		}
//		else if index == 10 {
//			datas = novemberArray
//			checkDatas()
//		}
//		else if index == 11 {
//			datas = decemberArray
//			checkDatas()
//		}
		checkDatas()
		return datas.count
//		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let data = datas[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell3") as! ClosedTableViewCell
		cell.setData(post: data)
		return cell
	}
	
	
}

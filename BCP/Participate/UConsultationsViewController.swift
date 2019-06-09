//
//  UConsultationsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 06/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class UConsultationsViewController: UIViewController {

	

	@IBOutlet weak var upConsultTableView: UITableView!
	@IBOutlet weak var noDataMessage: UILabel!
	@IBOutlet weak var monthSegment: UISegmentedControl!
	@IBOutlet weak var appIcon: UIImageView!
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
	var carryArray:[Consultations] = []
	
	let child = SpinnerViewController()
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

		
		upConsultTableView.delegate = self
		upConsultTableView.dataSource = self
		monthSegment.isHidden = true
		fetchUpComingConsultations()
		upConsultTableView.isHidden = true
		showSpinner(child: child)
		
		
    }
	

	
	
	func checkDatas() {
		if datas.isEmpty {
			upConsultTableView.isHidden = true
			noDataMessage.isHidden = false
			appIcon.isHidden = false
			hideSpinner(child: child)
		}
		else {
			upConsultTableView.isHidden = false
			DispatchQueue.main.async {
				self.upConsultTableView.reloadData()
			}
			noDataMessage.isHidden = true
			appIcon.isHidden = true
			hideSpinner(child: child)
		}
	}
	
	
	func fetchUpComingConsultations(){
		var tempfact: [Consultations] = []
		
		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_active_consultation.php")
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
//				if self.datas.isEmpty {
//					print("nil")
//					self.upConsultTableView.isHidden = true
//				}
//				else {
//				self.upConsultTableView.reloadData()
//				}
				self.checkDatas()
			}
		}
		task.resume()
	}

	@IBAction func monthSelected(_ sender: UISegmentedControl) {
		
		self.upConsultTableView.reloadData()

	}
	

//	override func viewWillDisappear(_ animated: Bool) {
//		let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InterestsViewController") as? InterestsViewController
//		vc!.datases = carryArray
//	}

}



extension UConsultationsViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return datas.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let data = datas[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as! PagesTableViewCell
		cell.consultation = datas[indexPath.row]
		cell.delegate = self
		cell.setData(post: data)
		cell.addBtn.tag = indexPath.row
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "currentToDetails" {
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


extension UConsultationsViewController: PagesTableViewCellDelegate {
	
	func didTapAdd(post: PagesTableViewCell) {
		guard let indexPath = upConsultTableView?.indexPath(for: post) else {return}
		let post = self.datas[indexPath.item]
		var defaults = UserDefaults.standard
		if carryArray.isEmpty == false{
			for carry in carryArray {
				if carry.consultation_id != post.consultation_id {
					carryArray.append(post)
				}
				else {
					print(carryArray)
					return
				}
			}
		}
		else {
			carryArray.append(post)
			print(carryArray)
		}
		
	}
}

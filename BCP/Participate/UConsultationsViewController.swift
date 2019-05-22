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
	
	override func viewDidLoad() {
        super.viewDidLoad()

		upConsultTableView.delegate = self
		upConsultTableView.dataSource = self
		monthSegment.isHidden = true
//		datas = createArray()
        // Do any additional setup after loading the view.
		fetchUpComingConsultations()
		
		
    }
	

	
	
	func checkDatas() {
		if datas.isEmpty {
			upConsultTableView.isHidden = true
			noDataMessage.isHidden = false
			appIcon.isHidden = false
			
		}
		else {
			upConsultTableView.isHidden = false
			DispatchQueue.main.async {
				self.upConsultTableView.reloadData()
			}
			noDataMessage.isHidden = true
			appIcon.isHidden = true
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
				self.upConsultTableView.reloadData()
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
//		let index = monthSegment.selectedSegmentIndex
//
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
//		checkDatas()
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
//			let indexPaths = self.upConsultTableView!.indexPathsForSelectedRows!
//			let indexPath = indexPaths[0] as NSIndexPath
//			let vc = segue.destination as? MoreDetailsViewController
//			vc?.t = false
//			vc?.daysLeft = self.datas[indexPath.row].period
//			vc?.details = self.datas[indexPath.row].description
//			vc?.institutionName = self.datas[indexPath.row].institution
//			vc?.topicTitle = self.datas[indexPath.row].topic
//			vc?.srtDate = self.datas[indexPath.row].start_date
//			vc?.postedDate = self.datas[indexPath.row].created_on
			
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

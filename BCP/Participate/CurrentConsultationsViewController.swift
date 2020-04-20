//
//  UConsultationsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 06/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class CurrentConsultationsViewController: UIViewController {

	

	@IBOutlet weak var currentConsultTableView: UITableView!
	@IBOutlet weak var noDataMessage: UILabel!
	@IBOutlet weak var monthSegment: UISegmentedControl!
	@IBOutlet weak var appIcon: UIImageView!
	var datas: [Consultations] = []
//	var januaryArray: [Consultations] = []
//	var februaryArray: [Consultations] = []
//	var marchArray: [Consultations] = []
//	var aprilArray: [Consultations] = []
//	var mayArray: [Consultations] = []
//	var juneArray: [Consultations] = []
//	var julyArray: [Consultations] = []
//	var augustArray: [Consultations] = []
//	var septemberArray: [Consultations] = []
//	var octoberArray: [Consultations] = []
//	var novemberArray: [Consultations] = []
//	var decemberArray: [Consultations] = []
	var ignore: [Consultations] = []
	var carryArray:[Consultations] = []
	
	let child = SpinnerViewController()
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

		
		currentConsultTableView.delegate = self
		currentConsultTableView.dataSource = self
//		monthSegment.isHidden = true
		fetchUpComingConsultations()
		currentConsultTableView.isHidden = true
		showSpinner(child: child)
		
		
    }
	

	
	
	func checkDatas() {
		if datas.isEmpty {
			currentConsultTableView.isHidden = true
//			noDataMessage.isHidden = false
//			appIcon.isHidden = false
			hideSpinner(child: child)
		}
		else {
			currentConsultTableView.isHidden = false
			DispatchQueue.main.async {
				self.currentConsultTableView.reloadData()
			}
//			noDataMessage.isHidden = true
//			appIcon.isHidden = true
			hideSpinner(child: child)
		}
	}
	
	
	func fetchUpComingConsultations(){
		var tempfact: [Consultations] = []
		let url = URL(string: "\(AppConstants.sharedInstance.prodURL)bcp_active_consultation.php")
//		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_active_consultation.php")
		let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
			guard let dataResponse = data,
				error == nil else {
					print(error?.localizedDescription ?? "Response Error")
					return }
			do{
				
				let recentFactories = try JSONDecoder().decode([Consultations].self, from: dataResponse)
				
				for data in recentFactories {
					tempfact.append(data)
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
		
		self.currentConsultTableView.reloadData()

	}
	

//	override func viewWillDisappear(_ animated: Bool) {
//		let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InterestsViewController") as? InterestsViewController
//		vc!.datases = carryArray
//	}

}



extension CurrentConsultationsViewController: UITableViewDataSource, UITableViewDelegate {
    
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
		let cell = tableView.dequeueReusableCell(withIdentifier: "currentCell") as! PagesTableViewCell
		cell.consultation = datas[indexPath.section]
		cell.delegate = self
		cell.setData(post: data)
//		cell.addBtn.tag = indexPath.row
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.selectionStyle = .none
        cell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		return cell
	}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "currentToMore", sender: indexPath)
        }
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "currentToMore" {
			let consultsDetailView = segue.destination as? MoreDetailsViewController
            let indexPath = sender as! IndexPath
            let selectedRow = datas[indexPath.section]
            
            consultsDetailView?.t = false
//            consultsDetailView?.selectedRecent = selectedRow
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


extension CurrentConsultationsViewController: PagesTableViewCellDelegate {
	
	func didTapAdd(post: PagesTableViewCell) {
		guard let indexPath = currentConsultTableView?.indexPath(for: post) else {return}
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

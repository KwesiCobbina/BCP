//
//  CConsultationsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 06/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class ClosedConsultationsViewController: UIViewController {

	@IBOutlet weak var closedConsultTableView: UITableView!
	
	
	var datas: [Consultations] = []
    var navController = UINavigationController()
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

		closedConsultTableView.delegate = self
		closedConsultTableView.dataSource = self
		fetchClosedConsultations()
    }
	
	func checkDatas() {
		if datas.isEmpty {
			closedConsultTableView.isHidden = true
			
		}
		else {
			closedConsultTableView.isHidden = false
		}
	}
	
	func fetchClosedConsultations(){
		var tempfact: [Consultations] = []
		
        let url = URL(string: "\(AppConstants.sharedInstance.prodURL)bcp_closed_consultation.php")
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
				self.closedConsultTableView.reloadData()
			}
		}
		task.resume()
	}
   

	
}



extension ClosedConsultationsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
//        headerView.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "closedCell") as! ClosedConsultTableViewCell
        cell.setData(post: data)
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.selectionStyle = .none
        cell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "closedToMore", sender: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "closedToMore" {
            let consultsDetailView = segue.destination as? MoreDetailsViewController
            let indexPath = sender as! IndexPath
            let selectedRow = datas[indexPath.section]
            
            consultsDetailView?.t = true
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



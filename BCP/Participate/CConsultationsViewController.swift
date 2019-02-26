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
	
	var datas: [PagesData] = []
	
	override func viewDidLoad() {
        super.viewDidLoad()

		closedConsultTableView.delegate = self
		closedConsultTableView.dataSource = self
        // Do any additional setup after loading the view.
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
	
	func createArray() -> [PagesData] {
		var tempData: [PagesData] = []
		
		let data1 = PagesData(daysLeft: "3 days", postTitle: "Right to Information Bill", organisationName: "Ministry of Information", postDetails: "Parliament has begun the consideration of the Right to Information (RTI) Bill which has been before the House since 2013. The rationale for the bill is to give right and access to official information held by public institutions, private entities which perform public functions with public funds.", postDuration: "Aug 11- Sept 22, 2018")
		
		let data2 = PagesData(daysLeft: "13 days", postTitle: "Ban on Alcohol Advertisement", organisationName: "Food and Drugs Authority (FDA)", postDetails: "The Food and Drugs Authority (FDA) effective 1st January 2018, has banned both advertisement and Live Presenter Mention (LPM)of alcoholic beverages in the media before 8pm. This directive, the FDA says is to protect children and prevent them from being lured into alcoholism at their young age.", postDuration: "Aug 18 – Sept 14, 2018")
		
		tempData.append(data1)
		tempData.append(data2)
		return tempData
		
	}

   
	@IBAction func monthChanged(_ sender: UISegmentedControl) {
		self.closedConsultTableView.reloadData()
	}
	
}



extension CConsultationsViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let index = monthSelector.selectedSegmentIndex
		
		if index == 0 {
			datas = createArray()
			checkDatas()
		}
		else if index == 1 {
			datas = createArray()
			checkDatas()
		}
		else if index == 2 {
			datas = []
			checkDatas()
		}
		else if index == 3 {
			datas = createArray()
			checkDatas()
		}
		else if index == 4 {
			datas = []
			checkDatas()
		}
		else if index == 5 {
			datas = createArray()
			checkDatas()
		}
		else if index == 6 {
			datas = []
			checkDatas()
		}
		else if index == 7 {
			datas = createArray()
			checkDatas()
		}
		else if index == 8 {
			datas = []
			checkDatas()
		}
		else if index == 9 {
			datas = createArray()
			checkDatas()
		}
		else if index == 10 {
			datas = []
			checkDatas()
		}
		else if index == 11 {
			datas = createArray()
			checkDatas()
		}
		
		return datas.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let data = datas[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell3") as! ClosedTableViewCell
		cell.setData(post: data)
		return cell
	}
	
	
}

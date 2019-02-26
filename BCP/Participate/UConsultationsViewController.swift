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
	var datas: [PagesData] = []
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

		upConsultTableView.delegate = self
		upConsultTableView.dataSource = self
		
//		datas = createArray()
        // Do any additional setup after loading the view.
		
		
		
    }
	

	
	
	func checkDatas() {
		if datas.isEmpty {
			upConsultTableView.isHidden = true
			noDataMessage.isHidden = false
			appIcon.isHidden = false
			
		}
		else {
			upConsultTableView.isHidden = false
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
	
	func createArray2() -> [PagesData] {
		var tempData: [PagesData] = []
		
		let data1 = PagesData(daysLeft: "5 days", postTitle: "Right to Information Bill", organisationName: "Ministry of Information", postDetails: "Parliament has begun the consideration of the Right to Information (RTI) Bill which has been before the House since 2013. The rationale for the bill is to give right and access to official information held by public institutions, private entities which perform public functions with public funds.", postDuration: "Aug 11- Sept 22, 2018")
		
		let data2 = PagesData(daysLeft: "13 days", postTitle: "Ban on Alcohol Advertisement", organisationName: "Food and Drugs Authority (FDA)", postDetails: "The Food and Drugs Authority (FDA) effective 1st January 2018, has banned both advertisement and Live Presenter Mention (LPM)of alcoholic beverages in the media before 8pm. This directive, the FDA says is to protect children and prevent them from being lured into alcoholism at their young age.", postDuration: "Aug 18 – Sept 14, 2018")
		
		let data3 = PagesData(daysLeft: "13 days", postTitle: "Ban on Alcohol Advertisement", organisationName: "Food and Drugs Authority (FDA)", postDetails: "The Food and Drugs Authority (FDA) effective 1st January 2018, has banned both advertisement and Live Presenter Mention (LPM)of alcoholic beverages in the media before 8pm. This directive, the FDA says is to protect children and prevent them from being lured into alcoholism at their young age.", postDuration: "Aug 18 – Sept 14, 2018")
		
		tempData.append(data1)
		tempData.append(data2)
		tempData.append(data3)
		return tempData
		
	}
	@IBAction func monthSelected(_ sender: UISegmentedControl) {
		
		self.upConsultTableView.reloadData()
		
		
	}
	

}



extension UConsultationsViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let index = monthSegment.selectedSegmentIndex
		
		if index == 0 {
			datas = createArray()
			checkDatas()
		}
		else if index == 1 {
			datas = createArray2()
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
			datas = createArray2()
			checkDatas()
		}
		else if index == 6 {
			datas = []
			checkDatas()
		}
		else if index == 7 {
			datas = createArray2()
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
			datas = createArray2()
			checkDatas()
		}
		
		return datas.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let data = datas[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as! PagesTableViewCell
		cell.setData(post: data)
		return cell
	}
	
	
}

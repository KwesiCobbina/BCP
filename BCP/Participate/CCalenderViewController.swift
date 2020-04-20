//
//  CCalenderViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 06/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import FSCalendar

class CCalenderViewController: UIViewController {

	@IBOutlet weak var consultTableView: UITableView!
	@IBOutlet weak var cCalenderView: FSCalendar!
	@IBOutlet weak var viewer: UIView!
	var posts: [Consultations] = []
	var selectedPost: Consultations?
	var topicTitleH: String?
	var institutionNameH: String?
	var daysLeftH: String?
	var detailsH: String?
	var datas: [Consultations] = []
	var currentMonth:[Consultations] = []
	var stringDates:[String] =  []
	var state: Bool = false
	var definite = false
	var currentsMonth: String?
    var currentsYear: String?
	
	
	fileprivate lazy var dateFormatter1: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd-MM-yyyy"
		return formatter
	}()
	
	fileprivate lazy var dateFormatter2: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}()
	
	lazy var noInfoLabel: UILabel = {
		let noInfo = UILabel()
		noInfo.text = "No Consultations for this month."
		noInfo.textColor = .gray
		noInfo.font = noInfo.font.withSize(20)
		noInfo.translatesAutoresizingMaskIntoConstraints = false
		return noInfo
	}()
	
	override func viewDidLoad() {
        super.viewDidLoad()

		consultTableView.dataSource = self
		consultTableView.delegate = self
		cCalenderView.delegate = self
		cCalenderView.dataSource = self
		let now = Date()
		currentsMonth = getMonth(date: now)
        
		fetchCalenderConsultations()
		self.viewer.addSubview(self.noInfoLabel)
		self.noInfoLabel.centerXAnchor.constraint(equalTo: self.viewer.centerXAnchor).isActive = true
		self.noInfoLabel.centerYAnchor.constraint(equalTo: self.viewer.centerYAnchor).isActive = true
		
//		getMonth()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		cCalenderView.reloadData()
	}
	
	func getMonth(date: Date) -> String{
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "LLLL"
		let nameOfMonth = dateFormatter.string(from: date)
		return nameOfMonth
	}
	
	func fetchCalenderConsultations(){
		var tempfact: [Consultations] = []
		let url = URL(string: "\(AppConstants.sharedInstance.prodURL)bcp_calendar.php")
		let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
			guard let dataResponse = data,
				error == nil else {
					print(error?.localizedDescription ?? "Response Error")
					return }
			do{
				let recentFactories = try JSONDecoder().decode([Consultations].self, from: dataResponse)
				for var data in recentFactories {
					let dateFormatter = DateFormatter()
					dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
					let dateFromString : Date = dateFormatter.date(from: data.created_on!)!
					dateFormatter.dateFormat = "dd-MM-yyyy"
					let datenew = dateFormatter.string(from: dateFromString)
					self.stringDates.append(datenew)
					data.month = self.getMonth(date: dateFromString)
					tempfact.append(data)
				}
				self.datas = tempfact
			} catch let parsingError {
				print("Error", parsingError)
			}
			DispatchQueue.main.async {
				for a in self.datas {
					if a.month == self.currentsMonth {
						DispatchQueue.main.async {
							print(self.currentsMonth! + " " + a.month!)
							self.consultTableView.isHidden = true
							self.definite = true
							self.currentMonth.append(a)
							self.consultTableView.reloadData()
							self.noInfoLabel.isHidden = false
							print(self.currentMonth.count)
						}
					}
					else {
						self.noInfoLabel.text = "No Consultations for this month."
						self.noInfoLabel.isHidden = false
						self.definite = false
						self.consultTableView.isHidden = true
					}
				}
				self.consultTableView.reloadData()
				self.cCalenderView.reloadData()
			}
		}
		task.resume()
	}

}


extension CCalenderViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if definite == false {
		if state == false {
			return datas.count
		}
		else {
			return posts.count
		}
		}
		else {
			return currentMonth.count
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var post = Consultations()
        if definite == false {
		if state == false {
			post = datas[indexPath.row]
		}
		else if state == true {
			print(state)
			post = posts[indexPath.row]
		}
		}
		else {
			post = currentMonth[indexPath.row]
		}
		let cell = tableView.dequeueReusableCell(withIdentifier: "ConsultCell") as! ConsultationTableViewCell
		cell.setPost(post: post)
		
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "sedToDetails" {
			let indexPaths=self.consultTableView!.indexPathsForSelectedRows!
			let indexPath = indexPaths[0] as NSIndexPath
			let vc = segue.destination as? MoreDetailsViewController
			if definite == false {
			if state == false {
				vc?.t = false
				vc?.daysLeft = self.datas[indexPath.row].period
				vc?.details = self.datas[indexPath.row].description
				vc?.institutionName = self.datas[indexPath.row].institution
				vc?.topicTitle = self.datas[indexPath.row].topic
				vc?.srtDate = self.datas[indexPath.row].start_date
				vc?.postedDate = self.datas[indexPath.row].created_on
			}
			else if state == true {
				vc?.t = true
				vc?.daysLeft = self.posts[indexPath.row].period
				vc?.details = self.posts[indexPath.row].description
				vc?.institutionName = self.posts[indexPath.row].institution
				vc?.topicTitle = self.posts[indexPath.row].topic
				vc?.srtDate = self.posts[indexPath.row].start_date
				vc?.postedDate = self.posts[indexPath.row].created_on
			}
			}
			else {
				vc?.t = true
				vc?.daysLeft = self.currentMonth[indexPath.row].period
				vc?.details = self.currentMonth[indexPath.row].description
				vc?.institutionName = self.currentMonth[indexPath.row].institution
				vc?.topicTitle = self.currentMonth[indexPath.row].topic
				vc?.srtDate = self.currentMonth[indexPath.row].start_date
				vc?.postedDate = self.currentMonth[indexPath.row].created_on
			}
		}
	}
	
	
}


extension CCalenderViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

	func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
		let key = self.dateFormatter2.string(from: date)
		
		
		for data in datas {
			if (data.created_on?.contains(key))! {
				DispatchQueue.main.async {
					self.state = true
					self.definite = false
					self.posts = []
					self.noInfoLabel.isHidden = true
					self.consultTableView.isHidden = false
					//if data.start_date?.contains(month) {}
					self.posts.append(data)
					self.consultTableView.reloadData()
				}
			}
			else{
				//self.definite = false
				self.noInfoLabel.isHidden = false
				self.noInfoLabel.text = "No Consultations for this date."
				self.state = false
				self.consultTableView.isHidden = true
				self.consultTableView.reloadData()
			}
			
		}
	}

	func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
		let key = self.dateFormatter1.string(from: date)

		if stringDates.contains(key) {
			return UIColor.blue
		}
		return nil
	}
	
	func calendarCurrentPageDidChange(_ calendar: FSCalendar) {

		let vals = self.dateFormatter2.string(from: calendar.currentPage)
//		print(vals)
		let date = dateFormatter2.date(from:vals)!
		let month = getMonth(date: date)
		self.currentMonth = []
		for a in datas {
			if a.month == month {
				DispatchQueue.main.async {
					print(month + " " + a.month!)
					self.consultTableView.isHidden = false
					self.definite = true
					self.currentMonth.append(a)
					self.consultTableView.reloadData()
					self.noInfoLabel.isHidden = true
					print(self.currentMonth.count)
				}
			}
			else {
				self.viewer.addSubview(self.noInfoLabel)
				self.noInfoLabel.isHidden = false
				self.noInfoLabel.text = "No Consultations for this month."
				self.definite = false
				self.consultTableView.isHidden = true
			}

		}
		
		cCalenderView.reloadData()
	}
	
	func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
		let dateString = self.dateFormatter1.string(from: date)
		if self.stringDates.contains(dateString) {
			return 1
		}
		return 0
	}
	
	
}

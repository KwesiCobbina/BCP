//
//  CalanderdViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 27/02/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import FSCalendar

class CalanderdViewController: UIViewController, UIGestureRecognizerDelegate {
    
    

    var recents: [Recents] = []
    
    var datas: [Consultations] = []
    var currentMonth:[Consultations] = []
    var posts: [Consultations] = []
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
    
//    lazy var noInfoLabel: UILabel = {
//        let noInfo = UILabel()
//        noInfo.text = "No Consultations for this month."
//        noInfo.textColor = .gray
//        noInfo.font = noInfo.font.withSize(20)
//        noInfo.translatesAutoresizingMaskIntoConstraints = false
//        return noInfo
//    }()
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarTable: UITableView!
    @IBOutlet weak var nothingToShowLabel: UILabel!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarTable.delaysContentTouches = false
        calendarTable.delegate = self
        calendarTable.dataSource = self
        calendar.delegate = self
        calendar.dataSource = self
        fetchCalenderConsultations()
        calendar.placeholderType = .none
        calendar.clipsToBounds = true
        let now = Date()
        currentsMonth = getMonth(date: now)
        currentsYear = getYear(date: now)

        
        if UIDevice.current.model.hasPrefix("iPad") {
            self.calendarHeightConstraint.constant = 400
        }
        
       self.view.addGestureRecognizer(self.scopeGesture)
              self.calendarTable.panGestureRecognizer.require(toFail: self.scopeGesture)
              self.calendar.scope = .week
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        calendar.reloadData()
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.calendarTable.contentOffset.y <= -self.calendarTable.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
    
    
    
    func checkDatas() {
        if recents.isEmpty {
            calendarTable.isHidden = true
            nothingToShowLabel.isHidden = false
        }
        else {
            calendarTable.isHidden = false
            nothingToShowLabel.isHidden = true
            DispatchQueue.main.async {
                self.calendarTable.reloadData()
            }
        }
    }
    func checkDatas2() {
        if posts.isEmpty {
            calendarTable.isHidden = true
            nothingToShowLabel.isHidden = false
        }
        else {
            calendarTable.isHidden = false
            nothingToShowLabel.isHidden = true
            DispatchQueue.main.async {
                self.calendarTable.reloadData()
            }
        }
    }
    
    func getMonth(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: date)
        return nameOfMonth
    }
    func getYear(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let nameOfYear = dateFormatter.string(from: date)
        return nameOfYear
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
                    data.year = self.getYear(date: dateFromString)
                    tempfact.append(data)
                }
                self.datas = tempfact
                print(self.stringDates)
            } catch let parsingError {
                print("Error", parsingError)
            }
            DispatchQueue.main.async {
                for a in self.datas {
                    if a.month == self.currentsMonth && a.year == self.currentsYear {
                        DispatchQueue.main.async {
                            print(self.currentsMonth! + " " + a.month!)
                            self.calendarTable.isHidden = true
                            self.definite = true
                            self.currentMonth.append(a)
                            self.calendarTable.reloadData()
                            self.nothingToShowLabel.isHidden = false
                            print(self.currentMonth.count)
                        }
                    }
                    else {
                        self.nothingToShowLabel.text = "No Consultations for this month."
                        self.nothingToShowLabel.isHidden = false
                        self.definite = false
                        self.calendarTable.isHidden = true
                    }
                }
                self.calendarTable.reloadData()
                self.calendar.reloadData()
            }
        }
        task.resume()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calenderToMore" {
            let indexPath = sender as! IndexPath
            let consultsDetailView = segue.destination as? MoreDetailsViewController
            
            if definite == false {
            if state == false {
                consultsDetailView?.t = false
                let selectedRow = datas[indexPath.section]
                consultsDetailView?.incoming_id = selectedRow.consultation_id
                consultsDetailView?.topicTitle = selectedRow.topic
                consultsDetailView?.duration = selectedRow.period
                consultsDetailView?.details = selectedRow.description
                consultsDetailView?.institutionName = selectedRow.institution
                consultsDetailView?.srtDate = selectedRow.start_date
                consultsDetailView?.postedDate = selectedRow.created_on
                consultsDetailView?.endDate = selectedRow.end_date
//                consultsDetailView?.daysLeft = self.datas[indexPath.section].period
//                consultsDetailView?.details = self.datas[indexPath.section].description
//                consultsDetailView?.institutionName = self.datas[indexPath.section].institution
//                consultsDetailView?.topicTitle = self.datas[indexPath.section].topic
//                consultsDetailView?.srtDate = self.datas[indexPath.section].start_date
//                consultsDetailView?.postedDate = self.datas[indexPath.section].created_on
            }
            else if state == true {
                let selectedRow = posts[indexPath.section]
                consultsDetailView?.t = true
                consultsDetailView?.incoming_id = selectedRow.consultation_id
                consultsDetailView?.topicTitle = selectedRow.topic
                consultsDetailView?.duration = selectedRow.period
                consultsDetailView?.details = selectedRow.description
                consultsDetailView?.institutionName = selectedRow.institution
                consultsDetailView?.srtDate = selectedRow.start_date
                consultsDetailView?.postedDate = selectedRow.created_on
                consultsDetailView?.endDate = selectedRow.end_date
//                consultsDetailView?.daysLeft = self.posts[indexPath.section].period
//                consultsDetailView?.details = self.posts[indexPath.section].description
//                consultsDetailView?.institutionName = self.posts[indexPath.section].institution
//                consultsDetailView?.topicTitle = self.posts[indexPath.section].topic
//                consultsDetailView?.srtDate = self.posts[indexPath.section].start_date
//                consultsDetailView?.postedDate = self.posts[indexPath.section].created_on
            }
            }
            else {
                consultsDetailView?.t = true
                let selectedRow = currentMonth[indexPath.section]
                consultsDetailView?.incoming_id = selectedRow.consultation_id
                consultsDetailView?.topicTitle = selectedRow.topic
                consultsDetailView?.duration = selectedRow.period
                consultsDetailView?.details = selectedRow.description
                consultsDetailView?.institutionName = selectedRow.institution
                consultsDetailView?.srtDate = selectedRow.start_date
                consultsDetailView?.postedDate = selectedRow.created_on
                consultsDetailView?.endDate = selectedRow.end_date
//                consultsDetailView?.daysLeft = self.currentMonth[indexPath.section].period
//                consultsDetailView?.details = self.currentMonth[indexPath.section].description
//                consultsDetailView?.institutionName = self.currentMonth[indexPath.section].institution
//                consultsDetailView?.topicTitle = self.currentMonth[indexPath.section].topic
//                consultsDetailView?.srtDate = self.currentMonth[indexPath.section].start_date
//                consultsDetailView?.postedDate = self.currentMonth[indexPath.section].created_on
            }
//            let selectedRow = datas[indexPath.section]
//
//            consultsDetailView?.t = false
//            consultsDetailView?.incoming_id = selectedRow.consultation_id
//            consultsDetailView?.topicTitle = selectedRow.topic
//            consultsDetailView?.duration = selectedRow.period
//            consultsDetailView?.details = selectedRow.description
//            consultsDetailView?.institutionName = selectedRow.institution
//            consultsDetailView?.srtDate = selectedRow.start_date
//            consultsDetailView?.postedDate = selectedRow.created_on
//            consultsDetailView?.endDate = selectedRow.end_date
        }
    }
    

}


extension CalanderdViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let post = datas[indexPath.section]
        var post = Consultations()
        if definite == false {
        if state == false {
            post = datas[indexPath.section]
        }
        else if state == true {
            print(state)
            post = posts[indexPath.section]
        }
        }
        else {
            post = currentMonth[indexPath.section]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConsultCell") as! PagesTableViewCell
        cell.setData(post: post)
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 2
        cell.layer.borderWidth = 2
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.selectionStyle = .none
        cell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "calenderToMore", sender: indexPath)
        }
    }
}



extension CalanderdViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let key = self.dateFormatter2.string(from: date)
        
        
        for data in datas {
            if (data.created_on?.contains(key))! {
                DispatchQueue.main.async {
                    self.state = true
                    self.definite = false
                    self.posts = []
                    self.posts.append(data)
                    self.nothingToShowLabel.isHidden = true
                    self.calendarTable.isHidden = false
                    self.calendarTable.reloadData()
                }
            }
            else{
                self.nothingToShowLabel.isHidden = false
                self.nothingToShowLabel.text = "No Consultations for this date."
                self.state = false
                self.calendarTable.isHidden = true
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
//        print(vals)
        let date = dateFormatter2.date(from:vals)!
        let month = getMonth(date: date)
        let year = getYear(date: date)
        self.currentMonth = []
        for a in datas {
            if a.month == month && a.year == year {
                DispatchQueue.main.async {
                    print(month + " " + a.month!)
                    self.calendarTable.isHidden = false
                    self.definite = true
                    self.currentMonth.append(a)
                    self.calendarTable.reloadData()
                    self.nothingToShowLabel.isHidden = true
                    print(self.currentMonth.count)
                }
            }
            else {
                self.nothingToShowLabel.isHidden = false
                self.nothingToShowLabel.text = "No Consultations for this month."
                self.definite = false
                self.calendarTable.isHidden = true
            }
        }
        calendarTable.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter1.string(from: date)
        if self.stringDates.contains(dateString) {
            return 1
        }
        return 0
    }
    
    
}

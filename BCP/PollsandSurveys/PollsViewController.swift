//
//  PollsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 13/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class PollsViewController: UIViewController {
	@IBOutlet weak var pollsTableView: UITableView!
	
	var polls: [PollData] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

        pollsTableView.dataSource = self
		pollsTableView.delegate = self
		polls = createArray2()
    }

	func createArray2() -> [PollData] {
		var tempData: [PollData] = []
		
		let data1 = PollData(pollCategory: "Education", pollTitle: "3 years university", pollQustionsNumber: "10 Questions")
		let data2 = PollData(pollCategory: "Sports", pollTitle: "3 years university", pollQustionsNumber: "05 Questions")
		let data3 = PollData(pollCategory: "Education", pollTitle: "3 years university", pollQustionsNumber: "15 Questions")
		
		tempData.append(data1)
		tempData.append(data2)
		tempData.append(data3)
		return tempData
	}
}


extension PollsViewController: UITableViewDelegate,UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return polls.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let poll = polls[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "PollCell") as! PandSTableViewCell
		cell.setData(poll: poll)
		return cell
	}
	
	
}

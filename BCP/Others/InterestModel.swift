//
//  InterestModel.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 01/03/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import Foundation
import UIKit

struct InterestModel {
	var interest: String
}


class ViewInterestItem {
	private var item: InterestModel
	var isSelected = false
	var title: String {
		return item.interest
	}
	init(item: InterestModel) {
		self.item = item
	}
}
let dataArray = [InterestModel(interest: "Swift"),
				 InterestModel(interest: "Java"),
				 InterestModel(interest: "Kotlin"),
				 InterestModel(interest: "Python"),
				 InterestModel(interest: "Ruby")]

class ViewInterests {
	var items = [ViewInterestItem]()
	init() {
		items = dataArray.map { ViewInterestItem(item: $0) }
	}
}


//extension ViewInterests: UITableViewDataSource{
//	
//	
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return items.count  // (1)
//	}
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? LoginInterestTableViewCell {
//			cell.item = items[indexPath.row] // (2)
//			// select/deselect the cell
//			if items[indexPath.row].isSelected {
//				tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none) // (3)
//			} else {
//				tableView.deselectRow(at: indexPath, animated: false) // (4)
//			}
//			return cell
//		}
//		return UITableViewCell()
//	}
//}

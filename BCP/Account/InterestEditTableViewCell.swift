//
//  InterestTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 24/04/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

//protocol InterestEditDelegate {
//	func getStatus()
//}

protocol SettingCellDelegate : class {
	func didChangeSwitchState(sender: InterestEditTableViewCell, isOn: Bool)
}

class InterestEditTableViewCell: UITableViewCell {

	
	
	var interests: AllInterest? {
		didSet {
			interestNameLabel.text = interests?.interest_name
//			if interests?.person_interest != nil || sl != "" {
//				if interests?.person_interest != nil {
//				let stringLong = interests?.person_interest!
//					guard let a = interests?.interest_id else {return}
//					//				guard let b = e else {return}
//					if (stringLong?.contains(a))! || sl.contains(a) {
//						interestSwitch.isOn = true
//						print(sl)
////						sl = ""
//					} else {
//						interestSwitch.isOn = false
//						print("aa\(sl)")
//					}
//				}
//			} else {
//				interestSwitch.isOn = false
//				print("abba\(sl)")
			}
		}
		
//	}
	
	
	@IBOutlet weak var interestNameLabel: UILabel!
	@IBOutlet weak var interestSwitch: UISwitch!
	weak var cellDelegate: SettingCellDelegate?
	
	var cellId = ""
	var e = ""
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

		
//		if selected {
//			accessoryType = .checkmark
//		} else {
//			accessoryType = .none
//		}
        // Configure the view for the selected state
    }
	@IBAction func cellStateChanged(_ sender: UISwitch) {
		let index = sender.tag
		print(index)
//		self.interests?.person_interest?.append(contentsOf: (interests?.interest_id!)!)
		self.cellDelegate?.didChangeSwitchState(sender: self, isOn:interestSwitch.isOn)
//		print(self.interests?.person_interest)
	}
	
	
	
}


class customSwitchState {
	var id: String!
	var switchState: Bool = false
	var labelText: String!
}

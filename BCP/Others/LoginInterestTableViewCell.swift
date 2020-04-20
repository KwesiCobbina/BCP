//
//  LoginInterestTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 01/03/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class LoginInterestTableViewCell: UITableViewCell {

	@IBOutlet weak var interestLabel: UILabel!
	
	var item: ViewInterestItem? {
		didSet {
		interestLabel.text = item?.title
		}
		
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		selectionStyle = .none
		
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

		accessoryType = selected ? .checkmark : .none
        // Configure the view for the selected state
    }

}

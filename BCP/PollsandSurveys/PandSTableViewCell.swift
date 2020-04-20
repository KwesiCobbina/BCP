//
//  PandSTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 13/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class PandSTableViewCell: UITableViewCell {

	@IBOutlet weak var pollTitleLabel: UILabel!
	@IBOutlet weak var pollCatLabel: UILabel!
	@IBOutlet weak var noOfQuestionsLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	func setData(poll: PollData) {
		pollCatLabel.text = poll.pollCategory
		pollTitleLabel.text = poll.pollTitle
		noOfQuestionsLabel.text = poll.pollQustionsNumber
	}
}

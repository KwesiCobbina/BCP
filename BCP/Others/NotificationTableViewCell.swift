//
//  NotificationTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 13/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

	@IBOutlet weak var daysLabel: UILabel!
	@IBOutlet weak var titleLable: UILabel!
	@IBOutlet weak var organisationLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


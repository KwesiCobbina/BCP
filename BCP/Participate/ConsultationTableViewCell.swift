//
//  ConsultationTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 06/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class ConsultationTableViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var institutionName: UILabel!
	@IBOutlet weak var daysLeftLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	func setPost(post: BasicPost) {
		daysLeftLabel.text = post.daysLeft
		institutionName.text = post.organisationName
		titleLabel.text = post.postTitle
	}
	
	
}

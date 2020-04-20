//
//  HomeTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 08/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

	@IBOutlet weak var homeTitleLabel: UILabel!
	@IBOutlet weak var homeOrganisationLabel: UILabel!
	@IBOutlet weak var homeDateLabel: UILabel!
	@IBOutlet weak var homePostLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	func setPost(post: HomePost) {
		homeDateLabel.text = post.daysLeft
		homeOrganisationLabel.text = post.organisationName
		homeTitleLabel.text = post.postTitle
		homePostLabel.text = post.postDetails
	}

}

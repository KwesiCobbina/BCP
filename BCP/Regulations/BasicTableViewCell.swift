//
//  BasicTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 02/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class BasicTableViewCell: UITableViewCell {

	@IBOutlet weak var daysLeftLabel: UILabel!
	@IBOutlet weak var postTitleLabel: UILabel!
	@IBOutlet weak var organisationNameLabel: UILabel!
	@IBOutlet weak var postDetailsTextView: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	func setPost(post: Read) {
		organisationNameLabel.text = post.interest_name
		postTitleLabel.text = post.policy_title
//		postDetailsTextView.text = post.postDetails
	}

	@IBAction func likeButtonClicked(_ sender: UIButton) {
	}
	@IBAction func laterButtonClicked(_ sender: UIButton) {
	}
	@IBAction func commentButtonClicked(_ sender: Any) {
	}
	
}

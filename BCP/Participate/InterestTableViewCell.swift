//
//  InterestTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 13/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class InterestTableViewCell: UITableViewCell {
		
		
		@IBOutlet weak var durationLabel: UILabel!
		@IBOutlet weak var titleLabel: UILabel!
		@IBOutlet weak var institutionNameLabel: UILabel!
		@IBOutlet weak var daysLaefLabel: UILabel!
		override func awakeFromNib() {
			super.awakeFromNib()
			// Initialization code
		}
		
		func setData(post: PagesData) {
			daysLaefLabel.text = post.daysLeft
			institutionNameLabel.text = post.organisationName
			titleLabel.text = post.postTitle
			durationLabel.text = post.postDuration
		}
		
		
		@IBAction func AddButtonClicked(_ sender: UIButton) {
		}
		
}




class ClosedTableViewCell: UITableViewCell {
	
	
	@IBOutlet weak var durationLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var institutionNameLabel: UILabel!
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	func setData(post: PagesData) {
		institutionNameLabel.text = post.organisationName
		titleLabel.text = post.postTitle
		durationLabel.text = post.postDuration
}
}

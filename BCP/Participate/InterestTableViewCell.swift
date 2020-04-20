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
		@IBOutlet weak var descriptionLabel: UILabel!
		@IBOutlet weak var addBtn: UIButton!
		override func awakeFromNib() {
			super.awakeFromNib()
			// Initialization code
		}
		
		func setData(post: Interest) {
//			daysLaefLabel.text = post.period
//			institutionNameLabel.text = post.institution
			titleLabel.text = post.topic
			durationLabel.text = post.start_date! + " - " + post.end_date!
			descriptionLabel.text = post.description
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
	
	func setData(post: Consultations) {
		institutionNameLabel.text = post.institution
		titleLabel.text = post.topic
		durationLabel.text = post.period
}
}

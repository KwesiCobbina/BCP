//
//  PagesTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 07/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit


protocol PagesTableViewCellDelegate {
	
//	func didTapAdd(for post: PagesTableViewCell)
	func didTapAdd(post: PagesTableViewCell)
	
}


class PagesTableViewCell: UITableViewCell {

	var delegate: PagesTableViewCellDelegate?
	var consultation: Consultations?
	
	@IBOutlet weak var durationLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var institutionNameLabel: UILabel!
	@IBOutlet weak var daysLaefLabel: UILabel!
	@IBOutlet weak var postDetailsLabel: UILabel!
	@IBOutlet weak var addBtn: UIButton!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	func setData(post: Consultations) {
		titleLabel.text = post.topic!
		postDetailsLabel.text = post.description!
		durationLabel.text = post.start_date! + " - " + post.end_date!
	}
	
	
	
	@IBAction func AddButtonClicked(_ sender: UIButton) {
		
		delegate?.didTapAdd(post: self)
//		print(consultation?.consultation_id)
	}
	
}

//
//  SayTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 17/04/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit



class SayTableViewCell: UITableViewCell {

	@IBOutlet weak var topicLabel: UILabel!
	@IBOutlet weak var interestLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	
	

}

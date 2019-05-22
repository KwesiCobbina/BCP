//
//  DocumentTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 21/05/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class DocumentTableViewCell: UITableViewCell {

	@IBOutlet weak var docTitleLabel: UILabel!
	@IBOutlet weak var docIcon: UIImageView!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

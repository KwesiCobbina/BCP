//
//  DiscussionTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 11/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class DiscussionTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var numberOfTopicsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCategory(cat: Category){
        categoryLabel.text = cat.policy_type
        numberOfTopicsLabel.text = cat.total_topics
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

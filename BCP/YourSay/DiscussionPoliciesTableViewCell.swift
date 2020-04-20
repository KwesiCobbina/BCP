//
//  DiscussionPoliciesTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 11/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class DiscussionPoliciesTableViewCell: UITableViewCell {

    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setTopic(topic: Topics){
        topicLabel.text = topic.topic
        categoryLabel.text = topic.category
        interestLabel.text = topic.interest
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

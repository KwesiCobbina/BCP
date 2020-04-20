//
//  ClosedConsultTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 10/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class ClosedConsultTableViewCell: UITableViewCell {

    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var consultDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(post: Consultations) {
        durationLabel.text = post.start_date! + " - " + post.end_date!
        titleLabel.text = post.topic!
        periodLabel.text = post.period!
        consultDesc.text = post.description!
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  RegulationsTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 03/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class RegulationsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var regulationTitleLabel: UILabel!
    @IBOutlet weak var sectorLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var gazetteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setRegulation(reg: Regulation){
        self.sectorLabel.text = reg.sector_name
        self.subjectLabel.text = reg.subject_name
        self.gazetteLabel.text = reg.regulation_gazette_date
        self.regulationTitleLabel.text = reg.regulation_title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

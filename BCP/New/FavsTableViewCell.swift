//
//  FavsTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 21/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class FavsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setfav(clause: FavoritedClause){
        titleLbl.text = clause.clause_title
        detailsLbl.text = clause.clause_summary
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

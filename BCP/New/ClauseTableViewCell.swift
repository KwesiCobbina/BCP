//
//  ClauseTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 10/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class ClauseTableViewCell: UITableViewCell {

    @IBOutlet weak var clauseLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setClause(clause: Clause){
        if clause.clause_details != nil {
            clauseLabel.text = clause.clause_details?.htmlToString
//            let myStr = NSMutableAttributedString(attributedString: NSAttributedString(string: "Section "))
//            myStr.append(clause.clause_id!.htmlToAttributedString!)
//            myStr.append(NSAttributedString(string: ": "))
//            myStr.append(clause.clause_details!.htmlToAttributedString!)
//            clauseLabel.attributedText = myStr
//            clauseLabel.attributedText = NSAttributedString(string: "Section ") + clause.clause_id!.htmlToAttributedString! + NSAttributedString(string: ": ") + clause.clause_details!.htmlToAttributedString!
        }
        else{
            clauseLabel.text = "null"
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

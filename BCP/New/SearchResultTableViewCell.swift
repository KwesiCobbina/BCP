//
//  SearchResultTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 28/02/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var regulationTitle: UILabel!
    @IBOutlet weak var regulationIntro: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setSearch(search: SearchResults) {
        regulationTitle.text = search.regulation_title?.htmlToString
        regulationIntro.text = search.regulation_introduction?.htmlToString
        regulationIntro.numberOfLines = 5
    }

}

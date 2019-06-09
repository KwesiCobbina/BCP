//
//  DocumentTableViewCell.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 21/05/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

protocol DocumentTableViewCellDelegate {
	func didHitDownload(for Doc: DocumentTableViewCell)
	func didHitOpen(for Doc: DocumentTableViewCell)
}

class DocumentTableViewCell: UITableViewCell {

	@IBOutlet weak var docTitleLabel: UILabel!
	@IBOutlet weak var docIcon: UIImageView!
	@IBOutlet weak var downloadProgressBar: UIProgressView!
	var link: String?
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	var delegate: DocumentTableViewCellDelegate?

	@IBAction func openDocument(_ sender: UIButton) {
		delegate?.didHitOpen(for: self)
	}
	
	@IBAction func downloadDocument(_ sender: UIButton) {
		delegate?.didHitDownload(for: self)
	}
}

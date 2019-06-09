//
//  MoreDetailsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 06/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class MoreDetailsViewController: UIViewController {


	@IBOutlet weak var detailsInfoLabel: UILabel!
	@IBOutlet weak var topicLabel: UILabel!
	@IBOutlet weak var institutionLabel: UILabel!
	@IBOutlet weak var startDate: UILabel!
	@IBOutlet weak var postDate: UILabel!
	@IBOutlet weak var dulationLabel: UILabel!
	@IBOutlet weak var daysLeftLabel: UILabel!
	@IBOutlet weak var submitButton: UIButton!
	@IBOutlet weak var shareButton: UIButton!
	@IBOutlet weak var dismissButton: UIButton!
	@IBOutlet weak var commentTextBox: UITextView!
	
	
	var topicTitle: String?
	var institutionName: String?
	var daysLeft: String?
	var details: String?
	var postedDate: String?
	var srtDate: String?
	var duration: String?
	
	var t: Bool?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if t == true {
			dismissButton.isHidden = true
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		topicLabel.text = topicTitle
		institutionLabel.text = institutionName
		dulationLabel.text = daysLeft
		daysLeftLabel.text = daysLeft
		detailsInfoLabel.text = details
		startDate.text = srtDate
		dulationLabel.text = duration
		let dateString = postedDate
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		let dateFromString = dateFormatter.date(from: dateString!)
		let dateFormatter2 = DateFormatter()
		dateFormatter2.dateFormat = "MMMM dd, yyyy"
		let stringFromDate = dateFormatter2.string(from: dateFromString!)
		postDate.text = stringFromDate
	}
	
	@IBAction func submitClicked(_ sender: UIButton) {
		if commentTextBox.text != "" || commentTextBox.text != "Enter Comment Here" {
			
		}
		
	}
	
	@IBAction func dismissVIew(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		dismissButton.isHidden = t ?? true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		dismissButton.isHidden = true
	}
}


extension MoreDetailsViewController: UIScrollViewDelegate {
}




extension UILabel {
	
	func retrieveTextHeight () -> CGFloat {
		let attributedText = NSAttributedString(string: self.text!, attributes: [NSAttributedString.Key.font:self.font])
		
		let rect = attributedText.boundingRect(with: CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
		
		return ceil(rect.size.height)
	}
	
}

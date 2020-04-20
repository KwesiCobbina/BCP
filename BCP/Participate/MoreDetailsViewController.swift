//
//  MoreDetailsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 06/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class MoreDetailsViewController: UIViewController, UITextViewDelegate {


	@IBOutlet weak var detailsInfoLabel: UILabel!
	@IBOutlet weak var topicLabel: UILabel!
	@IBOutlet weak var institutionLabel: UILabel!
	@IBOutlet weak var startDate: UILabel!
	@IBOutlet weak var postDate: UILabel!
	@IBOutlet weak var durationLabel: UILabel!
	@IBOutlet weak var daysLeftLabel: UILabel!
	@IBOutlet weak var submitButton: UIButton!
	@IBOutlet weak var commentButton: UIButton!
	@IBOutlet weak var dismissButton: UIButton!
	@IBOutlet weak var commentLabel: UILabel!
	@IBOutlet weak var detailsLabelHeight: NSLayoutConstraint!
	@IBOutlet weak var detailsInfoTextBox: UITextView!
    @IBOutlet weak var timeFrameLabel: UILabel!
	
    var selectedRecent:Recents?
	var topicTitle: String?
	var institutionName: String?
	var daysLeft: String?
	var details: String?
	var postedDate: String?
	var srtDate: String?
	var duration: String?
    var endDate: String?
    var incoming_id: String?
	var t: Bool?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if t == true {
//			dismissButton.isHidden = true
            commentLabel.isHidden = true
            commentButton.isHidden = true
		}
        else {
            commentLabel.isHidden = false
            commentButton.isHidden = false
        }
		
	}
	
	func textViewDidChange(_ textView: UITextView) {
		if detailsInfoTextBox.contentSize.height >= 300 {
			detailsInfoTextBox.isScrollEnabled = true
		} else {
			detailsInfoTextBox.frame.size.height = detailsInfoTextBox.contentSize.height
			detailsInfoTextBox.isScrollEnabled = false
		}
	}

	
	override func viewDidAppear(_ animated: Bool) {
        topicLabel.text = topicTitle
        institutionLabel.text = institutionName
        detailsInfoLabel.text = details?.htmlToString
        startDate.text = srtDate
        durationLabel.text = duration
        postDate.text = endDate
        timeFrameLabel.text = srtDate! + " - " + endDate!


	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsToComment"{
            let commentView = segue.destination as? CommentViewController
            commentView?.needed_id = incoming_id
        }
    }
	
	
	@IBAction func shareClicked(_ sender: UIButton) {
		let text = "This is the text...."
		let myWebsite = NSURL(string:"http://www.Index-holdings.com")
		let shareAll = [topicTitle, institutionName, details, "Starts on \(srtDate!) and lasts for \(daysLeft!)", myWebsite!] as [Any]
		let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
		activityViewController.popoverPresentationController?.sourceView = self.view
		self.present(activityViewController, animated: true, completion: nil)
	}
	
	@IBAction func dismissVIew(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
	
	
	override func viewWillDisappear(_ animated: Bool) {
//		dismissButton.isHidden = true
	}
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
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


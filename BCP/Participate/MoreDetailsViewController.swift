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
	@IBOutlet weak var detailsLabelHeight: NSLayoutConstraint!
	
	
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
//		let h = details?.height(withConstrainedWidth: self.view.frame.width, font: .systemFont(ofSize: 15))
//		detailsLabelHeight = h
//		detailsInfoLabel.heightAnchor.constraint(equalToConstant: h!).isActive = true
		detailsInfoLabel.text = details
		startDate.text = srtDate
		dulationLabel.text = duration
		let dateString = postedDate
		self.detailsInfoLabel.sizeToFit()
//		print(details)
//		print( h!)
		
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
			let useDefaults = UserDefaults.standard
			guard let forum_id = useDefaults.string(forKey: "forum_id") else {return}
			guard let BCP_userID = useDefaults.string(forKey: "userID") else {return}
			guard let BCP_userType = useDefaults.string(forKey: "userType") else {return}
			print(BCP_userID)
			
			let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_consultation_comment.php")
			var request = URLRequest(url: url!)
			request.httpMethod = "POST"
			
			let params = "forum_id=\(String(describing: forum_id))&BCP_userID=\(BCP_userID)&BCP_userType=\(BCP_userType)&message=\(commentTextBox.text!)"
			request.httpBody = params.data(using: String.Encoding.utf8)
			
			let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
				if error != nil {
					print(error?.localizedDescription as Any)
					return
				} else {
					let httpResponse = response as? HTTPURLResponse
					if httpResponse?.statusCode == 200 {
//						self.fetchComments()
					}
					else {
						print("sorry there was a proplem here")
					}
				}
			}
			task.resume()
//			self.commentTextField.text = ""
//			self.commentTextField.placeholder = "Enter Comment..."
//		}
		}
	}
	
	@IBAction func shareClicked(_ sender: UIButton) {
		let text = "This is the text...."
//		let image = UIImage(named: "Product")
		let myWebsite = NSURL(string:"http://www.Index-holdings.com")
//		let shareAll = [text , myWebsite!] as [Any]
		let shareAll = [topicTitle, institutionName, details, "Starts on \(srtDate!) and lasts for \(daysLeft!)", myWebsite!] as [Any]
		let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
		activityViewController.popoverPresentationController?.sourceView = self.view
		self.present(activityViewController, animated: true, completion: nil)
	}
	
	@IBAction func dismissVIew(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
	
//	override func viewWillAppear(_ animated: Bool) {
//		dismissButton.isHidden = t ?? true
//	}
	
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

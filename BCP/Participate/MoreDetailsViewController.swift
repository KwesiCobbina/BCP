//
//  MoreDetailsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 06/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class MoreDetailsViewController: UIViewController {

	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var contentView:UIView!
	@IBOutlet weak var detailsLabel: UILabel!
	@IBOutlet weak var detailsInfoLabel: UILabel!
	@IBOutlet weak var datesView1: UILabel!
	@IBOutlet weak var datesView2: UILabel!
	@IBOutlet weak var datesView3: UILabel!
	@IBOutlet weak var datesView4: UILabel!
	@IBOutlet weak var timeView1: UILabel!
	@IBOutlet weak var timeView2: UILabel!
	@IBOutlet weak var timeView3: UILabel!
	@IBOutlet weak var timeView4: UILabel!
	@IBOutlet weak var ycLabel: UILabel!
	@IBOutlet weak var ycInfoLabel: UILabel!
	@IBOutlet weak var ft1: UITextField!
	@IBOutlet weak var tf2: UITextField!
	@IBOutlet weak var sexLabel: UILabel!
	@IBOutlet weak var sexSegControl: UISegmentedControl!
	@IBOutlet weak var tf3: UITextField!
	@IBOutlet weak var tf4: UITextField!
	@IBOutlet weak var tf5: UITextField!
	@IBOutlet weak var tf6: UITextField!
	@IBOutlet weak var tf7: UITextField!
	@IBOutlet weak var tf9: UITextField!
	@IBOutlet weak var confLabel: UILabel!
	@IBOutlet weak var confSegControl: UISegmentedControl!
	@IBOutlet weak var submitButton: UIButton!
	@IBOutlet weak var shareButton: UIButton!
	@IBOutlet weak var dismissButton: UIButton!
	
	
	var topicTitle: String?
	var institutionName: String?
	var daysLeft: String?
	var details: String?
	var t: Bool?
	
    override func viewDidLoad() {
        super.viewDidLoad()


	}
	@IBAction func submitClicked(_ sender: UIButton) {
	}
	@IBAction func dismissVIew(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		dismissButton.isHidden = t ?? false
	}
	
}

extension MoreDetailsViewController: UIScrollViewDelegate {
}



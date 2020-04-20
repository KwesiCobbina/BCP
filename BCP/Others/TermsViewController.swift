//
//  TermsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 03/07/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import WebKit

class TermsViewController: UIViewController, WKNavigationDelegate {

	@IBOutlet weak var termsWebView: WKWebView!
	@IBOutlet weak var doneBtn: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		termsWebView.navigationDelegate = self
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		let url = URL(string: "\(AppConstants.sharedInstance.licencesURL)terms.html")!
		termsWebView.load(URLRequest(url: url))
	}
	
	@IBAction func donePressed(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		doneBtn.isHidden = false
	}

}

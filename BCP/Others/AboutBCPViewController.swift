//
//  AboutBCPViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 03/07/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import WebKit

class AboutBCPViewController: UIViewController, WKNavigationDelegate {

	@IBOutlet weak var aboutBCPWebView: WKWebView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		aboutBCPWebView.navigationDelegate = self
    }
    

	override func viewWillAppear(_ animated: Bool) {
		let url = URL(string: "\(AppConstants.sharedInstance.licencesURL)about.html")!
		aboutBCPWebView.load(URLRequest(url: url))
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
	}
	

}

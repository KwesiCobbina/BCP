//
//  FAQsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 22/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import WebKit

class FAQsViewController: UIViewController, WKNavigationDelegate {
	
	@IBOutlet weak var faqsWebView: WKWebView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		faqsWebView.navigationDelegate = self
    }
	
	override func viewWillAppear(_ animated: Bool) {
		let url = URL(string: "https://bcp.gov.gh/faq?faq=MQ==")!
		faqsWebView.load(URLRequest(url: url))
	}

}

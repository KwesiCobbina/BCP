//
//  WebTestViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 30/03/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import WebKit
//import PDFKit

class WebTestViewController: UIViewController, WKNavigationDelegate {

	@IBOutlet weak var webViewTest: WKWebView!
	override func viewDidLoad() {
        super.viewDidLoad()

		let url = URL(string: "http://index-holdings.com/bcp/read?read=Mg==")!
		webViewTest.load(URLRequest(url: url))
		
		let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webViewTest, action: #selector(webViewTest.reload))

		self.navigationItem.rightBarButtonItem = refresh
		self.navigationController?.title = "Policies"
    }
	
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		title = webViewTest.title
	}
	
	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
		decisionHandler(.allow)
	}
	
	func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
		decisionHandler(.allow)
	}
	

}

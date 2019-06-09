//
//  MoreOnPolicyViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 20/04/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class MoreOnPolicyViewController: UIViewController {

	
	var policy_id = ""
	
    override func viewDidLoad() {
        super.viewDidLoad()

		print(policy_id)
        // Do any additional setup after loading the view.
		fetchMore()
    }
    

	func fetchMore() {
//		var tempInterests: [Read] = []
//		let menu_id = "5"
		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_read_policy_details.php")
		var request = URLRequest(url: url!)
		request.httpMethod = "POST"
		
		
		let params = "policy_id=\(policy_id)"
		request.httpBody = params.data(using: String.Encoding.utf8)
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard let dataResponse = data,
				error == nil else {
					print(error?.localizedDescription ?? "Response Error")
					return }
			do{
				print(response)
				let info = try JSONDecoder().decode(PolicyInfo.self, from: dataResponse)
				
//				for data in countries {
//					tempInterests.append(data)
//					print(data)
//				}
//				self.posts = []
//				self.posts = tempInterests
				
				
				
			} catch let parsingError {
				print("Error", parsingError)
			}
//			DispatchQueue.main.async {
//				self.homeTableView.reloadData()
//			}
		}
		task.resume()
	}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	@IBAction func dismissClicked(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
	
}

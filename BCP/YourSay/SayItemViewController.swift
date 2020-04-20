//
//  SayItemViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 30/04/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class SayItemViewController: UIViewController {

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var numberOfComments: UILabel!
	@IBOutlet weak var createdOnLabel: UILabel!
	@IBOutlet weak var closingLabel: UILabel!
	var post = Forum()
	var datas: [Forum] = []
	var mainPost = Forum()
	var comments: [Forum] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

//		let useDefaults = UserDefaults.standard
		fetchSayDetails()
//		let forum_id = useDefaults.object(forKey: "forum_id")
//		let f1 = useDefaults.string(forKey: "forum_id")
//		print(f1!)
    }
	
	func fetchSayDetails() {
		var tempfact: [Forum] = []
		
		let useDefaults = UserDefaults.standard
		let forum_id = useDefaults.string(forKey: "forum_id")
		let url = URL(string: "\(AppConstants.sharedInstance.devURL)bcp_discussion_view_reply.php")
		var request = URLRequest(url: url!)
		request.httpMethod = "POST"
		
		
		let params = "forum_id=\(forum_id!)"
		request.httpBody = params.data(using: String.Encoding.utf8)
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard let dataResponse = data,
				error == nil else {
					print(error?.localizedDescription ?? "Response Error")
					return }
			do{
				
				let countries = try JSONDecoder().decode([Forum].self, from: dataResponse)
				
				for data in countries {
					tempfact.append(data)
					//					print(data)
				}
				self.datas = []
				self.datas = tempfact
				self.mainPost = self.datas.first!
				//				self.datas.removeFirst()
				//				self.comments = self.datas
				
				
				
			} catch let parsingError {
				print("Error", parsingError)
			}
			DispatchQueue.main.async {
				print(self.datas.count)
				self.nameLabel.text = self.mainPost.created_by ?? "System User"
				self.numberOfComments.text = self.mainPost.total_comments
				self.createdOnLabel.text = self.mainPost.start_date
				self.closingLabel.text = self.mainPost.end_date
				self.descriptionLabel.text = self.mainPost.description
			}
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

}

//
//  CommentsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 30/04/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var commentsTableView: UITableView!
	var datas: [Forum] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

		commentsTableView.delegate = self
		commentsTableView.dataSource = self
		commentsTableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
		commentsTableView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -100, right: 0)
		fetchComments()
		commentTextField.delegate = self
    }
	

	
	func fetchComments() {
		var tempfact: [Forum] = []
		
		let useDefaults = UserDefaults.standard
		let forum_id = useDefaults.string(forKey: "forum_id")
		//		let forum_id = "1"
		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_discussion_view_reply.php")
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
				}
				self.datas = []
				self.datas = tempfact
				self.datas.removeFirst()
				
			} catch let parsingError {
				print("Error", parsingError)
			}
			DispatchQueue.main.async {
				self.commentsTableView.reloadData()
			
			}
		}
		task.resume()
	}

	
	lazy var containerView: UIView = {
		let container = UIView()
		container.backgroundColor = .white
		container.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
		container.translatesAutoresizingMaskIntoConstraints = false
		container.addSubview(self.commentTextField)
		self.commentTextField.topAnchor.constraint(equalTo: container.topAnchor, constant: 8).isActive = true
		self.commentTextField.leftAnchor.constraint(equalTo: container.leftAnchor).isActive = true
		self.commentTextField.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -70).isActive = true

		let submitBtn = UIButton(type: .system)
		submitBtn.setTitle("Send", for: .normal)
		submitBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
		submitBtn.translatesAutoresizingMaskIntoConstraints = false
		submitBtn.addTarget(self, action: #selector(handleSendComment), for: .touchUpInside)
		container.addSubview(submitBtn)
		submitBtn.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
		submitBtn.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -12).isActive = true
		submitBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
		return container
	}()
//
	let commentTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Enter Comment..."
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	
	@objc func handleSendComment(){
		if commentTextField.text == "" {
			print("nothing to send")
		} else {
			let useDefaults = UserDefaults.standard
			guard let forum_id = useDefaults.string(forKey: "forum_id") else {return}
			guard let BCP_userID = useDefaults.string(forKey: "userID") else {return}
			guard let BCP_userType = useDefaults.string(forKey: "userType") else {return}
			print(BCP_userID)

			let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_publish_forum_comment.php")
			var request = URLRequest(url: url!)
			request.httpMethod = "POST"

			let params = "forum_id=\(String(describing: forum_id))&BCP_userID=\(BCP_userID)&BCP_userType=\(BCP_userType)&message=\(commentTextField.text!)"
			request.httpBody = params.data(using: String.Encoding.utf8)
			
			let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
				if error != nil {
					print(error?.localizedDescription as Any)
					return
				} else {
					let httpResponse = response as? HTTPURLResponse
					if httpResponse?.statusCode == 200 {
						self.fetchComments()
					}
					else {
						print("sorry there was a proplem here")
					}
				}
			}
			task.resume()
			self.commentTextField.text = ""
			self.commentTextField.placeholder = "Enter Comment..."
		}
	}
	
	override var inputAccessoryView: UIView? {
		get {
			return containerView
		}
	}
	
	override var canBecomeFirstResponder: Bool {
		return true
	}
}


extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return datas.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let data = datas[indexPath.row]
		let prefix = "http://index-holdings.com/bcp/"
		let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentTableViewCell
		cell.messageLabel.text = data.comments
		cell.nameLabel.text = data.name
		cell.profileImage.setImage(imageUrl: prefix + data.my_Image!)
		return cell
	}
	
	
}

import Kingfisher

extension UIImageView {
	
	func setImage(imageUrl : String? ) {
		
		DispatchQueue.main.async {
			if URL(string: imageUrl!) != nil && (imageUrl?.count)! > 0 {
				let resource = ImageResource(downloadURL: URL(string: imageUrl!)!, cacheKey: imageUrl)
				//			self.contentMode = .scaleAspectFit
				self.kf.setImage(with: resource, placeholder: UIImage(named: "accntprofile"))
			}
			else{
				self.image = UIImage(named: "accntprofile")
			}
		}
	}
}



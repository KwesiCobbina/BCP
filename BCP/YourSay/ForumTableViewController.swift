//
//  ForumTableViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 11/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class ForumTableViewController: UITableViewController {

    @IBOutlet weak var forumDetailsTableView: UITableView!
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var noOfCommentsLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var closingLabel: UILabel!
    var mainForum: Forum?
    var forum_id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forumDetailsTableView.rowHeight = UITableView.automaticDimension
        forumDetailsTableView.estimatedRowHeight = 240
        
        forum_id = (self.tabBarController as! ForumTabViewController).itd
        fetchforumsDetails(forum_id: forum_id!) { (err, result) in
            if err != nil {
                print(err!)
            } else {
                if let res = result {
                    DispatchQueue.main.async {
                        self.interestLabel.text = res.policy_interest
                        self.descriptionLabel.text = res.description
                        self.noOfCommentsLabel.text = res.total_comments
                        self.createdLabel.text = "Created on " + (res.start_date!)
                        self.closingLabel.text = "Closing on " + (res.end_date!)
                        self.forumDetailsTableView.reloadData()
                    }
                }
            }
        }
    }

    // MARK: - Table view data source
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            if indexPath.row == 1 {
//                return UITableView.automaticDimension
//            }
//            return 50.0
//        }
//        return 50.0
//    }
    
    
    
    func fetchforumsDetails(forum_id: String, callback: @escaping (_ error: NSError?, _ result: Forum?) -> Void) -> Void{
        var tempForums: [Forum] = []
        let url = URL(string: "\(AppConstants.sharedInstance.prodURL)bcp_discussion_view_reply.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let params = "forum_id=\(forum_id)"
        request.httpBody = params.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        guard let dataResponse = data,
                            error == nil else {
                                print(error?.localizedDescription ?? "Response Error")
                                return }
                        do{
                            
                            let countries = try JSONDecoder().decode([Forum].self, from: dataResponse)
                            
                            for data in countries {
                                tempForums.append(data)
                                print(data)
                                //                    print(data)
                            }
                            print(tempForums.count)
                            callback(nil, tempForums.first)
                            return
//                            self.mainForum = tempForums.first!
                            
                        } catch let parsingError {
                            print("Error", parsingError)
                            callback(parsingError as NSError, nil)
                        }
                        DispatchQueue.main.async {
                            print(self.mainForum?.description)
                            
                        }
                    }
                    task.resume()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            if indexPath.row == 0 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "")! as UITableViewCell
//                return cell
//            }
//        }
//        return UITableViewCell
//    }
}

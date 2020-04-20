//
//  DiscussionPoliciesViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 11/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class DiscussionPoliciesViewController: UIViewController {

    @IBOutlet weak var discussionPolsTableView: UITableView!
    var topics:[Topics] = []
    var discFor: Category?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(discFor)

        discussionPolsTableView.delegate = self
        discussionPolsTableView.dataSource = self
        guard let policy_type_id = discFor?.policy_type_id else {
            return
        }
        print(policy_type_id)
        fetchTopics(policy_type_id: policy_type_id)
        // Do any additional setup after loading the view.
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func checkDatas() {
        if topics.isEmpty {
            discussionPolsTableView.isHidden = true
//            noDataLabel.isHidden = false
//            appIcon.isHidden = false
//            hideSpinner(child: child)
        }
        else {
            discussionPolsTableView.isHidden = false
            DispatchQueue.main.async {
                self.discussionPolsTableView.reloadData()
            }
//            noDataLabel.isHidden = true
//            appIcon.isHidden = true
//            hideSpinner(child: child)
        }
    }
    
    func fetchTopics(policy_type_id: String) {
            var tempTopics: [Topics] = []
            
            let url = URL(string: "\(AppConstants.sharedInstance.prodURL)bcp_discussion_topics.php")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            
            
            let params = "policy_type_id=\(policy_type_id)"
            request.httpBody = params.data(using: String.Encoding.utf8)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let dataResponse = data,
                    error == nil else {
                        print(error?.localizedDescription ?? "Response Error")
                        return }
                do{
                    
                    let countries = try JSONDecoder().decode([Topics].self, from: dataResponse)
                    
                    for data in countries {
                        tempTopics.append(data)
                        print(data)
                    }
                    self.topics = []
                    self.topics = tempTopics
                    
                    
                    
                } catch let parsingError {
                    print("Error", parsingError)
                }
                DispatchQueue.main.async {
                    self.checkDatas()
                    
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


extension DiscussionPoliciesViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return topics.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = topics[indexPath.section]
                let cell = tableView.dequeueReusableCell(withIdentifier: "DiscussionPoliciesTableViewCell") as! DiscussionPoliciesTableViewCell
                cell.setTopic(topic: post)
                cell.layer.masksToBounds = true
                cell.layer.cornerRadius = 2
                cell.layer.borderWidth = 2
                cell.layer.shadowOffset = CGSize(width: -1, height: 1)
                cell.selectionStyle = .none
                cell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dfToOvTab" {
            let indexPaths=self.discussionPolsTableView!.indexPathsForSelectedRows!
                        let indexPath = indexPaths[0] as NSIndexPath
                        let destinationView = segue.destination as? ForumTabViewController
            //            destinationView!.class_id = self.datas[indexPath.row].regulation_id
                        destinationView!.incoming = self.topics[indexPath.section]
            
        }
    }
    
}

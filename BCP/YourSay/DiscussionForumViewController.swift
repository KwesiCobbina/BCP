//
//  DiscussionForumViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 11/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class DiscussionForumViewController: UIViewController {

    @IBOutlet weak var discussionTableView: UITableView!
    var categories:[Category] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
//         bcp.gov.gh/bcp_api/bcp_discussion_category.php

        discussionTableView.delegate = self
        discussionTableView.dataSource = self
        fetchCategories()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func checkDatas() {
        if categories.isEmpty {
            discussionTableView.isHidden = true
//            noDataLabel.isHidden = false
//            appIcon.isHidden = false
//            hideSpinner(child: child)
        }
        else {
            discussionTableView.isHidden = false
            DispatchQueue.main.async {
                self.discussionTableView.reloadData()
            }
//            noDataLabel.isHidden = true
//            appIcon.isHidden = true
//            hideSpinner(child: child)
        }
    }
    
    func fetchCategories(){
            var tempcategory: [Category] = []
            let url = URL(string: "\(AppConstants.sharedInstance.prodURL)bcp_discussion_category.php")
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let dataResponse = data,
                    error == nil else {
                        print(error?.localizedDescription ?? "Response Error")
                        return }
                do{
                    
                    let cats = try JSONDecoder().decode([Category].self, from: dataResponse)
                    
                    for data in cats {
                        tempcategory.append(data)
                    }
                    self.categories = []
                    self.categories = tempcategory
                    
                    
                    
                } catch let parsingError {
                    print("Error", parsingError)
                }
                DispatchQueue.main.async {
                    self.checkDatas()
                }
            }
            task.resume()
        }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.hidesBottomBarWhenPushed = false
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DiscussionForumViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = categories[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscussionTableViewCell") as! DiscussionTableViewCell
//        cell.setReg(reg: post)
        cell.setCategory(cat: post)
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
        if segue.identifier == "discForToAllDis"{
//            self.hidesBottomBarWhenPushed = true
            let indexPaths=self.discussionTableView!.indexPathsForSelectedRows!
            let indexPath = indexPaths[0] as NSIndexPath
            let destinationView = segue.destination as? DiscussionPoliciesViewController
//            destinationView!.class_id = self.datas[indexPath.row].regulation_id
            destinationView!.discFor = self.categories[indexPath.section]
        }
    }
    
    
}

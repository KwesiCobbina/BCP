//
//  RegulationClausesViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 03/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class RegulationClausesViewController: UIViewController {

    var datas:[Clause] = []
    var policy_id = ""
    @IBOutlet weak var clausesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        clausesTableView.delegate = self
        clausesTableView.dataSource = self
        
        policy_id = AppConstants.sharedInstance.policy_id!
        print(policy_id)
//        5
        fetchClauses()
        // Do any additional setup after loading the view.
    }
    
    func checkDatas() {
        if datas.isEmpty {
            clausesTableView.isHidden = true
        }
        else {
            clausesTableView.isHidden = false
            DispatchQueue.main.async {
                self.clausesTableView.reloadData()
            }
        }
    }
    
    func fetchClauses(){
        var tempAdminis: [Clause] = []
        let url = URL(string: "\(AppConstants.sharedInstance.prodURL)bcp_clauseByRegID.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"


        let params = "regulation_id=\(policy_id)"
        request.httpBody = params.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{

                let results = try JSONDecoder().decode(Clauses.self, from: dataResponse)

                for data in results.result {
                    tempAdminis.append(data)
//                    print(data.clause_id)
                }
                self.datas = []
                self.datas = tempAdminis



            } catch let parsingError {
                print("Error", parsingError)
            }
            DispatchQueue.main.async {
                self.checkDatas()
            }
        }
        task.resume()
    }
    


}


extension RegulationClausesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = datas[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClauseTableViewCell") as! ClauseTableViewCell
        cell.setClause(clause: post)
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 2
        cell.layer.borderWidth = 2
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.selectionStyle = .none
        cell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "clauseToClaseDetails", sender: self)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "clauseToClaseDetails" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationView: ClauseDetailsTableViewController = storyboard.instantiateViewController(withIdentifier: "ClauseDetailsTableViewController") as! ClauseDetailsTableViewController
            let indexPaths=self.clausesTableView!.indexPathsForSelectedRows!
            let indexPath = indexPaths[0] as NSIndexPath
            destinationView.clause = self.datas[indexPath.section]
            AppConstants.sharedInstance.selectedClause = self.datas[indexPath.section]
            AppConstants.sharedInstance.clauseStatus = false
            AppConstants.sharedInstance.isFromFavs = false
        }
    }
}

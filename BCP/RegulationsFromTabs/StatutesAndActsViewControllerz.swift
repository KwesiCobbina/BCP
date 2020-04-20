//
//  StatutesAndActsViewController.swift
//
//  Created by Kwesi Adu Cobbina on 03/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class StatutesAndActsViewControllerz: UIViewController {

    @IBOutlet weak var statutesTableViewz: UITableView!
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var navController: UINavigationController?
    var statutes: [Regulation] = []
    let child = SpinnerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchStatutes()
        statutesTableViewz.delegate = self
        statutesTableViewz.dataSource = self
        showSpinner(child: child)
//        if let controllerA = self.navigationController?.presentingViewController as? RegulationsViewController {
//            print("arrived from controllerA")
//        } else if let controllerB = self.navigationController?.presentingViewController as? MenuTableViewController {
//            print("arrived from controllerB")
//        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
//        statutesTableView.isHidden = true
//        if let controllerA = self.navigationController?.presentingViewController as? RegulationsViewController {
//            print("arrived from controllerA")
//        } else if let controllerB = self.navigationController?.presentingViewController as? MenuTableViewController {
//            print("arrived from controllerB")
//        }
    }
    
    func checkDatas() {
        if statutes.isEmpty {
            statutesTableViewz.isHidden = true
            noDataLabel.isHidden = false
            appIcon.isHidden = false
            hideSpinner(child: child)
        }
        else {
            statutesTableViewz.isHidden = false
            DispatchQueue.main.async {
                self.statutesTableViewz.reloadData()
            }
            noDataLabel.isHidden = true
            appIcon.isHidden = true
            hideSpinner(child: child)
        }
    }
    
    func fetchStatutes() {
        var tempAdminis: [Regulation] = []
                let menu_id = "1"
                let limit = 20
                let ofset = 0
                let url = URL(string: "\(AppConstants.sharedInstance.prodURL)bcp_get_regulationByClassIDNew.php")
        //        let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_read_menu_details.php")
                var request = URLRequest(url: url!)
                request.httpMethod = "POST"


                let params = "class_id=\(menu_id)&limit=\(limit)&offset=\(ofset)"
                request.httpBody = params.data(using: String.Encoding.utf8)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard let dataResponse = data,
                        error == nil else {
                            print(error?.localizedDescription ?? "Response Error")
                            return }
                    do{

                        let results = try JSONDecoder().decode(Regulations.self, from: dataResponse)

                        for data in results.result {
                            tempAdminis.append(data)
                            print(data)
                        }
                        self.statutes = []
                        self.statutes = tempAdminis



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


extension StatutesAndActsViewControllerz: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = statutes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell") as! RegulationsTableViewCell
        cell.setRegulation(reg: post)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationView: RegulationDetailViewController = storyboard.instantiateViewController(withIdentifier: "RegulationDetailViewController") as! RegulationDetailViewController
        AppConstants.sharedInstance.regulate = self.statutes[indexPath.row]
        AppConstants.sharedInstance.policy_id = self.statutes[indexPath.row].regulation_id!
        self.navController!.pushViewController(destinationView, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        let destinationView = RegulationDetailViewController()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinationView: RegulationDetailViewController = storyboard.instantiateViewController(withIdentifier: "RegulationDetailViewController2") as! RegulationDetailViewController
//        self.navController.pushViewController(destinationView, animated: true)
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && indexPath.row == self.statutes.count - 1 {
                // do here...
                let spinner = UIActivityIndicatorView(style: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

                self.statutesTableViewz.tableFooterView = spinner
                self.statutesTableViewz.tableFooterView?.isHidden = false
                print("This is the last cell")
                let menu_id = "1"
                let limit = 20
                let ofset = self.statutes.count
                let url = URL(string: "\(AppConstants.sharedInstance.prodURL)bcp_get_regulationByClassIDNew.php")
                var request = URLRequest(url: url!)
                request.httpMethod = "POST"
                let params = "class_id=\(menu_id)&limit=\(limit)&offset=\(ofset)"
                request.httpBody = params.data(using: String.Encoding.utf8)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard let dataResponse = data,
                        error == nil else {
                            print(error?.localizedDescription ?? "Response Error")
                            return }
                    do{

                        let results = try JSONDecoder().decode(Regulations.self, from: dataResponse)

                        for data in results.result {
                            self.statutes.append(data)
                            print(data)
                        }
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
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        checkDatas()
        return statutes.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "regulationsToMore" {
//            let indexPaths=self.statutesTableView!.indexPathsForSelectedRows!
//            let indexPath = indexPaths[0] as NSIndexPath
//            let vc = segue.destination as? MoreOnPolicyViewController
////            vc?.policy_id = self.policyPosts[indexPath.row].policy_id!
//        }
        
//        if segue.identifier == "statutesToDetails" {
//            let indexPaths=self.statutesTableViewz!.indexPathsForSelectedRows!
//            let indexPath = indexPaths[0] as NSIndexPath
//            let destinationView = segue.destination as? RegulationDetailViewController
//            destinationView!.class_id = self.statutes[indexPath.row].regulation_id
//            destinationView!.selectedRegulation = self.statutes[indexPath.row]
//        }
    }
}

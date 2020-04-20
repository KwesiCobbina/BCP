//
//  AdministrativeDirectiveViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 08/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import Foundation
import UIKit


class AdministrativeDirectiveViewControllerz: UIViewController {

    @IBOutlet weak var administrativeTableViewz: UITableView!
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var noDataLabel: UILabel!
//    var datas: [Read] = []
    var datas: [Regulation] = []
    let child = SpinnerViewController()
    var navController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        administrativeTableViewz.delegate = self
        administrativeTableViewz.dataSource = self
        fetchAdministrative()
        administrativeTableViewz.isHidden = true
        showSpinner(child: child)
        // Do any additional setup after loading the view.
    }
    
    func checkDatas() {
        if datas.isEmpty {
            administrativeTableViewz.isHidden = true
            noDataLabel.isHidden = false
            appIcon.isHidden = false
            hideSpinner(child: child)
        }
        else {
            administrativeTableViewz.isHidden = false
            DispatchQueue.main.async {
                self.administrativeTableViewz.reloadData()
            }
            noDataLabel.isHidden = true
            appIcon.isHidden = true
            hideSpinner(child: child)
        }
    }
    func fetchAdministrative() {
        var tempAdminis: [Regulation] = []
        let menu_id = "8"
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

extension AdministrativeDirectiveViewControllerz: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = datas[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell") as! RegulationsTableViewCell
        cell.setRegulation(reg: post)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        checkDatas()
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationView: RegulationDetailViewController = storyboard.instantiateViewController(withIdentifier: "RegulationDetailViewController") as! RegulationDetailViewController
        AppConstants.sharedInstance.regulate = self.datas[indexPath.row]
        AppConstants.sharedInstance.policy_id = self.datas[indexPath.row].regulation_id!
        self.navController!.pushViewController(destinationView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && indexPath.row == self.datas.count - 1 {
                // do here...
                let spinner = UIActivityIndicatorView(style: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

                self.administrativeTableViewz.tableFooterView = spinner
                self.administrativeTableViewz.tableFooterView?.isHidden = false
                print("This is the last cell")
                let menu_id = "8"
                let limit = 20
                let ofset = self.datas.count
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
                            self.datas.append(data)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "generalToMore" {
//            let indexPaths=self.administrativeTableView!.indexPathsForSelectedRows!
//            let indexPath = indexPaths[0] as NSIndexPath
//            let vc = segue.destination as? MoreOnPolicyViewController
////            vc?.policy_id = self.datas[indexPath.row].policy_id!
//        }
//        if segue.identifier == "adminisToDetails" {
//            let indexPaths=self.administrativeTableViewz!.indexPathsForSelectedRows!
//            let indexPath = indexPaths[0] as NSIndexPath
//            let destinationView = segue.destination as? RegulationDetailViewController
//            destinationView!.class_id = self.datas[indexPath.row].regulation_id
//            destinationView!.selectedRegulation = self.datas[indexPath.row]
//        }
    }
}

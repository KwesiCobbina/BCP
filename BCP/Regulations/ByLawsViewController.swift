//
//  ByLawsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 20/04/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class ByLawsViewController: UIViewController {

	@IBOutlet weak var byLawsTableView: UITableView!
	@IBOutlet weak var appIcon: UIImageView!
	@IBOutlet weak var noDataLabel: UILabel!
	var datas: [Regulation] = []
	let child = SpinnerViewController()
    var navController = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

		byLawsTableView.delegate = self
		byLawsTableView.dataSource = self
		fetchByLaws()
		byLawsTableView.isHidden = true
		showSpinner(child: child)
        // Do any additional setup after loading the view.
    }

	func checkDatas() {
		if datas.isEmpty {
			byLawsTableView.isHidden = true
			noDataLabel.isHidden = false
			appIcon.isHidden = false
			hideSpinner(child: child)
		}
		else {
			byLawsTableView.isHidden = false
			DispatchQueue.main.async {
				self.byLawsTableView.reloadData()
			}
			noDataLabel.isHidden = true
			appIcon.isHidden = true
			hideSpinner(child: child)
		}
	}
	
	func fetchByLaws() {
        var tempAdminis: [Regulation] = []
                let menu_id = "6"
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
//		var tempAdminis: [Read] = []
//		let menu_id = "6"
//		let url = URL(string: "\(AppConstants.sharedInstance.prodURL)bcp_read_menu_details.php")
////		let url = URL(string: "http://www.Index-holdings.com/bcp/bcp_api/bcp_read_menu_details.php")
//		var request = URLRequest(url: url!)
//		request.httpMethod = "POST"
//
//
//		let params = "menu_id=\(menu_id)"
//		request.httpBody = params.data(using: String.Encoding.utf8)
//		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//			guard let dataResponse = data,
//				error == nil else {
//					print(error?.localizedDescription ?? "Response Error")
//					return }
//			do{
//
//				let countries = try JSONDecoder().decode([Read].self, from: dataResponse)
//
//				for data in countries {
//					tempAdminis.append(data)
//					print(data)
//				}
//				self.datas = []
//				self.datas = tempAdminis
//
//
//
//			} catch let parsingError {
//				print("Error", parsingError)
//			}
//			DispatchQueue.main.async {
////				self.byLawsTableView.reloadData()
//				self.checkDatas()
//			}
//		}
//		task.resume()
	}
}




extension ByLawsViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let post = datas[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell") as! RegulationsTableViewCell
		cell.setRegulation(reg: post)
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return datas.count
	}
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && indexPath.row == self.datas.count - 1 {
                // do here...
                let spinner = UIActivityIndicatorView(style: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

                self.byLawsTableView.tableFooterView = spinner
                self.byLawsTableView.tableFooterView?.isHidden = false
                print("This is the last cell")
                let menu_id = "6"
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
		if segue.identifier == "bylawsToMore" {
			let indexPaths=self.byLawsTableView!.indexPathsForSelectedRows!
			let indexPath = indexPaths[0] as NSIndexPath
			let vc = segue.destination as? MoreOnPolicyViewController
//			vc?.policy_id = self.datas[indexPath.row].policy_id!
		}
        if segue.identifier == "byLawsToDetails" {
            let indexPaths=self.byLawsTableView!.indexPathsForSelectedRows!
            let indexPath = indexPaths[0] as NSIndexPath
            let destinationView = segue.destination as? RegulationDetailViewController
            AppConstants.sharedInstance.regulate = self.datas[indexPath.row]
            AppConstants.sharedInstance.policy_id = self.datas[indexPath.row].regulation_id!
        }
	}
}


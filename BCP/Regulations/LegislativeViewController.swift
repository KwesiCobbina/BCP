//
//  HomeViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 02/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class LegislativeViewController: UIViewController {

	@IBOutlet weak var homeTableView: UITableView!
	@IBOutlet weak var appIcon: UIImageView!
	@IBOutlet weak var noDataLabel: UILabel!
	var posts: [Regulation] = []
	let child = SpinnerViewController()
    var navController = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

		homeTableView.delegate = self
		homeTableView.dataSource = self
		fetchLegisilative()
		homeTableView.isHidden = true
		showSpinner(child: child)
    }
	
	func checkDatas() {
		if posts.isEmpty {
			homeTableView.isHidden = true
			noDataLabel.isHidden = false
			appIcon.isHidden = false
			hideSpinner(child: child)
		}
		else {
			homeTableView.isHidden = false
			DispatchQueue.main.async {
				self.homeTableView.reloadData()
			}
			noDataLabel.isHidden = true
			appIcon.isHidden = true
			hideSpinner(child: child)
			appIcon.isHidden = true
		}
	}
	
	func fetchLegisilative() {
        var tempAdminis: [Regulation] = []
                let menu_id = "5"
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
                        self.posts = []
                        self.posts = tempAdminis



                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                    DispatchQueue.main.async {
                        self.checkDatas()
                    }
                }
                task.resume()
//		var tempInterests: [Read] = []
//		let menu_id = "5"
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
//					tempInterests.append(data)
//					print(data)
//				}
//				self.posts = []
//				self.posts = tempInterests
//
//
//
//			} catch let parsingError {
//				print("Error", parsingError)
//			}
//			DispatchQueue.main.async {
////				self.homeTableView.reloadData()
//				self.checkDatas()
//			}
//		}
//		task.resume()
	}

}



extension LegislativeViewController: UITableViewDelegate,UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let post = posts[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell") as! RegulationsTableViewCell
        cell.setRegulation(reg: post)
		
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts.count
	}
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && indexPath.row == self.posts.count - 1 {
                // do here...
                let spinner = UIActivityIndicatorView(style: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

                self.homeTableView.tableFooterView = spinner
                self.homeTableView.tableFooterView?.isHidden = false
                print("This is the last cell")
                let menu_id = "5"
                let limit = 20
                let ofset = self.posts.count
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
                            self.posts.append(data)
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
        
        if segue.identifier == "legisilativesToDetails" {
            let indexPaths=self.homeTableView!.indexPathsForSelectedRows!
            let indexPath = indexPaths[0] as NSIndexPath
            let destinationView = segue.destination as? RegulationDetailViewController
            AppConstants.sharedInstance.regulate = self.posts[indexPath.row]
            AppConstants.sharedInstance.policy_id = self.posts[indexPath.row].regulation_id!
        }
	}
}

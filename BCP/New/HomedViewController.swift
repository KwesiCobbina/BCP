//
//  HomedViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 27/02/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class HomedViewController: UIViewController, UITextFieldDelegate {
    var datas: [SearchResults] = []
    var recents: [Recents] = []
    
    @IBOutlet weak var homedTableView: UITableView!

    let child = SpinnerViewController()
    @IBOutlet weak var searchTextField: DesignableUITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        homedTableView.delaysContentTouches = false
        homedTableView.delegate = self
        homedTableView.dataSource = self
        searchTextField.delegate = self
//        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
//        view.addGestureRecognizer(tap)
        self.hideKeyboardWhenTappedAround()
        fetchMostRecent()
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func checkDatas() {
        if recents.isEmpty {
            homedTableView.isHidden = true
        }
        else {
            homedTableView.isHidden = false
            DispatchQueue.main.async {
                self.homedTableView.reloadData()
            }
        }
    }
    
    func fetchMostRecent(){
        var tempAdminis: [Recents] = []
        let url = URL(string: "\(AppConstants.sharedInstance.prodURL)bcp_get_latest_active_consultations.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                let results = try JSONDecoder().decode([Recents].self, from: dataResponse)
                for data in results {
                    tempAdminis.append(data)
                    print(data)
                }
                self.recents = []
                self.recents = tempAdminis
            } catch let parsingError {
                print("Error", parsingError)
            }
            DispatchQueue.main.async {
                self.checkDatas()
            }
        }
        task.resume()
    }
    
    func fetchSearchResults(searchString: String){
        showSpinner(child: child)
        var tempsearch: [SearchResults] = []
//        let t = "http://bcp.gov.gh/bcp_api/bcp_search_regulations.php?query=pharmacy"
        let t = "http://bcp.gov.gh/bcp_api/bcp_search_regulations.php?query=\(searchString)"
        guard let url = URL(string: t) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                
                let userSearches = try JSONDecoder().decode(Returned.self, from: dataResponse)
                
                for data in userSearches.result {
                    
                    tempsearch.append(data)
                    print(data)
                }
                
                self.datas = tempsearch
                print(self.datas.count)
                if self.datas.count != 0 {
                    DispatchQueue.main.async {
                        let secondViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController
                        secondViewController.searched = self.datas
                        self.hideSpinner(child: self.child)
                        self.searchTextField.text = ""
                        self.navigationController?.pushViewController(secondViewController, animated: true)
                        }
                }
                

                
            } catch let parsingError {
                print("Error", parsingError)
                self.hideSpinner(child: self.child)
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToSearchResult" {
            let searchVC = segue.destination as! SearchResultViewController
            searchVC.searched = datas
            self.hideSpinner(child: self.child)
        }
        else if segue.identifier == "homedToMore" {
            let consultsDetailView = segue.destination as? MoreDetailsViewController
            let indexPath = sender as! IndexPath
            let selectedRow = recents[indexPath.section]
            
            consultsDetailView?.t = false
            consultsDetailView?.incoming_id = selectedRow.consultation_id
            consultsDetailView?.selectedRecent = selectedRow
            consultsDetailView?.topicTitle = selectedRow.topic
            consultsDetailView?.duration = selectedRow.period
            consultsDetailView?.details = selectedRow.description
            consultsDetailView?.institutionName = selectedRow.institution
            consultsDetailView?.srtDate = selectedRow.start_date
            consultsDetailView?.postedDate = selectedRow.created_on
            consultsDetailView?.endDate = selectedRow.end_date
        }
    }
    
 
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        if self.searchTextField.text != "" {
            fetchSearchResults(searchString: self.searchTextField.text!)
        }else{
            showAlert(title: "Empty Search Field", message: "The search field cannot be empty.")
        }
        
    }
    @IBAction func participateButtonClicked(_ sender: UIButton) {
    }
}



extension HomedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return recents.count
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
        let post = recents[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomedTableViewCell") as! HomedTableViewCell
        cell.setReg(reg: post)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "homedToMore", sender: indexPath)
        }
    }
}

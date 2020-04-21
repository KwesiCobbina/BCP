//
//  SearchResultViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 28/02/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {

    var searched: [SearchResults] = []
    @IBOutlet weak var searchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("this is search page")
        print(searched.count)
        searchTableView.estimatedRowHeight = 68.0
        searchTableView.rowHeight = UITableView.automaticDimension
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//        self.tabBarController?.tabBar.isHidden = false
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searched.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var result = SearchResults()
        result = searched[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "serachResultCell") as! SearchResultTableViewCell
        cell.setSearch(search: result)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        ClauseDetailsTableViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationView: ClauseDetailsTableViewController = storyboard.instantiateViewController(withIdentifier: "ClauseDetailsTableViewController") as! ClauseDetailsTableViewController
        let selected = searched[indexPath.row]
        AppConstants.sharedInstance.clauseStatus = true
        AppConstants.sharedInstance.selectedsearch = selected
        AppConstants.sharedInstance.isFromFavs = false
        navigationController?.pushViewController(destinationView, animated: true)
    }
    
    
}

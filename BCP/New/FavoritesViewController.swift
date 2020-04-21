//
//  FavoritesViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 21/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet var favsTableView: UITableView!
    var favs = [FavoritedClause]()
    override func viewDidLoad() {
        super.viewDidLoad()

        favsTableView.delegate = self
        favsTableView.dataSource = self
        CoreDataManager.sharedManager.fetchAllClauses { (error, results) in
            if let error = error {
                print(error)
            }
            else{
                guard let fetchedResults = results else {
                  showAlert(title: "Error", message: "You dont have any saved Clauses.")
                  return
                }
                self.favs = fetchedResults
                favsTableView.reloadData()
            }
            
        }
    }
    


}


extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        favs.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = favs[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavsTableViewCell") as! FavsTableViewCell
        cell.setfav(clause: post)
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
//        print(favs[indexPath.section])
        AppConstants.sharedInstance.isFromFavs = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationView: ClauseDetailsTableViewController = storyboard.instantiateViewController(withIdentifier: "ClauseDetailsTableViewController") as! ClauseDetailsTableViewController
        let selected = favs[indexPath.section]
        var search = SearchResults()
        search.clause_details = selected.clause_details
        search.regulation_id = ""
        search.regulation_title = selected.clause_title
        search.regulation_document = ""
        search.regulation_date = ""
        search.regulation_gazette_date = ""
        search.regulation_introduction = ""
        search.clause_id = selected.clause_id
        search.clause_title = selected.clause_title
        search.clause_section = selected.clause_section
        search.clause_details = selected.clause_details
        search.clause_summary = selected.clause_summary
        search.clause_procedure = selected.clause_procedure
        search.clause_form = selected.clause_form
        search.clause_fee = selected.clause_fee
        search.clause_penalty = selected.clause_penalty
        search.sector_id = selected.sector_id
        search.sector_name = selected.sector_name
        search.subject_name = selected.subject_name
        AppConstants.sharedInstance.selectedsearch = search
        navigationController?.pushViewController(destinationView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
}

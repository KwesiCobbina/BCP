//
//  ClauseDetailsTableViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 18/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class ClauseDetailsTableViewController: UITableViewController {

    @IBOutlet weak var forumTitle: UILabel!
    @IBOutlet weak var clauseBody: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var sectorLabel: UILabel!
    @IBOutlet weak var clauseSummaryLabel: UILabel!
    @IBOutlet weak var penaltyLabel: UILabel!
    @IBOutlet weak var procedureLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet var clauseTableView: UITableView!
    var clause: Clause?
    var incomingRegulation: Regulation?
     var incomingRegulations: SearchResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            let favBtn = UIBarButtonItem(image: UIImage(systemName: "love"), style: .plain, target: self, action: #selector(performClaseSave))
            favBtn.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.navigationController?.navigationItem.rightBarButtonItem = favBtn
//            self.navigationItem.rightBarButtonItem  = favBtn
        } else {
            // Fallback on earlier versions
            let favBtn = UIBarButtonItem(image: UIImage(named: "love"), style: .plain, target: self, action: #selector(performClaseSave))
            self.navigationItem.rightBarButtonItem  = favBtn
        }
        
        setUpView()
        print(clause)
        clauseTableView.rowHeight = UITableView.automaticDimension
        clauseTableView.estimatedRowHeight = 500
    }
    
    @objc func performClaseSave(){
        print("saving clause")
    }
    
    func setUpView(){
        if AppConstants.sharedInstance.clauseStatus == false {
            incomingRegulation = AppConstants.sharedInstance.regulate
            clause = AppConstants.sharedInstance.selectedClause
            forumTitle.text = incomingRegulation?.regulation_title ?? "Not Available"
            clauseBody.text = clause?.clause_details?.htmlToString ?? "Not Available"
            subjectLabel.text = clause?.subject_name ?? "Not Available"
            sectorLabel.text = clause?.sector_name ?? "Not Available"
            clauseSummaryLabel.text = clause?.clause_summary ?? "Not Available"
            penaltyLabel.text = clause?.clause_penalty ?? "Not Available"
            feeLabel.text = clause?.clause_fee ?? "Not Available"
            procedureLabel.text = clause?.clause_procedure ?? "Not Available"
            clauseTableView.reloadData()
        } else {
            incomingRegulations = AppConstants.sharedInstance.selectedsearch
            clause = AppConstants.sharedInstance.selectedClause
            forumTitle.text = incomingRegulations?.regulation_title ?? "Not Available"
            clauseBody.text = incomingRegulations?.clause_details?.htmlToString ?? "Not Available"
            subjectLabel.text = incomingRegulations?.subject_name?.htmlToString ?? "Not Available"
            sectorLabel.text = incomingRegulations?.sector_name?.htmlToString ?? "Not Available"
            clauseSummaryLabel.text = incomingRegulations?.clause_summary?.htmlToString ?? "Not Available"
            penaltyLabel.text = incomingRegulations?.clause_penalty?.htmlToString ?? "Not Available"
            feeLabel.text = incomingRegulations?.clause_fee?.htmlToString ?? "Not Available"
            procedureLabel.text = incomingRegulations?.clause_procedure?.htmlToString ?? "Not Available"
            clauseTableView.reloadData()
        }
    }

    @IBAction func twitterBtnClicked(_ sender: Any) {
        var text: String?
        if AppConstants.sharedInstance.clauseStatus == false {
            text = "<b>\(incomingRegulation?.regulation_title ?? "Not Available")</b> <br><br> \(clause?.clause_details?.htmlToString ?? "Not Available") <br><br> </b>Subject:</b> \(clause?.subject_name ?? "Not Available") <br><br><b>Sector:</b> \(clause?.sector_name ?? "Not Available") <br><br> <b>Summary:</b> \(clause?.clause_summary ?? "Not Available") <br><br> <b>Procdure:</b> \(clause?.clause_procedure ?? "Not Available") <br><br> <b>Fee:</b> \(clause?.clause_fee ?? "Not Available") <br><br> <b>Penalty:</b> \(clause?.clause_penalty ?? "Not Available")"
        }else {
            text = "<b>\(incomingRegulations?.regulation_title ?? "Not Available")</b> <br><br> \(incomingRegulations?.clause_details?.htmlToString ?? "Not Available") <br><br> </b>Subject:</b> \(incomingRegulations?.subject_name ?? "Not Available") <br><br><b>Sector:</b> \(incomingRegulations?.sector_name ?? "Not Available") <br><br> <b>Summary:</b> \(incomingRegulations?.clause_summary ?? "Not Available") <br><br> <b>Procdure:</b> \(incomingRegulations?.clause_procedure ?? "Not Available") <br><br> <b>Fee:</b> \(incomingRegulations?.clause_fee ?? "Not Available") <br><br> <b>Penalty:</b> \(incomingRegulations?.clause_penalty ?? "Not Available")"
        }
        let myWebsite = NSURL(string:"https://bcp.gov.gh/e-registry")
        
        let shareAll = [myWebsite!, text?.htmlToString] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

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
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet var clauseTableView: UITableView!
    var clause: Clause?
    var incomingRegulation: Regulation?
     var incomingRegulations: SearchResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AppConstants.sharedInstance.isFromFavs == true{
            favBtn.isHidden = true
        }
        else {
            favBtn.isHidden = false
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
            forumTitle.text = incomingRegulation?.regulation_title?.htmlToString ?? "Not Available"
            clauseBody.text = clause?.clause_details?.htmlToString ?? "Not Available"
            subjectLabel.text = clause?.subject_name?.htmlToString ?? "Not Available"
            sectorLabel.text = clause?.sector_name?.htmlToString ?? "Not Available"
            clauseSummaryLabel.text = clause?.clause_summary?.htmlToString ?? "Not Available"
            penaltyLabel.text = clause?.clause_penalty?.htmlToString ?? "Not Available"
            feeLabel.text = clause?.clause_fee?.htmlToString ?? "Not Available"
            procedureLabel.text = clause?.clause_procedure?.htmlToString ?? "Not Available"
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
    @IBAction func favoriteBtnClicked(_ sender: Any) {
        if AppConstants.sharedInstance.clauseStatus == false {
            incomingRegulation = AppConstants.sharedInstance.regulate
            clause = AppConstants.sharedInstance.selectedClause
            CoreDataManager.sharedManager.saveClause(clause_id: clause?.clause_id ?? "Not Available", clause_title: incomingRegulation?.regulation_title?.htmlToString ?? "Not Available", clause_section: clause?.clause_section ?? "Not Available", clause_details: clause?.clause_details?.htmlToString ?? "Not Available", clause_summary: clause?.clause_summary?.htmlToString ?? "Not Available", clause_procedure: clause?.clause_procedure ?? "Not Available", clause_form: clause?.clause_form ?? "Not Available", clause_penalty: clause?.clause_penalty ?? "Not Available", sector_id: clause?.sector_id ?? "Not Available", sector_name: clause?.sector_name ?? "Not Available", subject_name: clause?.subject_name ?? "Not Available", date_added: Date(), clause_fee: clause?.clause_fee ?? "Not Available") { (err, res) in
                if let error = err {
                    
                    self.showAlert(title: "Error", message: "There was an error adding the consultation to your favorites. Please contact the administrator.")
                }
                else{
                    self.showAlert(title: "Successful", message: "The Clause has been added to your favorite clauses.")
                }
            }
        } else {
            incomingRegulations = AppConstants.sharedInstance.selectedsearch
            CoreDataManager.sharedManager.saveClause(clause_id: incomingRegulations?.clause_id?.htmlToString ?? "Not Available", clause_title: incomingRegulations?.regulation_title?.htmlToString ?? "Not Available", clause_section: incomingRegulations?.clause_section?.htmlToString ?? "Not Available", clause_details: incomingRegulations?.clause_details?.htmlToString ?? "Not Available", clause_summary: incomingRegulations?.clause_summary?.htmlToString ?? "Not Available", clause_procedure: incomingRegulations?.clause_procedure?.htmlToString ?? "Not Available", clause_form: incomingRegulations?.clause_form?.htmlToString ?? "Not Available", clause_penalty: incomingRegulations?.clause_penalty?.htmlToString ?? "Not Available", sector_id: incomingRegulations?.sector_id?.htmlToString ?? "Not Available", sector_name: incomingRegulations?.sector_name?.htmlToString ?? "Not Available", subject_name: incomingRegulations?.subject_name?.htmlToString ?? "Not Available", date_added: Date(), clause_fee: incomingRegulations?.clause_fee?.htmlToString ?? "Not Available") { (err, res) in
                if let error = err {
                    
                    self.showAlert(title: "Error", message: "There was an error adding the consultation to your favorites. Please contact the administrator.")
                }
                else{
                    self.showAlert(title: "Successful", message: "The Clause has been added to your favorite clauses.")
                }
            }
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

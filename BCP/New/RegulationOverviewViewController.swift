//
//  RegulationOverviewViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 03/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class RegulationOverviewViewController: UIViewController {

    var policy_id = ""
    var incomingRegulation: Regulation?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var sectorLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var classificationLabel: UILabel!
    @IBOutlet weak var regulationIdLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchOverview()
        incomingRegulation = AppConstants.sharedInstance.regulate
        print(incomingRegulation)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchOverview()
    }
    

    func fetchOverview(){
//        incomingRegulation = AppConstants.sharedInstance.regulate
        titleLabel.text = incomingRegulation?.regulation_title
        subjectLabel.text = incomingRegulation?.subject_name
        sectorLabel.text = incomingRegulation?.sector_name
        detailsLabel.text = incomingRegulation?.regulation_introduction?.htmlToString
//        classificationLabel.text = incomingRegulation.
        regulationIdLabel.text = incomingRegulation?.regulation_id
    }

}

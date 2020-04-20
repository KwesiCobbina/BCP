//
//  TestViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 03/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import PageMenu

class RegulationsViewController: UIViewController {

	@IBOutlet weak var regulationsViewBox: UIView!
	
	var pageMenu : CAPSPageMenu?
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

		var controllerArray : [UIViewController] = []
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController7: StatutesAndActsViewController = storyboard.instantiateViewController(withIdentifier: "StatutesAndActsViewController0") as! StatutesAndActsViewController
        viewController7.navController = self.navigationController!
        viewController7.title = "Statutes / Acts"
        let viewController5: LegislativeViewController = storyboard.instantiateViewController(withIdentifier: "LegislativeViewController0") as! LegislativeViewController
        viewController5.navController = self.navigationController!
        viewController5.title = "Legislative Instruments"
        let viewController6: ByLawsViewController = storyboard.instantiateViewController(withIdentifier: "ByLawsViewController0") as! ByLawsViewController
        viewController6.navController = self.navigationController!
        viewController6.title = "By Laws"
		let viewController1: GeneralViewController = storyboard.instantiateViewController(withIdentifier: "GeneralViewController0") as! GeneralViewController
        viewController1.navController = self.navigationController!
		viewController1.title = "General Business Laws"
        let viewController4: AdministrativeDirectiveViewController = storyboard.instantiateViewController(withIdentifier: "AdministrativeDirectiveViewController0") as! AdministrativeDirectiveViewController
        viewController4.navController = self.navigationController!
        viewController4.title = "Administrative Directives"
		let viewController2: RegulatoryNoticesViewController = storyboard.instantiateViewController(withIdentifier: "RegulatoryNoticesViewController0") as! RegulatoryNoticesViewController
        viewController2.navController = self.navigationController!
		viewController2.title = "Regulatory Notices"
		let viewController3: FeesAndChargesViewController = storyboard.instantiateViewController(withIdentifier: "FeesAndChargesViewController0") as! FeesAndChargesViewController
        viewController3.navController = self.navigationController!
		viewController3.title = "Fees & Charges"
		
		
		

        controllerArray.append(viewController7)
		controllerArray.append(viewController5)
		controllerArray.append(viewController6)
        controllerArray.append(viewController1)
        controllerArray.append(viewController4)
        controllerArray.append(viewController2)
        controllerArray.append(viewController3)
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor(red: 190/255.0, green: 54/255.0, blue: 54/255.0, alpha: 1.0)),
            .viewBackgroundColor(UIColor.white),
            .selectionIndicatorColor(UIColor.white),
            .bottomMenuHairlineColor(UIColor.white),
            .menuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .menuHeight(40.0),
            .menuItemWidth(self.view.frame.width / 2 - 15),
            .centerMenuItems(true)
        ]
		
		
		pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.regulationsViewBox.frame.width, height: self.regulationsViewBox.frame.height), pageMenuOptions: parameters)
		
		self.regulationsViewBox.addSubview(pageMenu!.view)
		pageMenu!.didMove(toParent: self)
	}
    


}

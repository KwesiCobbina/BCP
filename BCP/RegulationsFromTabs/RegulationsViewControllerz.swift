//
//  TestViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 03/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import PageMenu

class RegulationsViewControllerz: UIViewController {

	@IBOutlet weak var regulationsViewBoxz: UIView!
	
	var pageMenu : CAPSPageMenu?
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

		var controllerArray : [UIViewController] = []
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController7: StatutesAndActsViewControllerz = storyboard.instantiateViewController(withIdentifier: "StatutesAndActsViewControllerz") as! StatutesAndActsViewControllerz
        viewController7.navController = self.navigationController!
        viewController7.title = "Statutes / Acts"
        let viewController5: LegislativeViewControllerz = storyboard.instantiateViewController(withIdentifier: "LegislativeViewControllerz") as! LegislativeViewControllerz
        viewController5.navController = self.navigationController!
        viewController5.title = "Legislative Instruments"
        let viewController6: ByLawsViewControllerz = storyboard.instantiateViewController(withIdentifier: "ByLawsViewControllerz") as! ByLawsViewControllerz
        viewController6.navController = self.navigationController!
        viewController6.title = "By Laws"
		let viewController1: GeneralViewControllerz = storyboard.instantiateViewController(withIdentifier: "GeneralViewControllerz") as! GeneralViewControllerz
        viewController1.navController = self.navigationController!
		viewController1.title = "General Business Laws"
        let viewController4: AdministrativeDirectiveViewControllerz = storyboard.instantiateViewController(withIdentifier: "AdministrativeDirectiveViewControllerz") as! AdministrativeDirectiveViewControllerz
        viewController4.navController = self.navigationController!
        viewController4.title = "Administrative Directives"
		let viewController2: RegulatoryNoticesViewControllerz = storyboard.instantiateViewController(withIdentifier: "RegulatoryNoticesViewControllerz") as! RegulatoryNoticesViewControllerz
        viewController2.navController = self.navigationController!
		viewController2.title = "Regulatory Notices"
		let viewController3: FeesAndChargesViewControllerz = storyboard.instantiateViewController(withIdentifier: "FeesAndChargesViewControllerz") as! FeesAndChargesViewControllerz
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
		
		
		pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.regulationsViewBoxz.frame.width, height: self.regulationsViewBoxz.frame.height), pageMenuOptions: parameters)
		
		self.regulationsViewBoxz.addSubview(pageMenu!.view)
		pageMenu!.didMove(toParent: self)
	}
    


}

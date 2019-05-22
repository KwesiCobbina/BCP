//
//  TestViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 03/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import PageMenu

class HomeViewController: UIViewController {

	@IBOutlet weak var testViewBox: UIView!
	
	var pageMenu : CAPSPageMenu?
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

		var controllerArray : [UIViewController] = []
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController1: GeneralViewController = storyboard.instantiateViewController(withIdentifier: "GeneralViewController") as! GeneralViewController
		viewController1.title = "General"
		let viewController2: PoliciesViewController = storyboard.instantiateViewController(withIdentifier: "PoliciesViewController") as! PoliciesViewController
		viewController2.title = "Policies"
		let viewController3: RegulationsViewController = storyboard.instantiateViewController(withIdentifier: "vc2") as! RegulationsViewController
		viewController3.title = "Regulations"
		let viewController4: AdministrativeViewController = storyboard.instantiateViewController(withIdentifier: "vc1") as! AdministrativeViewController
		viewController4.title = "Administrative Directives"
		let viewController5: LegislativeViewController = storyboard.instantiateViewController(withIdentifier: "LegislativeViewController") as! LegislativeViewController
		viewController5.title = "Legislative Instruments"
		let viewController6: ByLawsViewController = storyboard.instantiateViewController(withIdentifier: "ByLawsViewController") as! ByLawsViewController
		viewController6.title = "By Laws"

		controllerArray.append(viewController1)
		controllerArray.append(viewController2)
		controllerArray.append(viewController3)
		controllerArray.append(viewController4)
		controllerArray.append(viewController5)
		controllerArray.append(viewController6)
		
		let parameters: [CAPSPageMenuOption] = [
			.scrollMenuBackgroundColor(UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.70)),
			.viewBackgroundColor(UIColor.white),
			.selectionIndicatorColor(UIColor.yellow),
			.bottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
			.menuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
			.menuHeight(50.0),
			.menuItemWidth(self.view.frame.width / 2 - 15),
			.centerMenuItems(true)
		]
		
		pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.testViewBox.frame.width, height: self.testViewBox.frame.height), pageMenuOptions: parameters)
		
		self.testViewBox.addSubview(pageMenu!.view)
		pageMenu!.didMove(toParent: self)
	}
    


}

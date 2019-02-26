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
		let viewController1: LegislativeViewController = storyboard.instantiateViewController(withIdentifier: "LegislativeViewController") as! LegislativeViewController
		viewController1.title = "Legislative Instruments"
		let viewController2: RegulationsViewController = storyboard.instantiateViewController(withIdentifier: "vc2") as! RegulationsViewController
		viewController2.title = "Regulations & Policies"
		let viewController3: AdministrativeViewController = storyboard.instantiateViewController(withIdentifier: "vc1") as! AdministrativeViewController
		viewController3.title = "Administrative Directives"

		controllerArray.append(viewController1)
		controllerArray.append(viewController2)
		controllerArray.append(viewController3)
		
		let parameters: [CAPSPageMenuOption] = [
			.scrollMenuBackgroundColor(UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.70)),
			.viewBackgroundColor(UIColor.white),
			.selectionIndicatorColor(UIColor.yellow),
			.bottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
			.menuItemFont(UIFont(name: "HelveticaNeue", size: 10.0)!),
			.menuHeight(50.0),
			.menuItemWidth(self.view.frame.width / 3 - 15),
			.centerMenuItems(true)
		]
		
		pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.testViewBox.frame.width, height: self.testViewBox.frame.height), pageMenuOptions: parameters)
		
		self.testViewBox.addSubview(pageMenu!.view)
		pageMenu!.didMove(toParent: self)
	}
    


}

//
//  ParticipateViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 06/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import PageMenu

class ParticipateViewController: UIViewController {

	@IBOutlet weak var participateViewBox: UIView!
	
	var pageMenu : CAPSPageMenu?
	
	override func viewDidLoad() {
        super.viewDidLoad()

		var controllerArray: [UIViewController] = []
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController1: CCalenderViewController = storyboard.instantiateViewController(withIdentifier: "CCalenderViewController") as! CCalenderViewController
		viewController1.title = "Consultations Calendar"
		
		let viewController2: UConsultationsViewController = storyboard.instantiateViewController(withIdentifier: "UConsultationsViewController") as! UConsultationsViewController
		viewController2.title = "Current Consultations"
		
		let viewController3: InterestsViewController = storyboard.instantiateViewController(withIdentifier: "InterestsViewController") as! InterestsViewController
		viewController3.title = "My Interests"
		
		let viewController4: CConsultationsViewController = storyboard.instantiateViewController(withIdentifier: "CConsultationsViewController") as! CConsultationsViewController
		viewController4.title = "Closed Consultations"
		
		
		controllerArray.append(viewController1)
		controllerArray.append(viewController2)
		controllerArray.append(viewController3)
		controllerArray.append(viewController4)
		
		
		let parameters: [CAPSPageMenuOption] = [
			.scrollMenuBackgroundColor(UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.70)),
			.viewBackgroundColor(UIColor.white),
			.selectionIndicatorColor(UIColor.yellow),
			.bottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
			.menuItemFont(UIFont(name: "HelveticaNeue", size: 10.0)!),
			.menuHeight(50.0),
			.menuItemWidth(self.view.frame.width / 2 - 15),
			.centerMenuItems(true)
		]
		
		pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.participateViewBox.frame.width, height: self.participateViewBox.frame.height), pageMenuOptions: parameters)
		
		self.participateViewBox.addSubview(pageMenu!.view)
		pageMenu?.didMove(toParent: self)
    }
    


}

//
//  InvestigationsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 10/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import PageMenu

class InvestigationsViewController: UIViewController {
	
	@IBOutlet weak var investigateViewBox: UIView!
	var pageMenu: CAPSPageMenu?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		var controllerArray: [UIViewController] = []
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController1: ComplaintViewController = storyboard.instantiateViewController(withIdentifier: "ComplaintViewController") as! ComplaintViewController
		viewController1.title = "Submit Your Complaint"
		
		let viewController2: UConsultationsViewController = storyboard.instantiateViewController(withIdentifier: "UConsultationsViewController") as! UConsultationsViewController
		viewController2.title = "View your Complaints"
		
		controllerArray.append(viewController1)
		controllerArray.append(viewController2)
		
		let parameters: [CAPSPageMenuOption] = [
			.scrollMenuBackgroundColor(UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.00)),
			.viewBackgroundColor(UIColor.white),
			.selectionIndicatorColor(UIColor.yellow),
			.bottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
			.menuItemFont(UIFont(name: "HelveticaNeue", size: 12.0)!),
			.menuHeight(50.0),
			.menuItemWidth(self.view.frame.width / 2 - 15),
			.centerMenuItems(true)
		]
		
		pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.investigateViewBox.frame.width, height: self.investigateViewBox.frame.height), pageMenuOptions: parameters)
		
		self.investigateViewBox.addSubview(pageMenu!.view)
		pageMenu?.didMove(toParent: self)

	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

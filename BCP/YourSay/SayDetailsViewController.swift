//
//  SayDetailsViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 26/04/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import PageMenu



class SayDetailsViewController: UIViewController {

	var pageMenu : CAPSPageMenu?
	@IBOutlet weak var sayViewBox: UIView!
	var controllerArray: [UIViewController] = []

	
    override func viewDidLoad() {
        super.viewDidLoad()

		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController1: SayItemViewController = storyboard.instantiateViewController(withIdentifier: "SayItemViewController") as! SayItemViewController
		viewController1.title = "OVERVIEW"
		
		let viewController2: CommentsViewController = storyboard.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
		viewController2.title = "COMMENTS"
		
		controllerArray.append(viewController1)
		controllerArray.append(viewController2)
		
		let parameters: [CAPSPageMenuOption] = [
			.scrollMenuBackgroundColor(UIColor.white),
			.viewBackgroundColor(UIColor.white),
			.selectionIndicatorColor(UIColor.red),
			.bottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
			.menuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
			.menuHeight(40.0),
			.selectedMenuItemLabelColor(UIColor.red),
			.menuItemWidth(self.view.frame.width / 2 - 15),
			.centerMenuItems(true)
		]
		
		pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.sayViewBox.frame.width, height: self.sayViewBox.frame.height), pageMenuOptions: parameters)
		
		self.sayViewBox.addSubview(pageMenu!.view)
		pageMenu?.didMove(toParent: self)
    }
	

}

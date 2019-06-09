//
//  AccountViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 24/04/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import PageMenu

class AccountViewController: UIViewController {

	@IBOutlet weak var accountViewBox: UIView!
	@IBOutlet weak var accountfor2: UIView!
	
	var pageMenu : CAPSPageMenu?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		UIGraphicsBeginImageContext(self.accountfor2.frame.size)
		UIImage(named: "color-2174065__480")?.draw(in: self.accountfor2.bounds)
		
		if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext(){
			UIGraphicsEndImageContext()
			self.accountfor2.backgroundColor = UIColor(patternImage: image)
		}else{
			UIGraphicsEndImageContext()
			debugPrint("Image not available")
		}

        // Do any additional setup after loading the view.
		var controllerArray: [UIViewController] = []
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController1: OverviewViewController = storyboard.instantiateViewController(withIdentifier: "OverviewViewController2") as! OverviewViewController
		viewController1.title = "OVERVIEW"
		
		let viewController2: AccountEditViewController = storyboard.instantiateViewController(withIdentifier: "AccountEditViewController") as! AccountEditViewController
		viewController2.title = "ACCOUNT"
		
		let viewController3: InterestsEditViewController = storyboard.instantiateViewController(withIdentifier: "InterestsEditViewController") as! InterestsEditViewController
		viewController3.title = "INTEREST"
		
		controllerArray.append(viewController1)
		controllerArray.append(viewController2)
		controllerArray.append(viewController3)
		
		let parameters: [CAPSPageMenuOption] = [
			.scrollMenuBackgroundColor(UIColor.clear),
			.viewBackgroundColor(UIColor.clear),
			.selectionIndicatorColor(UIColor.white),
			.bottomMenuHairlineColor(UIColor.white),
			.menuItemFont(UIFont(name: "HelveticaNeue", size: 12.0)!),
			.menuHeight(40.0),
			.selectedMenuItemLabelColor(UIColor.white),
			.unselectedMenuItemLabelColor(UIColor.lightGray),
			.menuItemWidth(self.view.frame.width / 3 - 15),
			.centerMenuItems(true)
		]
		
		pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.accountViewBox.frame.width, height: self.accountViewBox.frame.height), pageMenuOptions: parameters)
		
		self.accountViewBox.addSubview(pageMenu!.view)
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

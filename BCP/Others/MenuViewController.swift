//
//  MenuViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 26/03/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import Locksmith

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

	@IBAction func logoutClicked(_ sender: UIButton) {
		do {
			try Locksmith.deleteDataForUserAccount(userAccount: "userAccount")
//			self.performSegue(withIdentifier: "goback", sender: nil)
			let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
			self.present(vc, animated: true, completion: nil)
			CoreDataManager.sharedManager.deleteAll(entityName: "DownloadedDocuments")
			UserDefaults.standard.removeObject(forKey: "userID")
			UserDefaults.standard.removeObject(forKey: "userType")
			UserDefaults.standard.removeObject(forKey: "email")
			UserDefaults.standard.removeObject(forKey: "fullName")
//			UserDefaults.standard.removeObject(forKey: "email")
			
//			self.present(vc, animated: true, completion: nil)
		}
		catch let err {
			print(err)
		}
		
	}
	

}

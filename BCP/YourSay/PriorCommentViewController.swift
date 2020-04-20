//
//  PriorCommentViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 12/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class PriorCommentViewController: UIViewController {

    var idm: String?
    let defaultValues = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        idm = (self.tabBarController as! ForumTabViewController).itd
        print(idm)
        defaultValues.set(idm , forKey: "forumid")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toComments" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController1: ForumCommentViewController = storyboard.instantiateViewController(withIdentifier: "ForumCommentViewController") as! ForumCommentViewController
            viewController1.forum_id = idm
        }
    }
    

}

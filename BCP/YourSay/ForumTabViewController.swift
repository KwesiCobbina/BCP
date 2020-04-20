//
//  ForumTabViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 11/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class ForumTabViewController: UITabBarController {

    var incoming: Topics?
    var datas: [Forum] = []
    var itd: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let forum_id = incoming?.forum_id else {return}
        print(forum_id)
        itd = forum_id
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

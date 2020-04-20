//
//  MenuViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 03/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import Locksmith

class MenuTableViewController: UITableViewController {

    @IBOutlet weak var profileCell: UITableViewCell!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    var mainEmail: String = ""
    var name:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        let useDefaults = UserDefaults.standard
        guard let userName = useDefaults.string(forKey: "fullName") else { return}
        guard let email = useDefaults.string(forKey: "email") else {return}
        name = userName
        mainEmail = email
        emailLabel.text = mainEmail
        nameLabel.text = name
//        profileCell.contentView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            self.dismiss(animated: true, completion: nil)
        }
        else if indexPath.section == 2{
            print("We will ..... ")
        }
        else if indexPath.section == 4{
            print("Discussion..... ")
        }
        else if indexPath.section == 5{
            print("Favorites..... ")
        }
        else if indexPath.section == 8 {
            if indexPath.row == 0 {
                print(0)
            }
            else if indexPath.row == 1{
                print(1)
            }
        }
        else if indexPath.section == 10{
            print("We will logout here..... ")
            do {
                try Locksmith.deleteDataForUserAccount(userAccount: "userAccount")
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                self.present(vc, animated: true, completion: nil)
                let appDelegate = UIApplication.shared.delegate! as! AppDelegate

                let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                appDelegate.window?.rootViewController = initialViewController
                appDelegate.window?.makeKeyAndVisible()
                CoreDataManager.sharedManager.deleteAll(entityName: "DownloadedDocuments")
                UserDefaults.standard.removeObject(forKey: "userID")
                UserDefaults.standard.removeObject(forKey: "userType")
                UserDefaults.standard.removeObject(forKey: "email")
                UserDefaults.standard.removeObject(forKey: "fullName")
            } catch let err {
                print(err)
            }
        }
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

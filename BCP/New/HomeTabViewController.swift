//
//  HomeTabViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 27/02/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import Locksmith

class HomeTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectedIndex = 2
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        let dictionary = Locksmith.loadDataForUserAccount(userAccount: "userAccount")
//        if dictionary == nil {
//            print("no one here")
//            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
//            let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//            appDelegate.window?.rootViewController = initialViewController
//            appDelegate.window?.makeKeyAndVisible()
//        }
//    }
    
    func postToken(Token: String){
            let defaultValues = UserDefaults.standard
            let BCP_userID = defaultValues.string(forKey: "userID")
            if BCP_userID != nil {
                let url = URL(string: "\(AppConstants.sharedInstance.prodURL)save_push_token.php")
                var request = URLRequest(url: url!)
                request.httpMethod = "POST"
                
                let params = "token=\(Token)&userId=\(BCP_userID!)"
                request.httpBody = params.data(using: String.Encoding.utf8)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard let _ = data,
                        error == nil else {
                            print(error?.localizedDescription ?? "Response Error")
                            return }
                    do{
                        let decoder = JSONDecoder()
                        let res = try decoder.decode(ErrorData.self, from: data!)
                        print(res.message!)
                        
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                }
                task.resume()
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

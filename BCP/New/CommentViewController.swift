//
//  CommentViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 10/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
    @IBOutlet weak var mainCommentBox: UITextView!
    @IBOutlet weak var otherCommentBox: UITextView!
    @IBOutlet weak var confidentailitySwitch: UISwitch!
    @IBOutlet weak var submitBtn: UIButton!

    var needed_id: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
        @IBAction func submitClicked(_ sender: UIButton) {
//            if mainCommentBox.text != "" || mainCommentBox.text != "Enter Comment Here" {
                let useDefaults = UserDefaults.standard
                let forum_id = needed_id
                guard let BCP_userID = useDefaults.string(forKey: "userID") else {return}
                guard let BCP_userType = useDefaults.string(forKey: "userType") else {return}
                guard let email = useDefaults.string(forKey: "email") else {return}
                var confidentiality: String?
                if confidentailitySwitch.isOn{
                    confidentiality = "yes"
                }else {
                    confidentiality = "no"
                }
//                print(BCP_userID)
//
                let url = URL(string: "\(AppConstants.sharedInstance.prodURL)bcp_consultation_comment.php")
                var request = URLRequest(url: url!)
                request.httpMethod = "POST"
                
//
                let params = "consult_id=\(String(describing: forum_id))&user_id=\(BCP_userID)&user_type=\(BCP_userType)&comments=\(mainCommentBox.text!)&other_comments=\(otherCommentBox.text!)&resp_email=\(email)&confidentiality=\(String(describing: confidentiality))"
                request.httpBody = params.data(using: String.Encoding.utf8)
//
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
//                    do{
//
//                        let message = try JSONDecoder().decode(ErrorData.self, from: dataResponse)
//
//                        if message.message == "Response Saved Successfully"{
//                            print(message.message)
//                        }
//                        else {
//                            message.message
//                        }
//
//                    } catch let parsingError {
//                        print("Error", parsingError)
//                    }
//                    if error != nil {
//                        print(error?.localizedDescription as Any)
//                        return
//                    } else {
//                        let returnedData = data
////                        let httpResponse = response as? HTTPURLResponse
////                        if httpResponse?.statusCode == 200 {
////    //                        self.fetchComments()
////                        }
////                        else {
////                            print("sorry there was a proplem here")
////                        }
//                    }
                }
                task.resume()
    //            self.commentTextField.text = ""
    //            self.commentTextField.placeholder = "Enter Comment..."
    //        }
//            }
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

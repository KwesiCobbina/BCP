//
//  ForumCommentViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 11/04/2020.
//  Copyright © 2020 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit
import MessageKit
import InputBarAccessoryView


class ForumCommentViewController: MessagesViewController, InputBarAccessoryViewDelegate, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, MessageCellDelegate {

    
    
    var forumComments: [Message] = []
    var forum_id: String?
    let refreshControl = UIRefreshControl()
    var user_id: String?
    var user_type: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        maintainPositionOnKeyboardFrameChanged = true
        messagesCollectionView.keyboardDismissMode = .interactive
        messageInputBar.inputTextView.tintColor = .black
        messageInputBar.sendButton.setTitleColor(.red, for: .normal)
        
        messageInputBar.delegate = self
        let useDefaults = UserDefaults.standard
        let userName = useDefaults.string(forKey: "fullName")
        user_id = useDefaults.string(forKey: "userID")
        user_type = useDefaults.string(forKey: "userType")
        
        
        forum_id = useDefaults.string(forKey: "forumid")
        print(forum_id)
        fetchforumsComments(forum_id: forum_id!) { (err, result) in
            if err != nil {
                print(err!)
            } else {
                if let res = result {
                    for i in res {
                        let msg = Message(dictionary: i)
                        self.forumComments.append(msg!)
                    }
                    DispatchQueue.main.async {
                        self.messagesCollectionView.reloadData()
                        self.messagesCollectionView.scrollToBottom(animated: true)
                        print(res.count)
                    }
                    
                }
            }
        }
        // Do any additional setup after loading the view.
    }
//    func createNewChat() {
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController!.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController!.tabBar.isHidden = false
    }
    
    private func insertNewMessage(_ message: Message) {
        forumComments.append(message)
        messagesCollectionView.reloadData()
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom(animated: true)
        }
    }
    
    private func save(_ message: Message) {
        let url = URL(string: "\(AppConstants.sharedInstance.prodURL)bcp_publish_forum_comment.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        guard let forum_idd = forum_id else {return}
        guard let user_idd = user_id else {return}
        guard let user_typed = user_type else {return}
        let params = "forum_id=\(forum_idd)&message=\(message.content)&BCP_userID=\(user_idd)&BCP_userType=\(user_typed)"
        print(params)
        request.httpBody = params.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                                guard let _ = data,
                                    error == nil else {
                                        print(error?.localizedDescription ?? "Response Error")
                                        return }
                                    let httpResponse = response as? HTTPURLResponse
                                    if httpResponse?.statusCode == 200 {
                                        DispatchQueue.main.async {
                                            self.insertNewMessage(message)
                                        }
                                    }
                                    else {
                                        print("sorry there was a proplem here")
                                    }
                            }
                            task.resume()

        
        
    }

    
    func fetchforumsComments(forum_id: String, callback: @escaping (_ error: NSError?, _ result: [Forum]?) -> Void) -> Void{
            var tempForums: [Forum] = []
            let url = URL(string: "\(AppConstants.sharedInstance.prodURL)bcp_discussion_view_reply.php")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            let params = "forum_id=\(forum_id)"
            request.httpBody = params.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                            guard let dataResponse = data,
                                error == nil else {
                                    print(error?.localizedDescription ?? "Response Error")
                                    return }
                            do{
                                
                                let countries = try JSONDecoder().decode([Forum].self, from: dataResponse)
                                
                                for data in countries {
                                    tempForums.append(data)
                                    print(data)
                                    //                    print(data)
                                }
                                print(tempForums.count)
                                tempForums.removeFirst()
                                callback(nil, tempForums)
                                return
    //                            self.mainForum = tempForums.first!
                                
                            } catch let parsingError {
                                print("Error", parsingError)
                                callback(parsingError as NSError, nil)
                            }
                        }
                        task.resume()
        }
    
    
   
    func currentSender() -> SenderType {
        let useDefaults = UserDefaults.standard
        let userName = useDefaults.string(forKey: "fullName")
        let id = useDefaults.string(forKey: "userID")
        return Sender(id: id!, displayName: userName!)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return forumComments[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        if forumComments.count == 0 {
        print("There are no messages")
        return 0
        } else {
        return forumComments.count
        }
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
    //When use press send button this method is called.
        let useDefaults = UserDefaults.standard
        let userName = useDefaults.string(forKey: "fullName")
        let id = useDefaults.string(forKey: "userID")
        let message = Message(id: forum_id!, content: text, senderID: id!, senderName: userName!)
    //calling function to insert and save message
//        insertNewMessage(message)
        save(message)
        //clearing input field
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .red: .lightGray
//        let useDefaults = UserDefaults.standard
//        let id = useDefaults.string(forKey: "userID")
//        if message.sender.senderId == "33" {
//            return .lightGray
//        } else{
//            print(message.sender.senderId)
//            return.red
//        }
    }
    

    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
    //If it's current user show current user photo.
        let useDefaults = UserDefaults.standard
        if message.sender.senderId == useDefaults.string(forKey: "userID") {
//        SDWebImageManager.shared.loadImage(with: currentUser.photoURL, options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
//        avatarView.image = image
//        }
        } else {
//        SDWebImageManager.shared.loadImage(with: URL(string: user2ImgUrl!), options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
//        avatarView.image = image
//        }
        }
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        return .bubbleTail(corner, .curved)
    }
    
    
    

}

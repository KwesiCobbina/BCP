//
//  StructsFile.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 18/03/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import Foundation
import UIKit
import MessageKit

struct loginUser: Decodable {
	var message: String
	var BCP_fullname: String
	var BCP_email: String
	var BCP_userID: String
	var BCP_userType: String
}

struct ErrorData : Decodable {
	var message: String?
}



struct Consultations: Decodable {
	var topic: String?
	var institution: String?
	var start_date: String?
	var end_date: String?
	var period: String?
	var description: String?
	var created_on: String?
	var consultation_id: String?
	var month: String?
    var year: String?
}


//Policies changed to Read
struct Read: Decodable {
	var interest_name: String?
	var policy_title: String?
	var policy_id: String?
}


struct PolicyInfo: Decodable {
	var policy_title: String?
	var posted_by: String?
	var policy_year: String?
	var policy_type: String?
	var interest_name: String?
	var summary: String?
	var attachment: [String]?
}

struct Attachments: Decodable {
	var attachment: String?
}

struct AllInterest: Decodable {
	var interest_id: String?
	var interest_name: String?
	var person_interest: String?
//	var isOn: Bool? = false
}

struct AllInterestUpdate: Decodable {
	var interest_id: String?
	var interest_name: String?
	var person_interest: String?
	var isOn: Bool? = false
}

struct policyDets: Decodable {
	var policy_title: String?
	var policy_id: String?
}


struct calendarDate {
	var created_on: String?
}

struct Country: Decodable {
	var id: String?
	var name: String?
}

struct Category: Decodable {
	var policy_type_id: String?
	var policy_type: String?
	var total_topics: String?
}

struct Topics: Decodable {
	var forum_id: String?
	var topic: String?
	var category: String?
	var interest: String?
}


struct Forum: Decodable {
	var forum_id: String?
	var start_date: String?
	var end_date: String?
	var created_by: String?
	var description: String?
	var policy_category: String?
	var policy_interest: String?
	var total_comments: String?
	var comment_by: String?
	var reply_id: String?
	var name: String?
	var comments: String?
	var time_ago: String?
	var totalComments: String?
	var my_Image: String?
}

//struct ForumComments: Decodable {
//	var forum_id: String?
//	var reply_id: String?
//	var name: String?
//	var comments: String?
//	var time_ago: String?
//	var totalComment: String?
//	var my_Image: String?
//}


struct Interest: Decodable {
	var topic: String?
	var institution: String?
	var start_date: String?
	var end_date: String?
	var period: String?
	var description: String?
	var created_on: String?
	var consultation_id: String?
	var interest_name: String?
	var policy_type: String?
}

struct SearchResults: Codable {
    var regulation_id: String?
    var regulation_title: String?
    var regulation_document: String?
    var regulation_date: String?
    var regulation_gazette_date: String?
    var regulation_introduction: String?
    var clause_id: String?
    var clause_title: String?
    var clause_section: String?
    var clause_details: String?
    var clause_summary: String?
    var clause_procedure: String?
    var clause_form: String?
    var clause_fee: String?
    var clause_penalty: String?
    var sector_id: String?
    var sector_name: String?
    var subject_name: String?
}

struct Returned: Codable {
    var result : [SearchResults]
    var error: Bool
    var count: Int
}

struct Regulation: Codable {
    var regulation_id: String?
    var regulation_title: String?
    var regulation_document: String?
    var regulation_date: String?
    var regulation_gazette_date: String?
    var regulation_introduction: String?
    var sector_name: String?
    var subject_name: String?
    var regulation_no: String?
}

struct Regulations: Codable {
    var result : [Regulation]
    var error: Bool?
    var count: Int?
    var message: String?
}

struct Recents: Codable {
    var topic: String?
    var institution: String?
    var start_date: String?
    var end_date: String?
    var period: String?
    var description: String?
    var created_on: String?
    var consultation_id: String?
}

struct Clause: Codable {
    var clause_id: String?
    var clause_title: String?
    var clause_section: String?
    var clause_details: String?
    var clause_summary: String?
    var clause_procedure: String?
    var clause_form: String?
    var clause_fee: String?
    var clause_penalty: String?
    var sector_id: String?
    var sector_name: String?
    var subject_name: String?
}

struct Clauses: Codable {
    var result: [Clause]
    var error: Bool?
    var count:Int?
    var message: String?
    
}


struct Chat {
var users: [String]
var dictionary: [String: Any] {
return ["users": users]
   }
}

extension Chat {
init?(dictionary: [String:Any]) {
guard let chatUsers = dictionary["users"] as? [String] else {return nil}
self.init(users: chatUsers)
}
}


struct Message {
var id: String
var content: String
var senderID: String
var senderName: String
var dictionary: [String: Any] {
return [
"id": id,
"content": content,
"senderID": senderID,
"senderName":senderName]
    }
}

extension Message {
init?(dictionary: Forum) {
    guard let id = dictionary.forum_id,
        let content = dictionary.comments,
        let senderID = dictionary.comment_by,
        let senderName = dictionary.name
else {return nil}
    self.init(id: id, content: content, senderID: senderID, senderName:senderName)
    }
}

extension Message: MessageType {

    
var sender: SenderType {
return Sender(id: senderID, displayName: senderName)
    }
var messageId: String {
return id
    }
var sentDate: Date {
    return Date()
    }
var kind: MessageKind {
return .text(content)
    }
}


//
//  StructsFile.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 18/03/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import Foundation
import UIKit

struct loginUser: Decodable {
	var message: String?
	var BCP_fullname: String?
	var BCP_email: String?
	var BCP_userID: String?
	var BCP_userType: String?
}

struct ErrorData : Decodable {
	let message: String?
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
	var attachment: [Attachments]?
}

struct Attachments: Decodable {
	var attachment: String?
}

struct AllInterest: Decodable {
	var interest_id: String?
	var interest_name: String?
	var person_interest: String?
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
//	var comments: [ForumComments]?
	var reply_id: String?
	var name: String?
	var comments: String?
	var time_ago: String?
	var totalComment: String?
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

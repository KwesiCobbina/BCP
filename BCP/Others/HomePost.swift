//
//  HomePost.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 08/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import Foundation


class HomePost {
	var daysLeft: String
	var postTitle: String
	var organisationName: String
	var postDetails: String
	
	init(daysLeft: String, postTitle: String, organisationName: String, postDetails: String) {
		self.daysLeft = daysLeft
		self.postTitle = postTitle
		self.organisationName = organisationName
		self.postDetails = postDetails
	}
}

//
//  PagesData.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 07/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import Foundation
import UIKit

class PagesData {
	
	var daysLeft: String
	var postTitle: String
	var organisationName: String
	var postDetails: String
	var postDuration: String
	
	init(daysLeft: String, postTitle: String, organisationName: String, postDetails: String, postDuration: String) {
		self.daysLeft = daysLeft
		self.postTitle = postTitle
		self.organisationName = organisationName
		self.postDetails = postDetails
		self.postDuration = postDuration
		
	}
}

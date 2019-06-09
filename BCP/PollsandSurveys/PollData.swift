//
//  PollData.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 13/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import Foundation
import UIKit

class PollData {
	
	var pollCategory: String
	var pollTitle: String
	var pollQustionsNumber: String
	
	init(pollCategory: String, pollTitle: String, pollQustionsNumber: String) {
		self.pollCategory = pollCategory
		self.pollTitle = pollTitle
		self.pollQustionsNumber = pollQustionsNumber
		
		
	}
}

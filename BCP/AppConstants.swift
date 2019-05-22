//
//  AppConstants.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 22/05/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import Foundation

class AppConstants {
	
	private init () {}
	static let sharedInstance = AppConstants()
	var url: NSURL?
	var title: String = ""	
}

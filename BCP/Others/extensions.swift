//
//  extensions.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 09/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	
	@IBInspectable var cornerRadius: CGFloat {
		
		get{
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
			layer.masksToBounds = newValue > 0
		}
	}
	
	@IBInspectable var borderWidth: CGFloat {
		get {
			return layer.borderWidth
		}
		set {
			layer.borderWidth = newValue
		}
	}
	
	@IBInspectable var borderColor: UIColor {
		get {
			//			return UIColor(cgColor: layer.borderColor!)
			return UIColor(cgColor: layer.borderColor!)
		}
		set {
			layer.borderColor = borderColor.cgColor
		}
	}
	
	
	
	
}

//
//  extensions.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 09/02/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

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


extension UIViewController {
	
	func showToast(message : String) {
		
		let toastLabel = UILabel(frame: CGRect(x: 10, y: self.view.frame.size.height-200, width: self.view.frame.width - 20, height: 35))
		toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
		toastLabel.textColor = UIColor.white
		toastLabel.textAlignment = .center;
		toastLabel.font = UIFont(name: "Montserrat-Light", size: 6.0)
		toastLabel.text = message
		toastLabel.alpha = 1.0
		toastLabel.layer.cornerRadius = 10;
		toastLabel.clipsToBounds  =  true
		self.view.addSubview(toastLabel)
		UIView.animate(withDuration: 6.0, delay: 0.1, options: .curveEaseOut, animations: {
			toastLabel.alpha = 0.0
		}, completion: {(isCompleted) in
			toastLabel.removeFromSuperview()
		})
	} }



//import UIKit

@IBDesignable
class DesignableUITextField: UITextField {
	
	// Provides left padding for images
	override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
		var textRect = super.leftViewRect(forBounds: bounds)
		textRect.origin.x += leftPadding
		return textRect
	}
	
	@IBInspectable var leftImage: UIImage? {
		didSet {
			updateView()
		}
	}
	
	@IBInspectable var leftPadding: CGFloat = 0
	
	@IBInspectable var color: UIColor = UIColor.lightGray {
		didSet {
			updateView()
		}
	}
	
	func updateView() {
		if let image = leftImage {
			leftViewMode = UITextField.ViewMode.always
			let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
			imageView.contentMode = .scaleAspectFit
			imageView.image = image
			// Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
			imageView.tintColor = UIColor.red
			leftView = imageView
		} else {
			leftViewMode = UITextField.ViewMode.never
			leftView = nil
		}
		
		// Placeholder text color
		attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
	}
}


import UIKit
extension String {
	func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
		return boundingBox.height
	}
}



extension Collection {
	var pairs: [SubSequence] {
		var startIndex = self.startIndex
		let count = self.count
		let n = count/2 + count % 2
		return (0..<n).map { _ in
			let endIndex = index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
			defer { startIndex = endIndex }
			return self[startIndex..<endIndex]
		}
	}
}

extension StringProtocol where Self: RangeReplaceableCollection {
	mutating func insert(separator: Self, every n: Int) {
		for index in indices.reversed() where index != startIndex &&
			distance(from: startIndex, to: index) % n == 0 {
				insert(contentsOf: separator, at: index)
		}
	}
	
	func inserting(separator: Self, every n: Int) -> Self {
		var string = self
		string.insert(separator: separator, every: n)
		return string
	}
}

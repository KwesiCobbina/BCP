//
//  SpinnerViewController.swift
//  BCP
//
//  Created by Kwesi Adu Cobbina on 26/03/2019.
//  Copyright © 2019 Kwesi Adu Cobbina. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {


	var spinner = UIActivityIndicatorView(style: .whiteLarge)
	var label = UILabel()
	
	override func loadView() {
		view = UIView()
		view.backgroundColor = UIColor(white: 0, alpha: 0.7)
		
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.startAnimating()
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Please wait..."
		label.textColor = UIColor.white
		view.addSubview(spinner)
		view.addSubview(label)
		
		spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		label.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 10).isActive = true
		
	}
}

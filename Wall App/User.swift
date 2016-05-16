//
//  User.swift
//  Wall App
//
//  Created by sphota on 5/15/16.
//  Copyright © 2016 Lex Levi. All rights reserved.
//

import UIKit

class User: UIViewController {
	
	
	@IBOutlet weak var userBanner: UILabel!
	@IBOutlet weak var ageLabel: UILabel!
	
	
	@IBOutlet weak var logoutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

		userBanner.layer.borderWidth = 1.0
		userBanner.layer.borderColor = UIColor.blackColor().CGColor
		
		logoutButton.layer.borderWidth = 1.0
		logoutButton.layer.borderColor = UIColor.blackColor().CGColor
        // Do any additional setup after loading the view.
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(true)
		userBanner.text = UserSession.sharedInstance.username
		print(UserSession.sharedInstance.age)
		var sex = ""
		
		switch UserSession.sharedInstance.sex {
			case "0":
				sex = "Male"
				break
			case "1":
				sex = "Female"
				break
			case "2":
				sex = "Other"
				break
			
			default:
				break
			
		}
		ageLabel.text = String(UserSession.sharedInstance.age) + ", " + sex
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	
	@IBAction func logout(sender: AnyObject) {
		UserSession.sharedInstance.logout()
		self.dismissViewControllerAnimated(true, completion: nil)
	}

}

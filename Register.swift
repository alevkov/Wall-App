//
//  Register.swift
//  Wall App
//
//  Created by sphota on 5/14/16.
//  Copyright © 2016 Lex Levi. All rights reserved.
//

import UIKit

class Register: UIViewController {
	
	@IBOutlet weak var backButton: UIButton!
	@IBOutlet weak var signupButton: UIButton!
	
	@IBOutlet weak var usernameField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBOutlet weak var verifyField: UITextField!
	@IBOutlet weak var ageField: UITextField!
	@IBOutlet weak var email: UITextField!
	
	@IBOutlet weak var verifyLabel: UILabel!
	
	
	@IBOutlet weak var sexSwitch: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		verifyLabel.hidden = true
		
		backButton.layer.borderWidth = 1.0
		backButton.layer.borderColor = UIColor.blackColor().CGColor
		
		signupButton.layer.borderWidth = 1.0
		backButton.layer.borderColor = UIColor.blackColor().CGColor
		
		passwordField.secureTextEntry = true
		verifyField.secureTextEntry = true
		

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	@IBAction func back(sender: AnyObject) {
		verifyLabel.hidden = true
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	
	@IBAction func signUp(sender: AnyObject) {
		if passwordField.text == verifyField.text {
			verifyLabel.hidden = true
			let data : [String: AnyObject] = [	"username" : usernameField.text!,
			                                  	"password" : passwordField.text!,
			                                  	"sex": sexSwitch.selectedSegmentIndex,
			                                  	"age": ageField.text!,
			                                  	"email": email.text!]
			UserSession.sharedInstance.signup(data)
			self.dismissViewControllerAnimated(true, completion: nil)
		} else {
			
			verifyLabel.hidden = false
		}
	}
}

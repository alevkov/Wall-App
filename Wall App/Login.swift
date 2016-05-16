//
//  ViewController.swift
//  Wall App
//
//  Created by sphota on 5/14/16.
//  Copyright © 2016 Lex Levi. All rights reserved.
//

import UIKit

class Login: UIViewController {
	
	
	@IBOutlet weak var usernameField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	
	@IBOutlet weak var loginButton: UIButton!
	@IBOutlet weak var signupButton: UIButton!
	
	
	@IBOutlet weak var errorLabel: UILabel!
	
	
	@IBOutlet weak var banner: UILabel!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		errorLabel.hidden = true
		
		usernameField.layer.cornerRadius = 0.0
		passwordField.layer.cornerRadius = 0.0
		passwordField.secureTextEntry = true
		
		loginButton.layer.borderWidth = 1.0
		loginButton.layer.borderColor = UIColor.blackColor().CGColor
		
		signupButton.layer.borderWidth = 1.0
		signupButton.layer.borderColor = UIColor.blackColor().CGColor
		
		banner.layer.borderWidth = 1.0
		banner.layer.borderColor = UIColor.blackColor().CGColor
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	@IBAction func logIn(sender: AnyObject) {
		let data : [String: AnyObject] = [	"username" : usernameField.text!,
		                                  	"password" : passwordField.text!]
		UserSession.sharedInstance.login(data) {
			NSOperationQueue.mainQueue().addOperationWithBlock {
				if UserSession.sharedInstance.username != "" {
					let storyBoard = UIStoryboard(name: "Main", bundle: nil)
					let mainViewController = storyBoard.instantiateViewControllerWithIdentifier("tabs")
					self.presentViewController(mainViewController, animated: true, completion: nil)
				} else {
					self.errorLabel.hidden = false
					self.errorLabel.text = "Invalid credentials."
				}
			}
		}
	}
	

	@IBAction func signUp(sender: AnyObject) {
		//.. goes to register page
	}

	override func viewWillDisappear(animated: Bool) {
		errorLabel.hidden = true
	}

}


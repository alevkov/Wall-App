//
//  Wall.swift
//  Wall App
//
//  Created by sphota on 5/15/16.
//  Copyright © 2016 Lex Levi. All rights reserved.
//

import UIKit

class Wall: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var postView: UITextView!
	
	var raw_data = [String: AnyObject]()
	var posts = [NSDictionary]()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let nib = UINib(nibName: "PostCell", bundle: nil)
		
		tableView.registerNib(nib, forCellReuseIdentifier: "postCell")
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		postView.layer.borderWidth = 1.0
		postView.layer.borderColor = UIColor.blackColor().CGColor
		
		UserSession.sharedInstance.refreshWall { (data) in
			self.raw_data = data as! [String : AnyObject]
			if let raw_posts = self.raw_data["json"] as? [NSDictionary] {
				self.posts = raw_posts
				NSOperationQueue.mainQueue().addOperationWithBlock {
					self.tableView.reloadData()
				}
				print(raw_posts)
			}
		}

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell:PostTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("postCell") as! PostTableViewCell
		
		// this is how you extract values from a tuple
		cell.dateLabel.text = posts[indexPath.row]["date"] as? String
		cell.posterLabel.text = posts[indexPath.row]["poster"] as? String
		cell.postLabel.text = posts[indexPath.row]["text"] as? String
		
		return cell
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 150
	}

	
	@IBAction func post(sender: AnyObject) {
		let data = ["text": postView.text,
		            "poster": UserSession.sharedInstance.username]
		UserSession.sharedInstance.write(data) { 
			UserSession.sharedInstance.refreshWall { (data) in
				self.raw_data = data as! [String : AnyObject]
				if let raw_posts = self.raw_data["json"] as? [NSDictionary] {
					self.posts = raw_posts
					NSOperationQueue.mainQueue().addOperationWithBlock {
						self.tableView.reloadData()
						self.postView.text = ""
					}
					
				}
			}
		}
		
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()  //if desired
		post(self)
		return true
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(true)
		
		
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(true)
		UserSession.sharedInstance.refreshWall { (data) in
			self.raw_data = data as! [String : AnyObject]
			if let raw_posts = self.raw_data["json"] as? [NSDictionary] {
				self.posts = raw_posts

				self.tableView.reloadData()

				print(raw_posts)
			}
		}
	}

}

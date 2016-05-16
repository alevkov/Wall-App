//
//  UserSession.swift
//  Wall App
//
//  Created by sphota on 5/14/16.
//  Copyright © 2016 Lex Levi. All rights reserved.
//

import Foundation
/* using singleton for this */
private let sharedSession = UserSession()

let HOST = "localhost:"
let PORT = "8000"

let REGISTER = "/register/"
let LOGIN = "/login/"
let GET_POSTS = "/get_wall/"
let WRITE = "/write/"

class UserSession: NSObject {
	
	class var sharedInstance: UserSession {
		return sharedSession
	}
	
	var username = ""
	var sex = ""
	var age = -1
	
	var errorStr = ""
	
	
	func login (data: [String: AnyObject], completion: (() -> ())) {

		processRequest(data, endpoint: LOGIN, method: "POST") { (data) in
			if data["json"] != nil {
				let userData = data["json"] as! [String: AnyObject]
	
				self.username = userData["username"] as! String
				self.sex = (userData["sex"] as! String)
				self.age = (userData["age"] as! Int)
				completion()
			} else if data["json"] == nil && (data["responseCode"] as! Int) == 403 {
				self.errorStr = "Invalid credentials."
				completion()
			}
			
		}
	}
	
	func signup (data: [String: AnyObject]) {
		processRequest(data, endpoint: REGISTER, method: "POST") { (data) in
			if (data["responseCode"] as! Int) == 200 {
				//.. ok, can log in
			} else {
				//.. something went wrong..
			}
		}
		
	}
	
	func refreshWall (completion: (AnyObject -> ())) {
		processRequest(nil, endpoint: GET_POSTS, method: "GET") { (data) in
			completion(data)
		}
	}
	
	func write(data: [String: AnyObject], completion: (() -> ())) {
		processRequest(data, endpoint: WRITE, method: "POST") { (data) in
			if (data["responseCode"] as! Int) == 200 {
				completion()
			} else {
				self.errorStr = "Uknown error."
				completion()
			}
		}
	}
	
	func logout() {
		self.username = ""; self.sex = ""; self.age = -1
	}
	
	func processRequest(data: [String: AnyObject]?, endpoint: String, method: String, callback: ([String: AnyObject]) -> ()) {
		let url = NSURL(string: "http://" + HOST + PORT + endpoint)
		let request = NSMutableURLRequest(URL: url!)
		var responseData = [String: AnyObject]()
		
		let session = NSURLSession.sharedSession()
		request.HTTPMethod = method

			request.addValue("application/json", forHTTPHeaderField: "Content-Type")
			request.addValue("application/json", forHTTPHeaderField: "Accept")
			
			if method == "POST" {
				request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(data!, options: [])
			}
			
			let task = session.dataTaskWithRequest(request) { (data, response, error) in
				guard data != nil else {
					print("no data")
					return
				}
				
				do {
					if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
						let r = response as! NSHTTPURLResponse
						responseData["responseCode"] = r.statusCode
						responseData["json"] = json
						
						print("Success: \(r.statusCode)")
						callback(responseData)
					} else if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [NSDictionary] {
						let r = response as! NSHTTPURLResponse
						responseData["responseCode"] = r.statusCode
						responseData["json"] = json
						
						print("Success: \(r.statusCode)")
						callback(responseData)

					} else {
						let r = response as! NSHTTPURLResponse
						
						responseData["responseCode"] = r.statusCode
	
						print("Status: \(r.statusCode)")
						callback(responseData)
					}
				} catch let parseError {
					let r = response as! NSHTTPURLResponse
					responseData["responseCode"] = r.statusCode
	
					print("Status: '\(r.statusCode)'")
					callback(responseData)
				}
			}
			task.resume()
	}
}
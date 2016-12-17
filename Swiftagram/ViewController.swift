//
//  ViewController.swift
//  Swiftagram
//
//  Created by Pavan Powani on 15/12/16.
//  Copyright © 2016 Pavan Powani. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if FIRAuth.auth()?.currentUser != nil{
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
            self.presentViewController(vc!, animated: false, completion: nil)
        }
    }
 

    @IBAction func signInTapped(sender: AnyObject) {
        
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        FIRAuth.auth()?.signInWithEmail(username!, password: password!, completion: { (user, error) in
            if error != nil{
                //error logging in user
                let alert = UIAlertController(title: "Error", message: "Incorrect Username/Password", preferredStyle: .Alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }else{
                // logged in
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
                self.presentViewController(vc!, animated: true, completion: nil)
                
            }
        })
    }

}


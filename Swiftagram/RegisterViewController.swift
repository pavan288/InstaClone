//
//  RegisterViewController.swift
//  Swiftagram
//
//  Created by Pavan Powani on 15/12/16.
//  Copyright © 2016 Pavan Powani. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: ViewController {

    @IBOutlet var usernameRegister: UITextField!
    @IBOutlet var passwordRegister: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpTapped(sender: AnyObject) {
        
        let username = usernameRegister.text
        let password = passwordRegister.text
        
        FIRAuth.auth()?.createUserWithEmail(username!, password: password!, completion: { (user, error) in
            if error != nil{
                //error logging in user
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .Alert)
                
               alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }else{
                // logged in
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("PostvC")
                self.presentViewController(vc!, animated: true, completion: nil)             }

        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

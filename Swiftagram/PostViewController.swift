//
//  PostViewController.swift
//  Swiftagram
//
//  Created by Pavan Powani on 16/12/16.
//  Copyright © 2016 Pavan Powani. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class PostViewController: ViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imageFilename = ""
    
    @IBOutlet var previewImageView: UIImageView!
    @IBOutlet var selectImageButton: UIButton!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectImageTapped(sender: AnyObject) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        self.presentViewController(picker, animated: true, completion: nil)
        
    }
    
    func uploadImage(image: UIImage){
        
        let randomname = randomStringWithLength(10)
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        let uploadRef = FIRStorage.storage().reference().child("images/\(randomname).jpeg")
        let uploadTask = uploadRef.putData(imageData!, metadata: nil) { (metadata, error) in
            if error==nil{
                //success
                print("Successfully uploaded image")
                self.imageFilename = "\(randomname as String).jpeg"
            }else{
                //error
                print("Error uploading image:\(error?.localizedDescription)")
            }
        }
    }
    
    func randomStringWithLength(length: Int) -> NSString{
        let characters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        var randomString: NSMutableString = NSMutableString(capacity: length)
        for i in 0..<length{
            var len = UInt32(characters.length)
            var rand = arc4random_uniform(len)
            randomString.appendFormat("%C", characters.characterAtIndex(Int(rand)))
        }
        return randomString
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        //will run when user presses cancel
        picker.dismissViewControllerAnimated(true, completion: nil)

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //will run when user picks image from photo library
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.previewImageView.image = pickedImage
            self.selectImageButton.hidden = true
            uploadImage(pickedImage)
            picker.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    @IBAction func postTapped(sender: AnyObject) {
        
        if let uid = FIRAuth.auth()?.currentUser?.uid{
            if let title = titleTextField.text{
                if let content = contentTextView.text{
        
                    let postObject: Dictionary<String, AnyObject> = [
                        "uid": uid,
                        "title": title,
                        "content": content,
                        "image": imageFilename
                    ]
        
                    FIRDatabase.database().reference().child("posts").childByAutoId().setValue(postObject)
        
                    let alert = UIAlertController(title: "Success", message:"You post is succesfully uploaded", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)

                    
                    print("Posted to firebase")
      
                    }
                }
            }
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

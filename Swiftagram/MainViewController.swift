//
//  MainViewController.swift
//  Swiftagram
//
//  Created by Pavan Powani on 16/12/16.
//  Copyright © 2016 Pavan Powani. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var postsTableView: UITableView!
    var posts:NSMutableArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postsTableView.dataSource = self
        self.postsTableView.delegate = self
        
        loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadData(){
        FIRDatabase.database().reference().child("posts").observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let postsDictionary = snapshot.value as? [String: AnyObject]{
                for post in postsDictionary{
                    self.posts.addObject(post.1)
                }
                self.postsTableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.posts.count
    }

    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PostTableViewCell
        
        // Configure the cell...
        let post = self.posts[indexPath.row] as! [String: AnyObject]
        print("Post:\(posts)")
        cell.titleLabel.text = post["title"] as? String
        cell.contentTextView.text = post["content"] as? String
        
        if let imageName = post["image"] as? String{
        let imageRef = FIRStorage.storage().reference().child("images/\(imageName)")
        imageRef.dataWithMaxSize(25 * 1024 * 1024, completion: { (data, error) -> Void in
            if error==nil{
                //successful
                let image = UIImage(data: data!)
                cell.postImageView.image = image
                
            }else{
                //error occured
                print("Error downloading image:\(error?.localizedDescription)")
            }
        })
            cell.titleLabel.alpha = 0
            cell.contentTextView.alpha = 0
            cell.postImageView.alpha = 0
            
            UIView.animateWithDuration(0.4, animations:{
                cell.titleLabel.alpha = 1
                cell.contentTextView.alpha = 1
                cell.postImageView.alpha = 1
            })
        }
        
       
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

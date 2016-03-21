//
//  SelectAccountViewController.swift
//  openhoursapp
//
//  Created by Margeaux Spring on 3/20/16.
//  Copyright © 2016 Margeaux Spring. All rights reserved.
//

import UIKit
import Accounts
import Social

class SelectAccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var accounts = [ACAccount]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accounts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let account = self.accounts[indexPath.row]
        cell.textLabel?.text = account.username
        return cell
    }
    
    //selection of account
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let account = self.accounts[indexPath.row]
        let navigationVC = self.presentingViewController as! UINavigationController
        let signInVC = navigationVC.viewControllers[0] as! SignInViewController
        
        self.dismissViewControllerAnimated(true) { () -> Void in
             signInVC.moveToViewControllerWithAccount(account)
            
        }
       
    }
    
}

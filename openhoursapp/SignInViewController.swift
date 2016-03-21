//
//  FirstViewController.swift
//  openhoursapp
//
//  Created by Margeaux Spring on 3/17/16.
//  Copyright © 2016 Margeaux Spring. All rights reserved.
//

import UIKit
import Accounts
import Social

class SignInViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    @IBAction func signInTapped(sender: AnyObject) {
        
        //make acct store
        let account = ACAccountStore()
        let accountTypeTwitter = account.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)

        //ask user if ok to use twitter account for app
        account.requestAccessToAccountsWithType(accountTypeTwitter, options: nil) { (granted :Bool, error :NSError!) -> Void in
            
            if granted{
                let allAccounts = account.accountsWithAccountType(accountTypeTwitter)
                if allAccounts.count <= 0 {
                    print("no accounts")
                } else if allAccounts.count == 1 {
                    dispatch_async(dispatch_get_main_queue()
                        , { () -> Void in
                            self.performSegueWithIdentifier("SecondViewController", sender: allAccounts.first)
                    })
                } else {
                    print("They have more than one, lets ask")
                    dispatch_async(dispatch_get_main_queue()
                        , { () -> Void in
                             self.performSegueWithIdentifier("chooseAccountSegue", sender: allAccounts)
                    })
                   
                }
            } else {
                print("Nah")
            }
        
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "chooseAccountSegue" {
            let selectVC = segue.destinationViewController as! SelectAccountViewController
            selectVC.accounts = sender as! [ACAccount]
        }
        if segue.identifier == "SecondViewController" {
            let secondVC = segue.destinationViewController as! SecondViewController
            secondVC.account = (sender as! ACAccount)
        }
    }
    //move to other VC
    func moveToViewControllerWithAccount(account :ACAccount){
        self.performSegueWithIdentifier("SecondViewController", sender: account)

    }
}


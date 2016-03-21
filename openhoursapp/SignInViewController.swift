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
import TwitterKit



class SignInViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let alert = UIAlertController(title: "Logged In",
                    message: "User \(unwrappedSession.userName) has logged in",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        // TODO: Change where the log in button is positioned in your view
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)

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
                    print("You need a Twitter account to access this info")
                } else if allAccounts.count == 1 {
                    dispatch_async(dispatch_get_main_queue()
                        , { () -> Void in
                            self.performSegueWithIdentifier("SecondViewController", sender: allAccounts.first)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue()
                        , { () -> Void in
                             self.performSegueWithIdentifier("chooseAccountSegue", sender: allAccounts)
                    })
                   
                }
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


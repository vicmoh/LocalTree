//
//  SettingsTabController.swift
//  LocalTreeTesting
//
//  Created by Vic Muham on 2017-02-25.
//  Copyright © 2017 Vicky Mohammad. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth

class SettingsTabController: UIViewController {

    @IBAction func facebookLogout(sender: AnyObject) {
        //signout of firebase database
        try! FIRAuth.auth()?.signOut()
        //signout of facebook database
        FBSDKAccessToken.setCurrent(nil)
        
        //move to login screen
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginPage")
        //present the view controller
        self.present(viewController, animated: false, completion: nil)

    }//end facebook logout button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }//end view did load

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//end recieve memory
    
}//end settingsTabController

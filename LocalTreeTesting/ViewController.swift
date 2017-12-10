//
//  ViewController.swift
//  LocalTreeTesting
//
//  Created by Vicky Mohammad on 2017-01-08.
//  Copyright © 2017 Vicky Mohammad. All rights reserved.
//

//import libraries
import UIKit
import FBSDKLoginKit
import FirebaseAuth

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    //declare a variables
    let facebookLoginButton = FBSDKLoginButton()
    
    //main func for load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide facebook login button
        facebookLoginButton.isHidden = true

        // if user is signed in, move to another screen, if not then don't
        FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            //get current sign-in users for firebase
            if let user = user {
                //move to login screen
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeTab")
                //present the view controller
                self.present(homeViewController, animated: false, completion: nil)
            } else {
                //set the facebook button frame
                let FacebookEdge:CGFloat = 60
                self.facebookLoginButton.frame = CGRect(x: FacebookEdge, y: self.view.frame.height/2, width: self.view.frame.width-(FacebookEdge*2), height: 40)
                //get user permission for user facebook data
                self.facebookLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
                self.facebookLoginButton.delegate = self
                //implement facbook login on the UIView
                self.view.addSubview(self.facebookLoginButton)
                //show the loggin button
                self.facebookLoginButton.isHidden = false
            }//end if user firebase auth
        }//end if user firebase auth
    }//end view did load
    
    //facebook logout view
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of Facebook")
    }//end of facebook log out button
    
    //login result
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        //if log in unsuccessful then
        if error != nil {
            print(error)
            return
        }//end if
        //then if log in is successful
        print("Successfully Logged in with Facebook")
        //add credintial to firebase when facebook login
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                    print("Successfully Logged in Facebook with Firebase")
        }//end firebase user auth
        //open to another segue
        //self.performSegue(withIdentifier: "homeTab", sender: self)
    }//end facebook log in result
    
}//end main view controller


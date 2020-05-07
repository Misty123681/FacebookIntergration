//
//  GoogleSignInManager.swift
//  FacebookIntergration
//
//  Created by Neosoft on 04/05/20.
//  Copyright © 2020 Neosoft. All rights reserved.
//

//https://www.kunshtech.com/blog/beginners-guide-to-integrate-facebook-login-in-swift-ios-app-development/


import Foundation
import GoogleSignIn


class GoogleSignInManager:NSObject,GIDSignInDelegate{
    
    override init() {
        super.init()

        
    }
    
    class func intialiseGoogleSignInFrom(controller view:UIViewController){
        
        
        GIDSignIn.sharedInstance()?.presentingViewController = view

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()

    }
    
    class func googleSignIn(){
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        // ...
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("sign in failed")
    }
}

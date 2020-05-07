//
//  FacebookSignInManager.swift
//  FacebookIntergration
//
//  Created by Neosoft on 30/04/20.
//  Copyright © 2020 Neosoft. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn


class FacebookSignInManager: NSObject {
    
    typealias LoginCompletionBlock = (Dictionary<String, AnyObject>?, NSError?) -> Void
    
    //MARK:- Public functions
    class func basicInfoWithCompletionHandler(_ fromViewController:AnyObject, onCompletion: @escaping LoginCompletionBlock) -> Void {
        
        //Check internet connection if no internet connection then return
        getBaicInfoWithCompletionHandler(fromViewController) { (dataDictionary:Dictionary<String, AnyObject>?, error: NSError?) -> Void in
            onCompletion(dataDictionary, error)
        }
    }
    
    
    //MARK:- Private functions
     class fileprivate func getBaicInfoWithCompletionHandler(_ fromViewController:AnyObject, onCompletion: @escaping LoginCompletionBlock) -> Void {
          let permissionDictionary = [
              "fields": "id,name,first_name,last_name,gender,email,birthday,picture.type(large)"
          ]
          if AccessToken.current != nil {
              GraphRequest(graphPath: "/me", parameters: permissionDictionary)
                  .start(completionHandler:  { (connection, result, error) in
                      if error == nil {
                          onCompletion(result as? Dictionary<String, AnyObject>, nil)
                      } else {
                          onCompletion(nil, error as NSError?)
                      }
                  })
              
          } else {
              
              LoginManager().logIn(permissions: ["public_profile", "email"], from: fromViewController as? UIViewController, handler: { (result, error) -> Void in
                  if error != nil {
                      LoginManager().logOut()
                      if let error = error as NSError? {
                          let errorDetails = [NSLocalizedDescriptionKey : "Processing Error. Please try again!"]
                          let customError = NSError(domain: "Error!", code: error.code, userInfo: errorDetails)
                          onCompletion(nil, customError)
                      } else {
                          onCompletion(nil, error as NSError?)
                      }
                      
                  } else if (result?.isCancelled)! {
                      LoginManager().logOut()
                      let errorDetails = [NSLocalizedDescriptionKey : "Request cancelled!"]
                      let customError = NSError(domain: "Request cancelled!", code: 1001, userInfo: errorDetails)
                      onCompletion(nil, customError)
                  } else {
                      let pictureRequest = GraphRequest(graphPath: "/me", parameters: permissionDictionary)
                      let _ = pictureRequest.start(completionHandler: {
                          (connection, result, error) -> Void in
                          
                          if error == nil {
                              onCompletion(result as? Dictionary<String, AnyObject>, nil)
                          } else {
                              onCompletion(nil, error as NSError?)
                          }
                      })
                  }
              })
          }
      }
      
      
    
    
    
    class func logoutFromApp() {
        LoginManager().logOut()
        AccessToken.current = nil
        Profile.current = nil
        GIDSignIn.sharedInstance().signOut()
    }
}

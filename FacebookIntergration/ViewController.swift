//
//  ViewController.swift
//  FacebookIntergration
//
//  Created by Neosoft on 30/04/20.
//  Copyright © 2020 Neosoft. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn






class ViewController: UIViewController {
    
    @IBOutlet weak var btnGooglesignIn: UIButton!
    
    @IBAction func BtnGoogleSignIn(_ sender: Any) {
        
        GoogleSignInManager.googleSignIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GoogleSignInManager.intialiseGoogleSignInFrom(controller: self)
    }
    
    @IBAction func btnFbLogin(_ sender: Any) {
        FacebookSignInManager.basicInfoWithCompletionHandler(self) { (info, error) in
            print(info)
            guard let info = info ,error == nil else{
                return
            }
            let model = FacebookInfo(info: info)
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FbDetailsViewController") as! FbDetailsViewController
            nextViewController.fb = model
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
        
    }
    
    @IBAction func btnLogout(_ sender: Any) {
        FacebookSignInManager.logoutFromApp()
    }
    
    
    
    
}


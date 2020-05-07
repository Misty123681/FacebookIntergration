//
//  FacebookInfo.swift
//  FacebookIntergration
//
//  Created by Neosoft on 04/05/20.
//  Copyright © 2020 Neosoft. All rights reserved.
//

import Foundation

struct FacebookInfo{
    let url :String
    let firstName : String
    let lastName : String
    let email :String
    let id  : String
    
    init (info:Dictionary<String,AnyObject>){
        let profile  = info["picture"] as? [String:Any]
        let data = profile?["data"] as? [String:Any]
        url = data?["url"] as? String ?? ""
        firstName = info["first_name"] as? String ?? ""
        lastName = info["last_name"] as? String ?? ""
        email = info["email"] as? String ?? ""
        id = info["id"] as? String ?? ""
    }
    
    
}

//struct facebookInfoViewModel {
//    let fbInfo :FacebookInfo
//    init(fbInfo:FacebookInfo) {
//        self.fbInfo = fbInfo
//    }
//
//}
//
//extension facebookInfoViewModel{
//
//}

//
//  FbDetailsViewController.swift
//  FacebookIntergration
//
//  Created by Neosoft on 04/05/20.
//  Copyright © 2020 Neosoft. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKLoginKit
import FBSDKCoreKit

class FbDetailsViewController: UIViewController ,SharingDelegate{
    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        print(results)
    }
    
    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        print(error)
    }
    
    func sharerDidCancel(_ sharer: Sharing) {
        print("cancel")
    }
    
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var fName: UILabel!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var emial: UILabel!
    
    var fb : FacebookInfo? = nil
    
    @IBAction func btnShare(_ sender: Any) {
       // let linkShareContent = ShareLinkContent()
        
        //linkShareContent.contentURL  = URL(string:"https://developers.facebook.com/docs/swift/sharing/message-dialog")!
       // linkShareContent.quote = "This is my test post url"
        
        let photo = SharePhoto(image: UIImage(named: "2")!, userGenerated: true)
        let sharePhoto = SharePhotoContent()
        sharePhoto.photos = [photo]
       // sharePhoto.ref = "Test images"
        let dialog = ShareDialog(fromViewController: self, content: sharePhoto, delegate: self)
        dialog.mode = .browser
        dialog.show()
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            
            self.fName.text = self.fb?.firstName
            self.lName.text = self.fb?.lastName
            self.id.text = self.fb?.id
            self.emial.text = self.fb?.email
            do{
                let data = try Data(contentsOf: URL(string: self.fb?.url ?? "")!)
                self.imgProfile.image = UIImage(data: data)
            }catch{
                print(error)
            }
        
        }
    }
    

    

}

//
//  TelaInicialViewController.swift
//  Houd
//
//  Created by Erik Martins on 10/08/16.
//  Copyright © 2016 Erik Martins. All rights reserved.
//

import UIKit

class TelaInicialViewController: UIViewController {
    
    var toPass: String!

    @IBOutlet var lblWelcome: UILabel!
    @IBOutlet var lblStatus: UILabel!
   
    @IBAction func btnLogout(sender: AnyObject) {
        
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
    }
    
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        lblStatus.text = toPass
        
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, relationship_status"]).startWithCompletionHandler({ (connection, result, error) -> Void in
            if (error == nil){
                //let fbDetails = result as! NSDictionary
                //print(fbDetails)
                self.lblWelcome.text = result.valueForKey("first_name") as? String
            }
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

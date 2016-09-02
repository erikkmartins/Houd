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
    
    let defaults = `NSUserDefaults`.standardUserDefaults()

    @IBOutlet var lblDefaults: UILabel!

    @IBOutlet var lblStatus: UILabel!
   
    @IBAction func btnLogout(sender: AnyObject) {
        
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()

        self.defaults.setObject(false, forKey: "statusAutentica")
        self.defaults.synchronize()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
   
        lblStatus.text = toPass
        
        lblDefaults.text = defaults.objectForKey("name") as? String
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = true
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

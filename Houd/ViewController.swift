//
//  ViewController.swift
//  Houd
//
//  Created by Erik Martins on 10/08/16.
//  Copyright © 2016 Erik Martins. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

class ViewController: UIViewController {
    var TelaInicial: TelaInicialViewController?
    //var statusAutentica: Bool = false
    var urlWS: String! = "http://192.168.1.31:7171" //URL base para pesquisa de estabelecimentos
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtSenha: UITextField!
      @IBOutlet var fbImage: UIImageView!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
   
    }
  
    
    
    
    @IBAction func btnLogin(sender: AnyObject) {
       
        if let email = txtEmail.text,
            let password = txtSenha.text {
            let parameters = [
                "email": email,
                "senha": password
            ]
            
            self.defaults.setObject(email, forKey: "email")
            self.defaults.synchronize()
            
            let url = "\(urlWS)\("/login")"
            
            
            Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON) .responseJSON { response in
                //let value = response.result.value!
                
                if response.result.value?.stringValue == "1" {
                     self.performSegueWithIdentifier("telaAutentica", sender: self)
                }
            }
        }
    
    }


  
    @IBAction func btnRegistrar(sender: AnyObject) { /*code*/    }

    @IBAction func loginFacebookAction(sender: AnyObject) {
       

        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logInWithReadPermissions(["public_profile" , "email"], fromViewController: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                if result.isCancelled{
                    print("Autenticação cancelada")
                    
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, gender, age_range,  email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result)
                    
                    self.defaults.setObject(result.valueForKey("email") as? String, forKey: "email")
                    self.defaults.setObject(result.valueForKey("id") as? String, forKey: "passtoken")
                    self.defaults.setObject(true, forKey: "statusAutentica")
                    self.defaults.synchronize()
                   
                    
                    
                }
            })
        }
    }
    

    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Loged out...")
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    override func viewDidAppear(animated: Bool){
        if (FBSDKAccessToken.currentAccessToken() != nil || defaults.objectForKey("statusAutentica") as? Bool == true)
        {
        self.performSegueWithIdentifier("telaAutentica", sender: self)
    }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "telaAutentica" {
            
            
            
            TelaInicial = segue.destinationViewController as? TelaInicialViewController
            
            TelaInicial!.toPass = "Autenticado!"
            
        }
    }

}


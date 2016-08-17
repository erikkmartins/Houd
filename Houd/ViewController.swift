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



class ViewController: UIViewController {
    var TelaInicial: TelaInicialViewController?
    var statusAutentica: Bool = false
    var urlWS: String! = "http://localhost:7171/login" //URL base para pesquisa de estabelecimentos
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtSenha: UITextField!
    let defaults = NSUserDefaults.standardUserDefaults()
       @IBAction func unwindToVC(segue: UIStoryboardSegue) {}
    
    @IBAction func btnLogin(sender: AnyObject) {
       
        if let email = txtEmail.text, let password = txtSenha.text {
            let parameters = [
                "email": email,
                "senha": password
            ]
            
            Alamofire.request(.POST, urlWS, parameters: parameters, encoding: .JSON) .responseJSON { response in
                //let value = response.result.value!
                
                if response.result.value?.stringValue == "1" {
                     self.performSegueWithIdentifier("telaAutentica", sender: self)
                }
            }
        }
        
       
        
        
        
        
    }


  
    @IBAction func btnRegistrar(sender: AnyObject) {
        
        self.performSegueWithIdentifier("telaRegistro", sender:self)

    }

    @IBAction func loginFacebookAction(sender: AnyObject) {
        

        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logInWithReadPermissions(["email"], fromViewController: self) { (result, error) -> Void in
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
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result)
                    self.performSegueWithIdentifier("telaAutentica", sender:self)
                }
            })
        }
    }
    
//    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
//        
//        
//        if (FBSDKAccessToken.currentAccessToken() == nil)
//        {
//            //print(error.localizedDescription)
//            print("login failure")
//            
//        }
//        else
//        {
//            print("login completed...")
//            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, relationship_status"]).startWithCompletionHandler({ (connection, result, error) -> Void in
//                if (error == nil){
//                    //self.txtUser.text = result.valueForKey("name") as? String
//                    //self.txtPass.text = result.valueForKey("id") as? String
//                    //self.validaUser(self.txtUser.text!, senha: self.txtPass.text!)
//                }
//            })
//            self.performSegueWithIdentifier("telaAutentica", sender:self)
//            
//        }
//    }
    
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Loged out...")
    }
    

    @IBOutlet var fbImage: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
//
//        if (FBSDKAccessToken.currentAccessToken() == nil) {
//            print("Not loged in..")
//        } else {
//            print("Loged in...")
//            self.performSegueWithIdentifier("telaAutentica", sender:self)
//        }
//        
//        
//        let loginButton = FBSDKLoginButton()
//        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
//        loginButton.center = self.view.center
//        loginButton.delegate = self
//        
//        self.view.addSubview(loginButton)
//        
        

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


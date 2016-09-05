//
//  TelaViewAlerg.swift
//  Houd
//
//  Created by Isabelle lecrer on 30/04/16.
//  Copyright © 2016 Pick any. All rights reserved.
//


import UIKit
import Foundation

class ViewConstrollerMostraCadastroRestaurante: UIViewController, UITextFieldDelegate {
    
    //Botões  e textos auxiliares da tela
    @IBOutlet weak var infoVenue: UILabel!
    @IBOutlet weak var infoStreet: UILabel!
    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtLactose: UILabel!
    @IBOutlet weak var txtGluten: UILabel!
    @IBOutlet weak var txtFrutosMar: UILabel!
    @IBOutlet weak var txtFructose: UILabel!
    @IBOutlet weak var txtCondimentos: UILabel!

    @IBOutlet weak var btnLactose: UISwitch!
    @IBOutlet weak var btnGluten: UISwitch!
    @IBOutlet weak var btnFrutosMar: UISwitch!
    @IBOutlet weak var btnFructose: UISwitch!
    @IBOutlet weak var btnCondimentos: UISwitch!
    
    var listaIntolerancia = [String]()
    var textoVenue:String = ""
    var textoStreet: String = ""
    var textoPostal: String = ""
    var textoCity: String = ""
    var textoState: String = ""
    var textoCountry: String = ""
   // var wsServer: String = "http://191.254.55.107:7171/checkin"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        infoVenue.text = textoVenue
        infoStreet.text = textoStreet
    
       
       // self.txtUsuario.delegate = self;
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool //função para esconder o teclado ao pressionar Return
    {
        textField.resignFirstResponder()
        return true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func actionEdit(sender: AnyObject) {
          let url = "\(urlWS)\("/checkin")"
        let headers = [
            "cache-control": "no-cache",
            "postman-token": "696e9c8e-5006-a112-b961-c157829dcdc5",
            "content-type": "application/x-www-form-urlencoded"
        ]
        
        //Captura dos valores dos switchers
        if self.btnCondimentos.on{self.listaIntolerancia.append("Condimentos")}
        if self.btnFructose.on{self.listaIntolerancia.append("Fructose")}
        if self.btnFrutosMar.on{self.listaIntolerancia.append("Frutos do Mar")}
        if self.btnGluten.on{self.listaIntolerancia.append("Gluten")}
        if self.btnLactose.on{self.listaIntolerancia.append("Lactose")}
        
        //if txtUsuario.text == "" {
         //   txtUsuario.text = "Anônimo"
        
        //let nome = "&nome=Anônimo" + txtUsuario.text!;
        let nome = "&nome=Anônimo";
        
        //Laço responsável pelo cadastro de todas as possibilidades de intolerância
       for(var i = 0; i < self.listaIntolerancia.count ; i += 1 ){
            let postData = NSMutableData(data: nome.dataUsingEncoding(NSUTF8StringEncoding)!)
            postData.appendData("&intolerancia=".dataUsingEncoding(NSUTF8StringEncoding)!)
            postData.appendData((self.listaIntolerancia[i]).dataUsingEncoding(NSUTF8StringEncoding)!)
            postData.appendData("&restaurante=".dataUsingEncoding(NSUTF8StringEncoding)!)
            postData.appendData((self.textoVenue).dataUsingEncoding(NSUTF8StringEncoding)!)
            postData.appendData("&endereco=".dataUsingEncoding(NSUTF8StringEncoding)!)
            postData.appendData((self.textoStreet).dataUsingEncoding(NSUTF8StringEncoding)!)
            postData.appendData("&cep=".dataUsingEncoding(NSUTF8StringEncoding)!)
            postData.appendData((self.textoPostal).dataUsingEncoding(NSUTF8StringEncoding)!)
            postData.appendData("&cidade=".dataUsingEncoding(NSUTF8StringEncoding)!)
            postData.appendData((self.textoCity).dataUsingEncoding(NSUTF8StringEncoding)!)
            postData.appendData("&estado=".dataUsingEncoding(NSUTF8StringEncoding)!)
            postData.appendData((self.textoState).dataUsingEncoding(NSUTF8StringEncoding)!)
            postData.appendData("&pais=".dataUsingEncoding(NSUTF8StringEncoding)!)
            postData.appendData((self.textoCountry).dataUsingEncoding(NSUTF8StringEncoding)!)
            
            let request = NSMutableURLRequest(URL: NSURL(string: url)!,
                cachePolicy: .UseProtocolCachePolicy,
                timeoutInterval: 10.0)
            request.HTTPMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.HTTPBody = postData
            
            let session = NSURLSession.sharedSession()
            let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error)
                    
                    let alertController = UIAlertController(title: "Erro!", message: "Entre em contato com o administrador do sistema!", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "Ok", style: .Default) { (action) in
                        self.listaIntolerancia.removeAll()
                    }
                    
                    alertController.addAction(OKAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                } else {
                    let httpResponse = response as? NSHTTPURLResponse
                    print(httpResponse)
                    
                    let alertController = UIAlertController(title: "Sucesso!", message: "Informações enviadas com sucesso!", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "Ok", style: .Default) { (action) in
                        self.listaIntolerancia.removeAll()
                    }
                    
                    alertController.addAction(OKAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                }
            })
            print(self.listaIntolerancia[i])
            dataTask.resume()
        
        }
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }
 
    @IBAction func switchChange(sender: AnyObject) {

    }
}

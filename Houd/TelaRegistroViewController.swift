//
//  TelaRegistro.swift
//  Houd
//
//  Created by Erik Martins on 14/08/16.
//  Copyright © 2016 Erik Martins. All rights reserved.
//

import UIKit
import Alamofire

class TelaRegistroViewController: UIViewController {

    @IBOutlet var txtNome: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtSenha: UITextField!
    @IBOutlet var txtConfirma: UITextField!
    @IBOutlet var segSexo: UISegmentedControl!
    @IBOutlet var txtDataNascimento: UITextField!
    @IBOutlet var dataPicker: UIDatePicker!
    let dateFormatter = NSDateFormatter()
    let timeFormatter = NSDateFormatter()
    var segValue: String! = "M"
    var urlWS: String! = "http://localhost:7171" //URL base para pesquisa de estabelecimentos
    var vw: ViewController?
    
    @IBAction func segChanged(sender: AnyObject) {
        switch segSexo.selectedSegmentIndex
        {
        case 0:
            self.segValue = "M";
        case 1:
            self.segValue = "F";
        default:
            break; 
        } 
    }
    

    
    @IBAction func btnConfirma(sender: AnyObject) {
        let url = "\(urlWS)\("/register")"

        if  let nome = txtNome.text,
            let email = txtEmail.text,
            let senha = txtSenha.text,
            let sexo = self.segValue,
            let data = txtDataNascimento.text{
            
            let dateFormater = NSDateFormatter()
            dateFormater.dateFormat = "yyyy-MM-dd"
            
            let calendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
            
            let getdate: NSDate! = NSDate()
            let dataAniversario = dateFormater.dateFromString(txtDataNascimento.text!)
            let calcIdade = calendar.components(.Year, fromDate: dataAniversario!, toDate: getdate, options: [])
            let idade = calcIdade.year

            
            let parameters = [
                "nome": nome,
                "email": email,
                "idade": idade.description,
                "senha": senha,
                "sexo":  sexo,
                "datanascimento": data
            ]
            print(parameters)
            
            Alamofire.request(.PUT, url, parameters: parameters, encoding: .JSON) .responseJSON { response in
                //let value = response.result.value!
                print(response)
                            if response.result.value?.stringValue == "0" {
                                let msg = "Usuario já existe! \n Esqueceu sua senha? Contate o suporte."
                                
                                let alerta = UIAlertController(title: "Aviso", message: msg, preferredStyle: .Alert)
                                
                                alerta.addAction(UIAlertAction(
                                    title: "Ok",
                                    style: .Default,
                                    handler: nil)
                                )
                                self.presentViewController(alerta, animated: true, completion: nil)
                            } else {
                                let msg = "Usuário registrado!"
                                
                                let alerta = UIAlertController(title: "Aviso", message: msg, preferredStyle: .Alert)
                                
                                alerta.addAction(UIAlertAction(
                                    title: "Ok",
                                    style: .Default,
                                    handler: nil)
                                )
                                self.presentViewController(alerta, animated: true, completion: nil)
                                
                }
            }
        } else {
        let msg = "Preencha todos os campos!"
        
        let alerta = UIAlertController(title: "Aviso", message: msg, preferredStyle: .Alert)
        
        alerta.addAction(UIAlertAction(
            title: "Ok",
            style: .Default,
            handler: nil)
        )
        presentViewController(alerta, animated: true, completion: nil)
        }
    }
    

    @IBAction func dataNasc(sender: AnyObject) {
        dataPicker.hidden = false
    }
 

    @IBAction func dataChanged(sender: AnyObject) {
    
        setDateAndTime()
    }
    
    
    override func viewDidLoad() {
        self.dataPicker.hidden = true
        self.hideKeyboardWhenTappedAround()
    
    }
    
    func setDateAndTime() {
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        txtDataNascimento.text = dateFormatter.stringFromDate(dataPicker.date)
    }
    
}

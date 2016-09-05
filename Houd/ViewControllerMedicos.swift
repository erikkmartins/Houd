//
//  ViewControllerMedicos.swift
//  Houd
//
//  Created by Isabelle lecrer on 04/09/16.
//  Copyright © 2016 Pick any. All rights reserved.
//

import UIKit
import Alamofire


import Foundation
import SwiftyJSON

class ViewControllerMedicos: UIViewController {

    @IBOutlet weak var txtEstadoMedico: UITextField!
    @IBOutlet weak var txtCidadeMedico: UITextField!
    @IBOutlet weak var txtNomeMedico: UITextField!
    @IBOutlet weak var txtLogradouroMedico: UITextField!
    
    //let JSON
    var NomeMedico: [String] = []
    var LogradouroMedico: [String] = []
    var CidadeMedico: [String] = []
    var EstadoMedico: [String] = []
    
    
    var teste : String = ""
    
    var textoNomeMedico: String = ""
    var textoLogradouroMedico: String = ""
    var textoCidadeMedico: String = ""
    var textoEstadoMedico: String = ""
    
   // var urlWS: String! = "http://houdapp.ddns.net:7171" //URL base para pesquisa de estabelecimentos

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func PesquisarMedico(sender: AnyObject) {
        
    print("teste")
    
    
    textoNomeMedico = txtNomeMedico.text!
    textoLogradouroMedico = txtLogradouroMedico.text!
    textoCidadeMedico = txtCidadeMedico.text!
    textoEstadoMedico = txtEstadoMedico.text!
    
    
    let parameters = [
        "Nome": textoNomeMedico,
        "Logradouro": textoLogradouroMedico,
        "Cidade": textoCidadeMedico,
        "Estado": textoEstadoMedico
        
    ]
    
    
    let url = "\(urlWS)\("/pesquisa")"
    
    
    Alamofire.request(.POST, url, parameters:(parameters as! [String: String]), encoding: .JSON) .responseJSON
        { response in
    
    var json = JSON(response.result.value!)
    //var json = JSON()
            
    var bairro: String = "";
    print(json)
    
    
    for (key, subJson) in json[0] {
    self.teste = subJson["NomeMedico"].stringValue
    
    print (self.teste)
    self.NomeMedico.append(subJson["NomeMedico"].stringValue)
    self.LogradouroMedico.append(subJson["LogradouroMedico"].stringValue)
    self.CidadeMedico.append(subJson["CidadeMedico"].stringValue)
    self.EstadoMedico.append(subJson["EstadoMedico"].stringValue)
    
    
    //print(subJson["CodRestaurante"].stringValue)
    
    }
    //print(self.NomeRestaurante)
    
    
    self.performSegueWithIdentifier("segueTelaMedico", sender: self)
    
    }
    
}

override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    
    
    let t = segue.destinationViewController as! TableViewControllerMedico
    
    //t.nomeRestaurante = self.NomeRestaurante;
    //t.estadoEndereco = self.EstadoEndereco;
    //t.codIntoleranciaAlimentar = self.CodIntoleranciaAlimentar;
    //t.paisEndereco = self.PaisEndereco;

    
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

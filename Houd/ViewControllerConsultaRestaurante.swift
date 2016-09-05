//
//  Teste.swift
//  Houd
//
//  Created by Isabelle lecrer on 21/08/16.
//  Copyright © 2016 Pick any. All rights reserved.
//

import UIKit
import Foundation

import Alamofire
import SwiftyJSON

class ViewControllerConsultaRestaurante: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var txtRestaurante: UITextField!
    @IBOutlet weak var txtLogradouro: UITextField!
    @IBOutlet weak var txtCidade: UITextField!
    @IBOutlet weak var txtEstado: UITextField!
    @IBOutlet weak var PickerRestricao: UITextField!
    
    //let JSON1
    
    var EstadoEndereco: [String] = []
    var NomeRestaurante: [String] = []
    var CodIntoleranciaAlimentar: [Int] = []
    var PaisEndereco: [String] = []
    var BairroEndereco: [String] = []
    var complementoEndereco: [String] = []
    var CidadeEndereco: [String] = []
    var CodEndereco: [Int] = []
    var NomeIntolerancia: [String] = []
    var CodRestaurante: [Int] = []
    var NumeroEndereco: [Int] = []
    var LogradouroEndereco: [String] = []
    var CEPEndereco: [Int] = []
    
    
    var teste : String = ""
    
    //var wsServer: String = "http://201.95.84.164:7171/pesquisa"
    
    var urlWS: String! = "http://houdapp.ddns.net:7171" //URL base para pesquisa de estabelecimentos
    
    
    var pickOption = ["Todos","Lactose","Gluten"]
    
    var textoRestaurante: String = ""
    var textoLogradouro: String = ""
    var textoCidade: String = ""
    var textoEstado: String = ""
    var restricao: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        
        PickerRestricao.inputView = pickerView
        
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.BlackTranslucent
        
        toolBar.tintColor = UIColor.whiteColor()
        
        toolBar.backgroundColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 114, alpha: 1)
        
        
        //let defaultButton = UIBarButtonItem(title: "Default", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(Teste.tappedToolBarBtn))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(ViewControllerConsultaRestaurante.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clearColor()
        
        label.textColor = UIColor.whiteColor()
        
        label.text = "Escolha uma opcao"
        
        label.textAlignment = NSTextAlignment.Center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([flexSpace,textBtn,flexSpace,doneButton], animated: true)
        
        PickerRestricao.inputAccessoryView = toolBar
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func donePressed(sender: UIBarButtonItem) {
        
        PickerRestricao.resignFirstResponder()
        
    }
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        PickerRestricao.text = "one"
        
        PickerRestricao.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        PickerRestricao.text = pickOption[row]
    }
    
    @IBAction func Pesquisar(sender: AnyObject) {
        print("teste")
        
        
        textoRestaurante = txtRestaurante.text!
        textoLogradouro = txtLogradouro.text!
        textoCidade = txtCidade.text!
        textoEstado = txtEstado.text!
        
        
        if (PickerRestricao.text == "Gluten"){
            restricao = 2
        }else if (PickerRestricao.text == "Lactose"){
            restricao = 1
        }else{
            restricao = 0
        }
        
        let parameters = [
            "Restaurante": textoRestaurante,
            "Logradouro": textoLogradouro,
            "Cidade": textoCidade,
            "Estado": textoEstado,
            "TipoRestricao": restricao
            
        ]
        
        
        let url = "\(urlWS)\("/pesquisa")"

            
        Alamofire.request(.POST, url, parameters:(parameters as! [String: AnyObject]), encoding: .JSON) .responseJSON            { response in
            
            var json = JSON(response.result.value!)
           
                var bairro: String = "";
                print(json)
      
            
            for (key, subJson) in json[0] {
                self.teste = subJson["CodRestaurante"].stringValue
                
                print (self.teste)
                self.EstadoEndereco.append(subJson["EstadoEndereco"].stringValue)
                self.NomeRestaurante.append(subJson["NomeRestaurante"].stringValue)
                self.CodIntoleranciaAlimentar.append(subJson["CodIntoleranciaAlimentar"].intValue)
                self.PaisEndereco.append(subJson["PaisEndereco"].stringValue)
                self.BairroEndereco.append(subJson["BairroEndereco"].stringValue)
                self.complementoEndereco.append(subJson["complementoEndereco"].stringValue)
                self.CidadeEndereco.append(subJson["CidadeEndereco"].stringValue)
                self.CodEndereco.append(subJson["CodEndereco"].intValue)
                self.NomeIntolerancia.append(subJson["NomeIntolerancia"].stringValue)
                self.CodRestaurante.append(subJson["CodRestaurante"].intValue)
                self.NumeroEndereco.append(subJson["NumeroEndereco"].intValue)
                self.LogradouroEndereco.append(subJson["LogadouroEndereco"].stringValue)
                self.CEPEndereco.append(subJson["CEPEndereco"].intValue)
                
                //print(subJson["CodRestaurante"].stringValue)
                
            }
            print(self.NomeRestaurante)
            
            
            self.performSegueWithIdentifier("segueTela", sender: self)

        }
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        let t = segue.destinationViewController as! TableViewControllerConsultaRestaurante
        
        t.nomeRestaurante = self.NomeRestaurante;
        t.estadoEndereco = self.EstadoEndereco;
        t.codIntoleranciaAlimentar = self.CodIntoleranciaAlimentar;
        t.paisEndereco = self.PaisEndereco;
        t.bairroEndereco = self.BairroEndereco;
        t.complementoEndereco = self.complementoEndereco;
        t.cidadeEndereco = self.CidadeEndereco;
        t.codEndereco = self.CodEndereco;
        t.nomeIntolerancia = self.NomeIntolerancia;
        t.codRestaurante = self.CodRestaurante;
        t.numeroEndereco = self.NumeroEndereco;
        t.logradouroEndereco = self.LogradouroEndereco;
        t.CEPEndereco = self.CEPEndereco;
        
        
    }

    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }
    
}
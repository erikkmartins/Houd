//
//  PesProdutoViewController.swift
//  Houd
//
//  Created by Erik Martins on 29/08/16.
//  Copyright © 2016 Erik Martins. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class PesProdutoViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var jsonProduto: JSON = []
    var TelaProdutoDetalhe : ProdutoDetalheViewController?
    var nomeProduto: String?
    var marcaProduto: String?
    
    @IBAction func returnKey(sender: AnyObject) {
        self.view.endEditing(true)
        pesquisaProdutos()
    }
   

    
    @IBOutlet var tbView: UITableView!
    @IBOutlet var txtBox: UITextField!
    
    func pesquisaProdutos() {
        
        let parameters = [
            "PesquisaProduto": "\("%")\(txtBox.text!.uppercaseString)\("%")"
        ]
        
        // print(parameters)
        
        let url = "\(urlWS)\("/pesproduto")"
        
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON) .responseJSON { response in
            
            if response.result.value?.stringValue != "0" {
                self.jsonProduto = JSON(response.result.value!)
        //            print(self.jsonProduto)
   
            }
           
          self.tbView.reloadData()
        }
        
    }
   
    
    
    @IBAction func btnPesquisar(sender: AnyObject) {
        pesquisaProdutos()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   self.hideKeyboardWhenTappedAround()
        pesquisaProdutos()
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonProduto.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        celula.textLabel?.text = self.jsonProduto[indexPath.row]["NomeProduto"].stringValue
        celula.detailTextLabel?.text = self.jsonProduto[indexPath.row]["FabricanteProduto"].stringValue
       return celula
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print("Selecionou o indice\(indexPath.row)")
        self.nomeProduto = self.jsonProduto[indexPath.row]["NomeProduto"].stringValue
        self.marcaProduto = self.jsonProduto[indexPath.row]["FabricanteProduto"].stringValue
        self.performSegueWithIdentifier("TelaProdutoDetalhe", sender: self)
        tbView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        
        self.navigationController?.navigationBarHidden = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       //
        if segue.identifier == "TelaProdutoDetalhe" {
            
            
            
            TelaProdutoDetalhe = segue.destinationViewController as? ProdutoDetalheViewController
            
            TelaProdutoDetalhe!.produto = self.nomeProduto
            TelaProdutoDetalhe!.marca = self.marcaProduto
            
        }
        
    }
 
    
    

}

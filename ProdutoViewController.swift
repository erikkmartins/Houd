//
//  ProdutoViewController.swift
//  Houd
//
//  Created by Erik Martins on 26/08/16.
//  Copyright © 2016 Erik Martins. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProdutoViewController: UIViewController {
    @IBOutlet var lblProduto: UILabel!
    @IBOutlet var lblMarca: UILabel!
    @IBOutlet var imgProduto: UIImageView!
    @IBOutlet var btnCadastrar: UIButton!
    
    @IBAction func btnScan(sender: AnyObject) {
        btnCadastrar.enabled = true
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

    
    @IBAction func btnCadastrarClicked(Sender:UIButton) {
        
           
        let url = "\(urlWS)\("/regproduto")"
        
        let parameters = [
            "NomeProduto": DataService.dataService.nomeProduto,
            "FabricanteProduto": DataService.dataService.marcaProduto,
            "CodigoDeBarrasProduto": DataService.dataService.codigoBarras
            
        ]
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON) .responseJSON { response in
            //let value = response.result.value!
            
            if response.result.value?.stringValue != "0" {
               print("Produto Cadastrado!")
            } else { print("Produto já existe!")
        }
        }
        
            // Let the user know we've found something.
            
            let alert = UIAlertController(title: "Atenção!", message: "Seu cadastro foi submetido para avaliação!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { action in
                
               //code
                
                self.navigationController?.popViewControllerAnimated(true)
            }))
            
            
           self.presentViewController(alert, animated: true, completion: nil)
            
        
        
        
       btnCadastrar.enabled = false
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProdutoViewController.setLabels(_:)), name: "ProdutoNotificacao", object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
        
    }

    func setLabels(notification: NSNotification){
        
        // Use the data from DataService.swift to initialize the Album.
        
        let productInfo = Produto(
            nomeProduto: DataService.dataService.nomeProduto,
            marcaProduto: DataService.dataService.marcaProduto,
            imagemProduto: DataService.dataService.imagemProduto,
            codigoBarras: DataService.dataService.codigoBarras)
        
        lblProduto.text = "\(productInfo.nome)"
        lblMarca.text = "\(productInfo.marca)"
        

        
        imgProduto.image =
            NSURL(string: productInfo.imagemURL)
                .flatMap { NSData(contentsOfURL: $0) }
                .flatMap { UIImage(data: $0) }
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }
    
}

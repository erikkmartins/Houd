//
//  ProdutoDetalheViewController.swift
//  Houd
//
//  Created by Erik Martins on 01/09/16.
//  Copyright © 2016 Erik Martins. All rights reserved.
//

import UIKit

class ProdutoDetalheViewController: UIViewController {
    @IBOutlet var lblProduto: UILabel!
    @IBOutlet var lblMarca: UILabel!

    
    var produto: String?
    var marca: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblProduto.text = produto
        lblMarca.text = marca

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

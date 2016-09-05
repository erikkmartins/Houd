//
//  ViewConsultRestaurant.swift
//  Houd
//
//  Created by Isabelle lecrer on 14/08/16.
//  Copyright © 2016 Pick any. All rights reserved.
//

import UIKit
import Foundation

class ViewControllerMostraConsultaRestaurante: UIViewController {
    
    @IBOutlet weak var txtNomeRestaurante: UILabel!
    @IBOutlet weak var txte: UILabel!
    @IBOutlet weak var txtLogradouroRestaurante: UILabel!
    
    var nomeRestaurante: String = ""
    var nomeRestaurante2: String = ""
    var estadoEndereco: String = ""
    var codIntoleranciaAlimentar: Int = 0
    var paisEndereco: String = ""
    var bairroEndereco: String = ""
    var complementoEndereco: String = ""
    var cidadeEndereco: String = ""
    var codEndereco: Int = 0
    var nomeIntolerancia: String = ""
    var codRestaurante: Int = 0
    var numeroEndereco: Int = 0
    var logradouroEndereco: String = ""
    var CEPEndereco: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtNomeRestaurante.text = nomeRestaurante;
        txtLogradouroRestaurante.text = logradouroEndereco;
        txte.text = nomeIntolerancia;
        
        //txte.text = String(codRestaurante);
        
        //imagem.image = UIImage(named: imagem2);
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

//
//  ListConsultRestaurantController.swift
//  Houd
//
//  Created by Isabelle lecrer on 14/08/16.
//  Copyright © 2016 Pick any. All rights reserved.
//

import UIKit
import CoreLocation

class TableViewControllerConsultaRestaurante: UITableViewController {

    //var ConsultaRestaurante: ConsultaRestaurantes!
    
    //var teste: [String] = ["Teste1","Teste2","Teste3"];
    
    var nomeRestaurante: [String] = []
    var nomeRestaurante2: [String] = []
    var estadoEndereco: [String] = []
    var codIntoleranciaAlimentar: [Int] = []
    var paisEndereco: [String] = []
    var bairroEndereco: [String] = []
    var complementoEndereco: [String] = []
    var cidadeEndereco: [String] = []
    var codEndereco: [Int] = []
    var nomeIntolerancia: [String] = []
    var codRestaurante: [Int] = []
    var numeroEndereco: [Int] = []
    var logradouroEndereco: [String] = []
    var CEPEndereco: [Int] = []
    
    var indice: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.nomeRestaurante2 = nomeRestaurante;
    }

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nomeRestaurante2.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        indice = indexPath.row;
        
        self.performSegueWithIdentifier("segueRestaurante", sender: self)
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier: String = "reuseIdentifier"
        
        let cell2: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        cell2.textLabel?.text = nomeRestaurante2[indexPath.row]
        cell2.detailTextLabel?.text = logradouroEndereco[indexPath.row]
        
        return cell2
    }
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            let next = segue.destinationViewController as! ViewControllerMostraConsultaRestaurante
       
            next.nomeRestaurante = self.nomeRestaurante2[indice];
            next.logradouroEndereco = self.logradouroEndereco[indice];
            next.nomeIntolerancia = self.nomeIntolerancia[indice];
            next.estadoEndereco = self.estadoEndereco[indice];
            next.codIntoleranciaAlimentar = self.codIntoleranciaAlimentar[indice];
            next.paisEndereco = self.paisEndereco[indice];
            next.bairroEndereco = self.paisEndereco[indice];
            next.complementoEndereco = self.complementoEndereco[indice];
            next.cidadeEndereco = self.cidadeEndereco[indice];
            next.codEndereco = self.codEndereco[indice];
            next.codRestaurante = self.codRestaurante[indice];
            next.numeroEndereco = self.numeroEndereco[indice];
            next.CEPEndereco = self.CEPEndereco[indice];
            
            
            //colocar as veri[aveis que sera passada
            
    }
    

    
}

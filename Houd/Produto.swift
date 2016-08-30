//
//  Produto.swift
//  Houd
//
//  Created by Erik Martins on 27/08/16.
//  Copyright © 2016 Erik Martins. All rights reserved.
//

import Foundation


class Produto {
    
    private(set) var nome: String!
    private(set) var marca: String!
    private(set) var imagemURL: String!
    private(set) var codigoBar: String!
    
    init(nomeProduto: String, marcaProduto: String, imagemProduto: String, codigoBarras: String) {
        
        // Add a little extra text to the album information.
        
        self.nome = "Produto: \n\(nomeProduto)"
        self.marca = "Marca: \(marcaProduto)"
        self.imagemURL = imagemProduto
        self.codigoBar = codigoBarras
}
}
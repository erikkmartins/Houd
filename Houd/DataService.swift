//
//  DataService.swift
//  CDBarcodes
//
//  Created by Matthew Maher on 1/29/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataService {
     
    static let dataService = DataService()
   
    private(set) var nomeProduto = ""
    private(set) var marcaProduto = ""
    private(set) var imagemProduto = ""
    private(set) var codigoBarras = ""
    
    
    static func searchAPI(codeNumber: String) {
        
        // The URL we will use to get out album data from Discogs
        
        let openURL = "\(OPEN_DATA_URL)\(codeNumber)&apikey=\(OPEN_DATA_KEY)"
        
        
        Alamofire.request(.GET, openURL).responseJSON
            { response in
                
                var json = JSON(response.result.value!)
                //print(json)
                let productName = json["name"].stringValue
                let productBrand = json["attributes"]["Brand"].stringValue
                var productImage = json["images"][0].stringValue
                
//                print(productName)
//                print(productBrand)
//                print(productImage)
//                print(codeNumber)
                
                if productImage == "" {
                    productImage = "no_pic"
                }
                
                self.dataService.nomeProduto = productName
                self.dataService.marcaProduto = productBrand
                self.dataService.imagemProduto = productImage
                self.dataService.codigoBarras = codeNumber
                
                // Post a notification to let AlbumDetailsViewController know we have some data.
                
                NSNotificationCenter.defaultCenter().postNotificationName("ProdutoNotificacao", object: nil)
        }


        }
    }

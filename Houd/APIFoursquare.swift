//
//  APIFoursquare.swift
//  teste123
//
//  Created by Isabelle lecrer on 25/04/16.
//  Copyright © 2016 Pick any. All rights reserved.
//
import UIKit

protocol APIControllerDelegate {
    func apiSucceededWithResults(resultsName: NSArray, resultsStreet: NSArray, resultsPostal: NSArray, resultsCity: NSArray, resultsState: NSArray, resultsCountry: NSArray)
    func apiFailedWithError(error: String)
}

class APIFoursquare: NSObject {
    
    var delegate:APIControllerDelegate?
    
    func getAPIResults(urlString:String) {
        
        //Chamda da URL
        let url = NSURL(string: urlString)
        
        //Criação da requisição
        let request = NSMutableURLRequest(URL:url!)
        
        //Assíncrono
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            do {
                //Checagem para dados
                guard let data = data else {
                    self.delegate?.apiFailedWithError("ERROR: no data")
                    return
                }
                //Se conter dados, chama o método para serializar o resultado JSON
                self.generateResults(data)
            }
            }.resume()
    }
    
 //Função que serializa os resultados obtidos da API do FourSquare
    func generateResults(apiData: NSData)
    {
        var resultsName = [String]()
        var resultsStreet = [String]()
        var resultsPostal = [String]()
        var resultsCity = [String]()
        var resultsState = [String]()
        var resultsCountry = [String]()
        
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(apiData, options: NSJSONReadingOptions.MutableContainers)
            
            
            if let resultObject = jsonResult as? NSDictionary {
                if let resultObjectData = resultObject["response"] as? NSDictionary {
                    
                    if let resultObjectChildren = resultObjectData["venues"] as? NSArray {
                        
                        for (var i = 0; i < resultObjectChildren.count ; i++ ){
                            
                            resultsName.append(resultObjectChildren[i]["name"] as! String)
                            
                            if let resultStreet = resultObjectChildren[i]["location"] as? NSDictionary {
                                
                                if let street = resultStreet["address"] as? String{
                                
                                    resultsStreet.append(street)
                                } else{
                                    resultsStreet.append("")
                                }
                                
                            }
                            if let resultPostal = resultObjectChildren[i]["location"] as? NSDictionary {
                                
                                if let postal = resultPostal["postalCode"] as? String{
                                    
                                    resultsPostal.append(postal)
                                } else{
                                    resultsPostal.append("")
                                }
                                
                            }
                            if let resultCity = resultObjectChildren[i]["location"] as? NSDictionary {
                                
                                if let city = resultCity["city"] as? String{
                                    
                                    resultsCity.append(city)
                                } else{
                                    resultsCity.append("")
                                }
                                
                            }
                            if let resultState = resultObjectChildren[i]["location"] as? NSDictionary {
                                
                                if let state = resultState["state"] as? String{
                                    
                                    resultsState.append(state)
                                } else{
                                    resultsState.append("")
                                }
                                
                            }
                            if let resultCountry = resultObjectChildren[i]["location"] as? NSDictionary {
                                
                                if let country = resultCountry["country"] as? String{
                                    
                                    resultsCountry.append(country)
                                } else{
                                    resultsCountry.append("")
                                }
                                
                            }
                            

                        }
                    }
                }
                
            }
                //Passagem dos resultados
            self.delegate?.apiSucceededWithResults(resultsName, resultsStreet: resultsStreet, resultsPostal: resultsPostal, resultsCity: resultsCity, resultsState: resultsState, resultsCountry: resultsCountry)
            
        }
        catch {
            self.delegate?.apiFailedWithError("ERROR: conversion from JSON failed")
        }
    }
    
}

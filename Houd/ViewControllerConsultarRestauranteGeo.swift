//
//  ViewControllerConsultarRestauranteGeo.swift
//  Houd
//
//  Created by Isabelle lecrer on 04/09/16.
//  Copyright © 2016 Pick any. All rights reserved.
//

import UIKit
import CoreLocation

class ViewControllerConsultarRestauranteGeo: UIViewController ,CLLocationManagerDelegate {

   
    var searchResultsDataName: NSArray?
    var searchResultsDataStreet: NSArray?
    var searchResultsDataPostal: NSArray?
    var searchResultsDataCity: NSArray?
    var searchResultsDataState: NSArray?
    var searchResultsDataCountry: NSArray?

    var cellDataNew: String?
    var cellDataStreetNew: String?
    var cellDataPostalNew: String?
    var cellDataCityNew: String?
    var cellDataStateNew: String?
    var cellDataCountryNew: String?
    let locationManager = CLLocationManager()
    
    
    let todaysDate:NSDate = NSDate()
    let dateFormatter:NSDateFormatter = NSDateFormatter()
    var latitude: String!
    var longitude: String!
    
    override func viewDidLoad() {
        // Autorização para sempre utilizar geolocalização.
        self.locationManager.requestAlwaysAuthorization()
        
        // Autorização para utilizar sempre em uso.
        self.locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        if CLLocationManager.locationServicesEnabled() { //Se o serviço de localização estiver ativo
            switch(CLLocationManager.authorizationStatus()) { //Verificar se houve autorização para uso do GPS
            case .NotDetermined, .Restricted, .Denied:
                print("Geolocalização desabilitada")
                let alertController = UIAlertController(title: "Geolocalização", message: "Por favor, habilite a geolocalização nas preferências", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "Ok", style: .Default) { (action) in
                    // ...
                }
                
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true) {
                    // ...
                }
                
            case .AuthorizedAlways, .AuthorizedWhenInUse: //Caso a geolicalização esteja habilitada, start.
                print("Geolocalização habilitada")
                //Inicia o serviço de localização
                locationManager.startUpdatingLocation()
                
                //Formatar a data atual para considerar sempre ultimas versões
                dateFormatter.dateFormat = "YYYYMMDD"
                let Version:String = dateFormatter.stringFromDate(todaysDate)
                
                //Captura da latitude e longitude para a utilização no POST
                
                latitude = String(locationManager.location!.coordinate.latitude) ?? nil
                longitude = String(locationManager.location!.coordinate.longitude) ?? nil
                
                print("Coordenadas = \(latitude) \(longitude)")
                
                //-23.444874,%20-46.546662
                
                locationManager.stopUpdatingLocation()
            }
        } else {
            print("Serviço de localização não está ativo")
        }
        
        
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

    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }
    
}

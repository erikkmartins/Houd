//
//  ListTableViewController.swift
//  Houd
//

import UIKit
import CoreLocation


class TableViewControllerCadastrarRestaurante: UITableViewController,APIControllerDelegate, CLLocationManagerDelegate {
    
    //Variaveis responsáveis por armazenar os resultados do JSON
    var searchResultsDataName: NSArray?
    var searchResultsDataStreet: NSArray?
    var searchResultsDataPostal: NSArray?
    var searchResultsDataCity: NSArray?
    var searchResultsDataState: NSArray?
    var searchResultsDataCountry: NSArray?
    var api: APIFoursquare = APIFoursquare()
    var ite: ViewConstrollerMostraCadastroRestaurante = ViewConstrollerMostraCadastroRestaurante()
    var cellDataNew: String?
    var cellDataStreetNew: String?
    var cellDataPostalNew: String?
    var cellDataCityNew: String?
    var cellDataStateNew: String?
    var cellDataCountryNew: String?
    let locationManager = CLLocationManager()


    //Variaveis utilizadas para o POST utilizando a API do FourSquare
    var urlFoursquare: String! = "https://api.foursquare.com/v2/venues/search?"
    var clientId: String! = "KYFUR1FP312R1KY1C0HBXPMLFJDEGPCFIEP5X0TKGMF45K4V"
    var clientSecret: String! = "PHIWHPVBYFEEHANHXKOGEH0EL5453I43AYYLSMTGEZDVRTQD"
    var categoryId : String! = "4d4b7105d754a06374d81259" //categoria responsável por trazer apenas restaurantes
    var radius : String! = "500" //distancia em metros do ponto
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
                let vVersion:String = dateFormatter.stringFromDate(todaysDate)
                
                //Captura da latitude e longitude para a utilização no POST
           
                latitude = String(locationManager.location!.coordinate.latitude) ?? nil
                longitude = String(locationManager.location!.coordinate.longitude) ?? nil
       
//                latitude = "-23.444874"
//                longitude = "%20-46.546662"
                
                print("Coordenadas = \(latitude) \(longitude)")
                
                //URL utilizada para o POST
                let urlString: String! = (urlFoursquare +  "client_id=" + clientId + "&client_secret="  + clientSecret + "&categoryId=" + categoryId + "&v=" + vVersion + "&ll=" + latitude + "," + longitude + "&radius=" + radius)
                print(urlString)
                
                //-23.444874,%20-46.546662
                api.getAPIResults(urlString)
                    //Associa o delegate a classse

                    self.api.delegate = self
                locationManager.stopUpdatingLocation()
            }
        } else {
            print("Serviço de localização não está ativo")
        }
        
    
    }
    
       
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
                return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let dataSource = searchResultsDataName {
            return dataSource.count
        }else{
            return 0
        }
        
        
    }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier: String = "Cell"
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        //Pega as Strings dentro do Array
        let cellDataName = self.searchResultsDataName![indexPath.row]
        cell.textLabel!.text = cellDataName as? String
        
        let cellDataStreet = self.searchResultsDataStreet![indexPath.row]
        cell.detailTextLabel?.text = cellDataStreet as? String
        
        return cell
        
    }
    
    
    
    
    //Caso a API falhe
    func apiFailedWithError(error: String) {
        let alertController = UIAlertController(title: "Error", message:
            error, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //Caso a API retorne dados
    func apiSucceededWithResults(resultsName: NSArray, resultsStreet: NSArray, resultsPostal: NSArray, resultsCity: NSArray, resultsState: NSArray, resultsCountry: NSArray) {
        self.searchResultsDataName = resultsName
        self.searchResultsDataStreet = resultsStreet
        self.searchResultsDataPostal = resultsPostal
        self.searchResultsDataCity = resultsCity
        self.searchResultsDataState = resultsState
        self.searchResultsDataCountry = resultsCountry
        
        //Métedo que recarrega a TableView
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
        
    }
    
    
    //Botão de atualizar
    @IBAction func atualizar(sender: AnyObject) {
        viewDidLoad()
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
    }
    
    //Captura dos resultados do JSON
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        let cellData = self.searchResultsDataName![indexPath.row]
        ite.textoVenue = (cellData as? String)!
        self.cellDataNew = (cellData as? String)!
        
        let cellDataStreet = self.searchResultsDataStreet![indexPath.row]
        ite.textoStreet = (cellDataStreet as? String)!
        self.cellDataStreetNew = (cellDataStreet as? String)!
        
        let cellDataPostal = self.searchResultsDataPostal![indexPath.row]
        ite.textoPostal = (cellDataPostal as? String)!
        self.cellDataPostalNew = (cellDataPostal as? String)!
        
        let cellDataCity = self.searchResultsDataCity![indexPath.row]
        ite.textoCity = (cellDataCity as? String)!
        self.cellDataCityNew = (cellDataCity as? String)!
        
        let cellDataState = self.searchResultsDataState![indexPath.row]
        ite.textoState = (cellDataState as? String)!
        self.cellDataStateNew = (cellDataState as? String)!
        
        let cellDataCountry = self.searchResultsDataCountry![indexPath.row]
        ite.textoCountry = (cellDataCountry as? String)!
        self.cellDataCountryNew = (cellDataCountry as? String)!
        
        
        print(cellData)
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }
  
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "next" {
 
            ite = (segue.destinationViewController as? ViewConstrollerMostraCadastroRestaurante)!
            
        }
    }
    
}

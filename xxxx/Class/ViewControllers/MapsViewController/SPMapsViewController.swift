//
//  SPMapsViewController.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/8/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire
import ObjectMapper


class SPMapsViewController: SPBaseParentViewController ,CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var mapView = GMSMapView()
    var localPointSearchCoordinate:CLLocation = CLLocation()
    var positionLocation:SPAddress = SPAddress()
    var isSearchAddressCoordinate:Bool = false
    var isAllMaps:Bool = false
    
    var arrayPoint:[SPOrderModel] = []

    struct Static {
        static var instance: SPMapsViewController?
    }
    class var ShareInstance: SPMapsViewController {
        if Static.instance == nil {
            Static.instance = SPMapsViewController()
        }
        return Static.instance!
        
    }
    
//    var myPosition:SPAddress = SPAddress()
    var blockCompleteUpdateAdress: ((GMSPlace)->Void)?
    var blockCompleteFindAdress: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initGoogleMap()
        self.setRightBarIconParent()
        Static.instance = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func initGoogleMap() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
         mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        view = mapView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: CLLocation Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while get location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            let myLocation:SPOrderModel = SPOrderModel()
            myLocation.name = "My Location"
            let camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude), zoom: 15.0)
            
            myLocation.latitude = location.coordinate.latitude
            myLocation.longitude = location.coordinate.longitude
            
            self.mapView.animate(to: camera)
            self.locationManager.stopUpdatingLocation()
            self.myLocation.append(location)
            if self.isSearchAddressCoordinate {
                self.localPointSearchCoordinate = CLLocation(latitude: self.positionLocation.latitude, longitude: self.positionLocation.longitude)
                
                self.showPosition(latitude: self.positionLocation.latitude, longitude: self.positionLocation.longitude,name: self.positionLocation.nameAddress, valueZoom: 15.0)

            }
            
            if self.isAllMaps {
                // can co 1 mang
                let direction = Direction()
                let sortArrayPoint:[SPOrderModel] = direction.initData(pointLocation: myLocation, arrayMyPointFor: self.arrayPoint)
                
                // dung vong for de ve path
                
                for i in 0..<sortArrayPoint.count - 1 {
                    let startPoint:CLLocation = CLLocation(latitude: sortArrayPoint[i].latitude, longitude: sortArrayPoint[i].longitude)
                
                    let endPoint:CLLocation  = CLLocation( latitude: sortArrayPoint[i + 1].latitude, longitude: sortArrayPoint[i + 1].longitude)
                    
                    self.drawPath(startLocation: startPoint, endLocation: endPoint)
                }
                
            }
        }

    }
    
    // MARK: GMSMapview Delegate
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.mapView.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        
        self.mapView.isMyLocationEnabled = true
        if (gesture) {
            mapView.selectedMarker = nil
        }
        
    }
    override func setRightBarIconParent() {
        let leftButton = UIButton(type: .custom)
        leftButton.addTarget(self, action: #selector(self.clickRightButton), for: .touchUpInside)
        leftButton.frame = CGRect(x: 0, y: 0, width: 50, height: 32)
        var leftView = UIView(x: 0, y: 0, width: 50, height: 32)
        var nameImage:String = "search"
        if self.isSearchAddressCoordinate {
            nameImage = ""
            leftButton.setTitle("Done", for: .normal)
        } else {
            leftButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
            leftView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
            leftButton.setImage(UIImage(named: nameImage), for: .normal)
            leftButton.contentMode = .scaleAspectFit
        }

        
        
        leftView.addSubview(leftButton)
        let rightBarButton = UIBarButtonItem(customView: leftView)
        navigationItem.setRightBarButton(rightBarButton, animated: true)
    }
    override func clickRightButton() {
        if self.isSearchAddressCoordinate {
        
            if let block = blockCompleteFindAdress {
                block()
            }
            self.navigationController?.popViewController(animated: true)
        } else {
        
            let autoCompleteController = GMSAutocompleteViewController()
            autoCompleteController.delegate = self
            self.locationManager.startUpdatingLocation()
            self.present(autoCompleteController, animated: true, completion: nil)

        }
    }
// MARK: - DrawPath
    func drawPath(startLocation: CLLocation, endLocation: CLLocation)
    {

        
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        
        print("origin = \(origin) destination = \(destination)")

        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        //"https://maps.googleapis.com/maps/api/distancematrix/xml?origins=Vancouver+BC|Seattle&destinations=San+Francisco|Vancouver+BC&mode=bicycling&language=fr-FR&key=YOUR_API_KEY"
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print("========== \(response.response as Any)") // HTTP URL response
            print("========== \(response.data as Any) ")    // server data
            print("========== \(response.result as Any)")   // result of response serialization
            
            let json = JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            
            // print route using Polyline
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 4
                polyline.strokeColor = UIColor.red
                polyline.map = self.mapView
            }
            
        }
    }
// MARK:- get duration and distance
    func getDetailRouter(starTime:SPAddress , endTime:SPAddress, complete: @escaping(SPDistance, SPDuration) -> Void ) {
        
        
        let origin = "\(starTime.latitude),\(starTime.longitude)"
        let destination = "\(endTime.latitude),\(endTime.longitude)"
        
        
        let url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=\(origin)&destinations=\(destination)&key=\(DATA.APIKEYMAPS.urlEncodeUTF8())"
        
        Alamofire.request(url).responseJSON { response in
        
            switch response.result {
            case .success(let value):
                let newValue = value as? [String : AnyObject]
                if let menuTabbar = Mapper<SPRow>().mapArray(JSONObject: newValue?["rows"]) {
                    if menuTabbar.count > 0 && menuTabbar[0].elements.count > 0 {
                        complete(menuTabbar[0].elements[0].distance, menuTabbar[0].elements[0].duration)
                    }
                    
                }
                break
            case .failure(let error):
                let errorCoordinte:SPBaseInformation = SPBaseInformation()
                complete(errorCoordinte as! SPDistance, errorCoordinte as! SPDuration)
                print("\(error)")
                break
            }
        }
        
    }
    
}

extension SPMapsViewController: GMSAutocompleteViewControllerDelegate ,GMSMapViewDelegate {
// MARK : - AutoComplete
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {

        self.showPosition(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude,name: place.name, valueZoom: 15.0)
        let location:CLLocation = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        
        if let block = blockCompleteUpdateAdress {
                block(place)
        }
        
        self.dismiss(animated: true) {
                self.drawPath(startLocation: self.myLocation[i], endLocation: self.myLocation[i + 1])
        }
        
        
    }
    
    func showPosition(latitude:CLLocationDegrees,longitude:CLLocationDegrees,name:String, valueZoom:Float) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: valueZoom)
        self.mapView.camera = camera
        
        let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            marker.title = name
            marker.map = mapView
        
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        if self.isSearchAddressCoordinate && self.myLocation.count > 0{
            self.drawPath(startLocation: self.myLocation[0], endLocation: self.localPointSearchCoordinate)
        } else {
        
        }
       
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        //cancel button
        self.dismiss(animated: true, completion: nil) // when cancel search
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // false
        print("Load Fail error = \(error)")
    }
    
}






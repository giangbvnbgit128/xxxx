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

class SPMapsViewController: SPBaseParentViewController ,CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var mapView = GMSMapView()
    var myLocation:[CLLocation] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initGoogleMap()
        self.setRightBarIconParent()
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
            let camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude), zoom: 15.0)
            self.mapView.animate(to: camera)
            self.locationManager.stopUpdatingLocation()
            print("MyLocation = \(location.coordinate)")
            
            self.myLocation.append(location)
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
        leftButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        leftButton.setImage(UIImage(named: "search"), for: .normal)
        leftButton.contentMode = .scaleAspectFit
        let leftView = UIView(x: 0, y: 0, width: 32, height: 32)
        leftView.addSubview(leftButton)
        let rightBarButton = UIBarButtonItem(customView: leftView)
        navigationItem.setRightBarButton(rightBarButton, animated: true)
    }
    override func clickRightButton() {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
    }
// MARK: - DrawPath
    func drawPath(startLocation: CLLocation, endLocation: CLLocation)
    {
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
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
    
}

extension SPMapsViewController: GMSAutocompleteViewControllerDelegate ,GMSMapViewDelegate {
// MARK: - AutoComplete
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        self.mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        let location:CLLocation = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        
        myLocation.append(location)
        self.dismiss(animated: true) {
            for i in  0..<self.myLocation.count - 1 {
                self.drawPath(startLocation: self.myLocation[i], endLocation: self.myLocation[i + 1])
            }
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


//
//  FirstViewController.swift
//  Wake-Me-Up
//
//  Created by Manu Sodhi on 1/14/16.
//  Copyright © 2016 Manvinder Sodhi. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Foundation
import AudioToolbox
import AVFoundation


class FirstViewController: UIViewController, CLLocationManagerDelegate, AVSpeechSynthesizerDelegate , GMSMapViewDelegate {
    
    @IBOutlet var toggleFollow: UISwitch!
    @IBOutlet var mapView: GMSMapView!
    
    var timer: NSTimer!
    var destPin = GMSMarker()
    // hardcoding Work as the destination
    var destLocation: CLLocation!
    
    var distance = CLLocationDistance()
    var currentLocation = CLLocation()
    let locationManager = CLLocationManager()
    var camera = GMSCameraPosition()
    let userRange = 0.25       // use this later to get the actual user's input range
    let milesInMeters = 0.00062137
    var currentLocation2D = CLLocationCoordinate2D()
    var destRadius = GMSCircle()
    let synthesizer = AVSpeechSynthesizer()
    var utterance = AVSpeechUtterance()
    var finalUtterance = AVSpeechUtterance()
    var destPinCoords = CLLocationCoordinate2D()
    var isLocationAvailable: Bool!

    
    func mapView(mapView: GMSMapView!, didLongPressAtCoordinate coordinate: CLLocationCoordinate2D) {
        
        if(destLocation == nil){
            //Set variable to latitude of didLongPressAtCoordinate
            let latitude = coordinate.latitude

            //Set variable to longitude of didLongPressAtCoordinate
            let longitude = coordinate.longitude
            destLocation = CLLocation(latitude: latitude, longitude: longitude)
            updateDestination()
        }
    }
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        deleteLocationAndClearMap()
    }
    
    func deleteLocationAndClearMap() {
        
        if(destLocation != nil && distance > 0){
            destLocation = nil
            mapView.clear()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeLocationManager()
        initializeMapSettings()
    }

    func initializeLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func initializeMapSettings() {
        mapView.camera = GMSCameraPosition.cameraWithLatitude(currentLocation.coordinate.latitude,longitude: currentLocation.coordinate.longitude, zoom: 14)
        mapView.myLocationEnabled = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
    }


    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        currentLocation = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
        currentLocation2D = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
        if(toggleFollow.on){
            mapView.animateToLocation(currentLocation2D)
        }
        if(destLocation != nil){
            getDistance()
        }
    }
    

    func updateDestination() {
        
        destPinCoords = CLLocationCoordinate2DMake(destLocation.coordinate.latitude, destLocation.coordinate.longitude)
        
        // everything with the circle
        destRadius.radius = userRange / milesInMeters
        destRadius.position = destPinCoords
        destRadius.map = mapView
        
        // everything with the actual destination pin
        destPin = GMSMarker(position: destPinCoords)
        CLGeocoder().reverseGeocodeLocation(destLocation, completionHandler: {(placemarks, error) -> Void in
//            println(location)
            
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                let locality = pm.locality ?? ""
                self.destPin.title = "\(locality)"
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
        
        destPin.map = mapView
    }
    
    func getDistance() {
        
        distance = currentLocation.distanceFromLocation(destLocation) * milesInMeters - userRange
        if(distance <= 0){
            // Speak the dialogue
            utterance = AVSpeechUtterance(string: "You are within \(userRange) miles of your destination")
            self.synthesizer.speakUtterance(utterance)
            self.synthesizer.delegate = self

            // Vibrate going deep inside
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            if(distance == -userRange){

                // reached destination
                finalUtterance = AVSpeechUtterance(string: "You have reached your destination.")
                self.synthesizer.speakUtterance(finalUtterance)
                
            }
        }
        if(distance > 0){
            synthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        }

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toggleFollow(mySwitch: UISwitch) {
        if(mySwitch.on){
            mapView.animateToLocation(currentLocation2D)
        }else if(!mySwitch.on && destLocation == nil){
            mapView.animateToLocation(currentLocation2D)
        }
        else{
            mapView.camera = GMSCameraPosition.cameraWithLatitude(destLocation.coordinate.latitude,longitude: destLocation.coordinate.longitude, zoom: 14)
        }
        
    }
    
}
//
//  AppDelegate.swift
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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate, AVSpeechSynthesizerDelegate {

    
    var window: UIWindow?
//    let locationManager = CLLocationManager()
//    var currentLocation = CLLocation()
//    var currentLocation2D = CLLocationCoordinate2D()
//    let synthesizer = AVSpeechSynthesizer()
//    var utterance = AVSpeechUtterance()
//    var finalUtterance = AVSpeechUtterance()
//    var distance = CLLocationDistance()
//    let milesInMeters = 0.00062137
//    var userRange = Double()
//    var destLocation = CLLocation()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyD20l2ca3-uKuhNOI_SgGjPxlJxqD5EXLw")
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
//        
//        userRange = FirstViewController().userRange
//        destLocation = FirstViewController().destLocation
//        initializeLocationManager()
//        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
//        locationManager.stopUpdatingLocation()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//    func initializeLocationManager() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let locationArray = locations as NSArray
//        let locationObj = locationArray.lastObject as! CLLocation
//        let coord = locationObj.coordinate
//        currentLocation = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
//        currentLocation2D = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
//        getDistance()
//    }
//    
//    func getDistance() {
//        
//        distance = currentLocation.distanceFromLocation(destLocation) * milesInMeters - userRange
//        print("Distance: ", distance)
//        print("Current Location: ", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
//        print("Destination Location: ", destLocation.coordinate.latitude, destLocation.coordinate.longitude)
//        if(distance <= 0){
//            // Speak the dialogue
//            utterance = AVSpeechUtterance(string: "You are within \(userRange) miles of your destination")
//            self.synthesizer.speakUtterance(utterance)
//            self.synthesizer.delegate = self
//            
//            // Vibrate going deep inside
//            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
//            if(distance == -userRange){
//                
//                // stop updating your current location.
//                locationManager.stopUpdatingLocation()
//                
//                // reached destination
//                finalUtterance = AVSpeechUtterance(string: "You have reached your destination.")
//                self.synthesizer.speakUtterance(finalUtterance)
//                
//            }
//        }
//        if(distance > 0){
//            synthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
//        }
//        
//    }
    

}

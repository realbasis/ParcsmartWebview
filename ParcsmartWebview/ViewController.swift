//
//  ViewController.swift
//  ParcsmartWebview
//
//  Created by administrator on 9/20/21.
//

import AppTrackingTransparency
import CoreLocation
import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate  {
    
    var webView: WKWebView!
    //var locationManager: CLLocationManager?
    let locationManager = CLLocationManager()
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            // The user denied authorization
            print("location denied")
        } else if (status == CLAuthorizationStatus.authorizedAlways) {
            // The user accepted authorization
            print("location accepted")
        }
        else {
            print("location status unknown")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //locationManager = CLLocationManager()
        //locationManager?.delegate = self
        //locationManager?.requestAlwaysAuthorization()
                
        let myURL = URL(string:"https://parcsmart.com/webview.jsp")
        let myRequest = URLRequest(url: myURL!)
        
        let myURLno = URL(string:"https://parcsmart.com/webviewno.jsp")
        let myRequestno = URLRequest(url: myURLno!)
        
        //NEWLY ADDED PERMISSIONS FOR iOS 14
        if #available(iOS 14, *) {
            
            // request location access
            locationManager.requestAlwaysAuthorization()
            //print("location status")
            //print(locationManager.authorizationStatus)
            
                        
            ATTrackingManager.requestTrackingAuthorization { (status) in
            
                switch status {
                
                case .notDetermined:
                    print("notDetermined")
                    self.webView.load(myRequestno)
                    break
                case .restricted:
                    print("restricted")
                    self.webView.load(myRequestno)
                    break
                case .denied:
                    print("denied")
                    self.webView.load(myRequestno)
                    break
                case .authorized:
                    print("*** app tracking authorized")
                    print("*** webView loading...")
                    self.webView.load(myRequest)
                    break
                @unknown default:
                    print("unknown")
                    self.webView.load(myRequestno)
                    break
                }
            
            }
        }
        else {
            print("*** no app tracking required, webView loading...")
            webView.load(myRequest)
        }
        
    }
    
   override func loadView() {
      let webConfiguration = WKWebViewConfiguration()
      webView = WKWebView(frame: .zero, configuration: webConfiguration)
      webView.uiDelegate = self
      view = webView
   }
    
    
}

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

class ViewController: UIViewController, WKUIDelegate, CLLocationManagerDelegate  {
    
    @IBOutlet weak var webView: WKWebView!
    
    //var locationManager: CLLocationManager?
    let locationManager = CLLocationManager()
    let myURL = URL(string:"https://parcsmart.com/wkwebview.jsp?lang=fr")
    let myURLno = URL(string:"https://parcsmart.com/webviewno.jsp?lang=fr")
	let myURLmin = URL(string:"https://parcsmart.com/webviewmin.jsp?lang=fr")

    override func viewDidLoad() {
        super.viewDidLoad()        
         
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
		//let myRequestno = URLRequest(url: myURLno!)
		let myRequestmin = URLRequest(url: myURLmin!)
        //let myRequest = URLRequest(url: myURL!)
		print("function viewDidAppear loaded.  Status = ",ATTrackingManager.trackingAuthorizationStatus)
        
        ATTrackingManager.requestTrackingAuthorization { [self] (status) in
        
            switch status {
            
            case .notDetermined:
                print("Tracking notDetermined")
				self.webView.load(myRequestmin)
                //locationManager.delegate = self
                //locationManager.requestAlwaysAuthorization()
                break
            case .restricted:
                print("Tracking restricted")
				self.webView.load(myRequestmin)
                //locationManager.delegate = self
                //locationManager.requestAlwaysAuthorization()
                break
            case .denied:
                print("Tracking denied")
                self.webView.load(myRequestmin)
                //locationManager.delegate = self
                //locationManager.requestAlwaysAuthorization()
                break
            case .authorized:
                locationManager.delegate = self
                locationManager.requestAlwaysAuthorization()
                print("*** app tracking authorized")
                print("*** webView loading...")
				// self.webView.load(myRequest)
                break
            @unknown default:
                print("Tracking state unknown")
				self.webView.load(myRequestmin)
                //locationManager.delegate = self
                //locationManager.requestAlwaysAuthorization()
                break
            }
        
        }
    }
  
    //LocationManagerDelegate    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        
        let myRequest = URLRequest(url: myURL!)
        //let myRequestno = URLRequest(url: myURLno!)
		let myRequestmin = URLRequest(url: myURLmin!)
		print("*** LocationManager function. Status :",status)
        
        if #available(iOS 14, *) {
            self.webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
			print("*** IOS is 14 minimum")
        }
        else {
            self.webView.configuration.preferences.javaScriptEnabled = true
            print("*** no app tracking required, webView loading...")
        }
        
        switch status {
			case .authorizedWhenInUse:
				print("*** app tracking authorized")
				print("*** webView loading...")
				self.webView.load(myRequest)
				break
			case .authorizedAlways:
				print("*** app tracking authorized")
				print("*** webView loading...")
				self.webView.load(myRequest)
				break
			case .denied:
				print("denied")
				self.webView.load(myRequestmin)
				break
			case .notDetermined:
				print("notDetermined")
				self.webView.load(myRequestmin)
				break
			case .restricted:
				print("restricted")
				self.webView.load(myRequestmin)
				break
			default:
				print("location status unknown")
				self.webView.load(myRequestmin)
				break
        }
    }    
}

//
//  InsertViewController.swift
//  Cat
//
//  Created by SWUCOMPUTER on 2017. 12. 21..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class InsertViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var textLatitude: UITextField!
    @IBOutlet var textLongitude: UITextField!
    @IBOutlet var textPlace: UITextField!
    @IBOutlet var button: UIButton!
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidAppear(_ animated: Bool) {
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
                let alert = UIAlertController(title: "오류 발생",
                                              message: "위치서비스 기능이 꺼져있음", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                //self.toggle.isOn = false
            }
            else {
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
            }
        }
        else {
            let alert = UIAlertController(title: "오류 발생", message: "위치서비스 제공 불가",
                                          preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
        return true
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        // 가장 최근의 위치 값
        let location: CLLocation = locations[locations.count-1]
        textLatitude.text = String(format: "%.6f", location.coordinate.latitude)
        textLongitude.text = String(format: "%.6f", location.coordinate.longitude)
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Location", in: context)
        
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        object.setValue(textPlace.text, forKey: "place")
        object.setValue(textLatitude.text, forKey: "latitude")
        object.setValue(textLongitude.text, forKey: "longitude")
        object.setValue(Date(), forKey: "date")
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func buttonPressed(_ sender: UIButton) {
        self.locationManager.startUpdatingLocation()
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */



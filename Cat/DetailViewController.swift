//
//  DetailViewController.swift
//  Cat
//
//  Created by SWUCOMPUTER on 2017. 12. 20..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet var textLatitude: UITextField!
    @IBOutlet var longitude: UITextField!
    @IBOutlet var place: UITextField!
    
    var detailLocation: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let location = detailLocation {
            textLatitude.text = location.value(forKey: "latitude") as? String
            longitude.text = location.value(forKey: "longitude") as? String
            place.text = location.value(forKey: "place") as? String
             }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

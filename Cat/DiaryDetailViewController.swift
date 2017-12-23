//
//  DiaryDetailViewController.swift
//  Cat
//
//  Created by SWUCOMPUTER on 2017. 12. 21..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class DiaryDetailViewController: UIViewController {

    @IBOutlet var textTitle: UITextField!
    @IBOutlet var textStatus: UITextField!
    @IBOutlet var textFood: UITextField!
    @IBOutlet var textDate: UITextField!
    @IBOutlet var textContent: UITextView!
    
    var detailDiary: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let diary = detailDiary {
            textTitle.text = diary.value(forKey: "title") as? String
            textStatus.text = diary.value(forKey: "catStatus") as? String
            textFood.text = diary.value(forKey: "catFood") as? String
            textContent.text = diary.value(forKey: "catContent") as? String
            let dbDate: Date? = diary.value(forKey: "catDate") as? Date
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let unwrapDate = dbDate {
                let displayDate = formatter.string(from: unwrapDate as Date)
                textDate.text = displayDate
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

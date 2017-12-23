//
//  SaveViewController.swift
//  Cat
//
//  Created by SWUCOMPUTER on 2017. 12. 21..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class SaveViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textTitle: UITextField!
    @IBOutlet var textStatus: UITextField!
    @IBOutlet var textFood: UITextField!
    @IBOutlet var textContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Diary", in: context)
        // friend record를 새로 생성함
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        object.setValue(textTitle.text, forKey: "title")
        object.setValue(textContent.text, forKey: "catContent")
        object.setValue(textStatus.text, forKey: "catStatus")
        object.setValue(textFood.text, forKey: "catFood")
        object.setValue(Date(), forKey: "catDate")
        
    
        
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)
    }

    

func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
}



}

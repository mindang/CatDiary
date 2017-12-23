//
//  ThirdTableViewController.swift
//  Cat
//
//  Created by SWUCOMPUTER on 2017. 12. 20..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class ThirdTableViewController: UITableViewController {
    
    var DiaryArray: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }

        override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DiaryArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Diary Cell", for: indexPath)

        // Configure the cell...
        
        let diary = DiaryArray[indexPath.row]
        var display: String = ""
        
        let dateLabel = diary.value(forKey: "catDate") as? Date
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd h:mm a"
        if let unwrapDate = dateLabel {
            let displayDate = formatter.string(from: unwrapDate as Date)
            display = displayDate
        }
        //        if let titleLabel = idea.value(forKey: "ideaTitle") as? String {
        //            display = display + " " + titleLabel
        //        }
        cell.detailTextLabel?.text = display
        cell.textLabel?.text = diary.value(forKey: "title") as? String
        
        return cell
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    // View가 보여질 때 자료를 DB에서 가져오도록 한다
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Diary")
        
        let sortDescriptor = NSSortDescriptor (key: "catDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            DiaryArray = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        self.tableView.reloadData()
    }
    

    override func tableView(_ tableView: UITableView, canEditRowAt
        indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView (_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Core Data 내의 해당 자료 삭제
            let context = getContext()
            context.delete(DiaryArray[indexPath.row])
            do {
                try context.save()
                print("deleted!")
            } catch let error as NSError {
                print("Could not delete \(error), \(error.userInfo)") }
            // 배열에서 해당 자료 삭제
            DiaryArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {
        }
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toDiaryDetailView" {
            if let destination = segue.destination as? DiaryDetailViewController {
                if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
                    destination.detailDiary = DiaryArray[selectedIndex] }
            } }
    }
    

}

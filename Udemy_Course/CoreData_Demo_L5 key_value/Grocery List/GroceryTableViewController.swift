//
//  GroceryTableViewController.swift
//  Grocery List
//
//  Created by Andi Setiyadi on 8/30/16.
//  Copyright © 2016 devhubs. All rights reserved.
//

import UIKit
import CoreData

class GroceryTableViewController: UITableViewController {
    // 存放資料的型態必須要是 [NSManagedObject]
    var groceries = [NSManagedObject]()
    var managerObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        managerObjectContext = appDelegate.persistentContainer.viewContext
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        // 實例化請求該 entity
        let request: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "Grocery")
        do {
            // 實例化請求 Database
            let results = try managerObjectContext?.fetch(request)
            // 將 result 存入 NSManagedobject 陣列裡
            groceries = results!
            tableView.reloadData()
        }
        catch {
            fatalError("Error in retriving Grocery item")
        }
    }
    
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Grocery Item", message: "What's to buy now?", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (textField: UITextField) in
            
        }
        
        let addAction = UIAlertAction(title: "ADD", style: UIAlertActionStyle.default) { [weak self] (action: UIAlertAction) in
            let textField = alertController.textFields?.first
            //self?.groceries.append(textField!.text!)
            
            let enetity = NSEntityDescription.entity(forEntityName: "Grocery", in: (self?.managerObjectContext)!)!
            
            let grocery = NSManagedObject(entity: enetity, insertInto: self?.managerObjectContext)
            grocery.setValue(textField!.text, forKey: "item")
            
            do{
                try self?.managerObjectContext?.save()
            }
            catch {
                fatalError("Error to save data")
            }
            
            self?.loadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.groceries.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath)
        // 將 managedobject 放入每一個 cell 裡
        let grocery = self.groceries[indexPath.row]
        cell.textLabel?.text = grocery.value(forKey: "item") as? String
        
        return cell
    }
}

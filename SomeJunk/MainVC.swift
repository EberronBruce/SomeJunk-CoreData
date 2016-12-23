//
//  ViewController.swift
//  SomeJunk
//
//  Created by Bruce Burgess on 12/11/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        //generateTestData()
        attemptFetch()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: ItemCell, indexPath: IndexPath) {
        if let item = fetchedResultsController.object(at: indexPath) as? Item {
            //update data
            cell.configurerCell(item: item)
        }
    }
    
    func attemptFetch() {
        setFetchedResults()
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let error = error as NSError
            print("\(error), \(error.userInfo)")
        }
    }
    
    func setFetchedResults() {
        let section: String? = segment.selectedSegmentIndex == 1 ? "store.name" : nil
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        
        let sortDescriptor = NSSortDescriptor(key: "created", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ad.persistentContainer.viewContext, sectionNameKeyPath: section, cacheName: nil)
        
        controller.delegate = self
        
        fetchedResultsController = controller
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
            
        case .update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                configureCell(cell: cell, indexPath: indexPath)
            }
            break
            
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
            break
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = fetchedResultsController.fetchedObjects, objs.count > 0 {
            let item = objs[indexPath.row] as! Item
            
            performSegue(withIdentifier: "ItemDetailsVC", sender: item)
        }
    }
    
    func generateTestData() {
        
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: ad.persistentContainer.viewContext) as! Item
        item.title = "Cool LEGO Set"
        item.price = 45.99
        item.details = "This is a cool Starwas LEGO set with 1000 pieces"
        
        let item2 = NSEntityDescription.insertNewObject(forEntityName: "Item", into: ad.persistentContainer.viewContext) as! Item
        item2.title = "He-Man vs Skeletor"
        item2.price = 99.99
        item2.details = "Skeletor is the man! (kind of)"
        
        let item3 = NSEntityDescription.insertNewObject(forEntityName: "Item", into: ad.persistentContainer.viewContext) as! Item
        item3.title = "Audi R8"
        item3.price = 108000
        item3.details = "Im probably going to die int his car. But I'll buy it anyway"
        
        ad.saveContext()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemDetailsVC" {
            let vc = segue.destination as! ItemDetailsVC
            vc.itemToEdit = sender as? Item
        }
    }
}























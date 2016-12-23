//
//  ItemDetailsVC.swift
//  SomeJunk
//
//  Created by Bruce Burgess on 12/20/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    
    var stores = [Store]()
    var itemToEdit: Item?

    override func viewDidLoad() {
        super.viewDidLoad()

        storePicker.delegate = self
        storePicker.dataSource = self
        
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
        
        
        
//        let store1 = NSEntityDescription.insertNewObject(forEntityName: "Store", into: ad.persistentContainer.viewContext) as! Store
//        store1.name = "Amazon"
//        
//        let store2 = NSEntityDescription.insertNewObject(forEntityName: "Store", into: ad.persistentContainer.viewContext) as! Store
//        store2.name = "Walmart"
//        
//        let store3 = NSEntityDescription.insertNewObject(forEntityName: "Store", into: ad.persistentContainer.viewContext) as! Store
//        store3.name = "Scary Goth Club"
//        
//        let store4 = NSEntityDescription.insertNewObject(forEntityName: "Store", into: ad.persistentContainer.viewContext) as! Store
//        store4.name = "Best Buy"
//        
//        let store5 = NSEntityDescription.insertNewObject(forEntityName: "Store", into: ad.persistentContainer.viewContext) as! Store
//        store5.name = "Steve's Fish & Chis"
//        
//        let store6 = NSEntityDescription.insertNewObject(forEntityName: "Store", into: ad.persistentContainer.viewContext) as! Store
//        store6.name = "Aussie Panel Beater"
//        
//        ad.saveContext()
        
        
    }
    
    func loadItemData() {
        if let item = itemToEdit {
            
            if let title = item.title {
                titleField.text = title
            }
            
            if let details = item.details {
                detailsField.text = details
            }
            
            priceField.text = "\(item.price)"
            
            
            if let store = item.store {
               
                var index = 0
                repeat {
                    let s = stores[index]
                    
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                    
                } while (index < stores.count)
            }
            
        }
    }
    
    func getStores() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Store")
        
        do {
            self.stores = try ad.persistentContainer.viewContext.fetch(fetchRequest) as! [Store]
            self.storePicker.reloadAllComponents()
            //print("try fecth")
        } catch {
            //handle error
            print("failed fetch")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        if itemToEdit != nil {
            ad.persistentContainer.viewContext.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func savePressed(_ sender: Any) {
        
        var item: Item!
        
        if itemToEdit == nil {
            item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: ad.persistentContainer.viewContext) as! Item
        } else {
            item = itemToEdit
        }
        
        if let title = titleField.text {
            item.title = title
        }
        
        if let price = priceField.text {
            let priceStr = NSString(string: price)
            let priceDbl = priceStr.doubleValue
            item.price = priceDbl
        }
        
        if let details = detailsField.text {
            item.details = details
        }
        
        item.store = stores[storePicker.selectedRow(inComponent: (0))]
        
        ad.saveContext()
        _ = self.navigationController?.popViewController(animated: true)
        
    }
}




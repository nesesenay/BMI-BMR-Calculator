//
//  HistoryVC.swift
//  BMICalculator
//
//  Created by Erdem Okçu on 18.01.2022.
//

import UIKit
import CoreData

class HistoryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var calculatorButton: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var bmiValueArray = [String]()
    var idArray = [UUID]()
    var selectedBmi = ""
    var selectedBmiId : UUID?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        calculatorButton.isUserInteractionEnabled = true
        let buttonRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseButton))
        calculatorButton.addGestureRecognizer(buttonRecognizer)
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    
        
    @objc func getData() {
        
        bmiValueArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BmiValues")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let bmiValue = result.value(forKey: "bmiValue") as? String {
                        self.bmiValueArray.append(bmiValue)
                    }
                    
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                    
                    
                    self.tableView.reloadData()
                    selectedBmi.removeAll()
                }
                
                
                
            }
            
        } catch {
            print("error")
        }
       
        
        
    }
    
    
    @objc func chooseButton(){
        selectedBmi = ""
        performSegue(withIdentifier: "toCalculaterVC", sender: nil)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bmiValueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = bmiValueArray[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultt" {
            let blablaVC = segue.destination as! ResultVC
            blablaVC.choosenBmiValue = selectedBmi
            blablaVC.choosenBmiValueId = selectedBmiId
            blablaVC.choosenSaveButton.isHidden = true
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        selectedBmi = bmiValueArray[indexPath.row]
        selectedBmiId = idArray[indexPath.row ]
        performSegue(withIdentifier: "toResultt", sender: nil)
      
        
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BmiValues")
            
            let idString = idArray[indexPath.row].uuidString
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject]{
                        
                        if let id = result.value(forKey: "id") as? UUID {
                            
                            if id == idArray[indexPath.row] {
                                context.delete(result)
                                bmiValueArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                
                                do{
                                    try context.save()
                                } catch {
                                    print("error")
                                }
                                
                                break
                                
                            }
                        }
                    }
                }
            } catch {
                print("error")
            }
           
        }
    }

}




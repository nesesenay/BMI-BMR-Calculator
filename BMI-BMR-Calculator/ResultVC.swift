//
//  ResultVC.swift
//  BMICalculator
//
//  Created by Erdem Okçu on 18.01.2022.
//

import UIKit
import CoreData

class ResultVC: UIViewController {
    
    
    var overweight : UIImage?
    var veryseverlyunderweight : UIImage?
    var severlyunderweight : UIImage?
    var underweight : UIImage?
    var normalweight : UIImage?
    var oneobesseweight : UIImage?
    var secondobesseweight : UIImage?
    var thirdobesseweight : UIImage?
    
    
    
    var choosenBmiValue = ""
    var choosenBmiValueId : UUID?
    var choosenSaveButton = UIButton()
    var yourbmilabel = ""
    var bmrlabel = ""
    var idealweightlabel = ""
    var bmivaluelabel = ""
    var bmilabel = ""
    var needweightlabel = ""
    var normalweightlabel = ""
    
   

    
    @IBOutlet weak var overWeight: UIImageView!
    @IBOutlet weak var verySeverlyUnderWeight: UIImageView!
    @IBOutlet weak var severlyUnderWeight: UIImageView!
    @IBOutlet weak var underWeight: UIImageView!
    @IBOutlet weak var normalWeight: UIImageView!
    @IBOutlet weak var oneObesseWeight: UIImageView!
    @IBOutlet weak var secondObesseWeight: UIImageView!
    @IBOutlet weak var thirdObesseWeight: UIImageView!
    
    
    @IBOutlet weak var yourBmr: UILabel!
    @IBOutlet weak var yourBmi: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var bmiValueLabel: UILabel!
    @IBOutlet weak var bmrLabel: UILabel!
    @IBOutlet weak var idealWeightLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var needWeightLabel: UILabel!
    @IBOutlet weak var normalWeightLabel: UILabel!
    
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if  choosenBmiValue != "" {
            
            // Core Data
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BmiValues")
            let idString = choosenBmiValueId?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            
            
            do {
                let results =  try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        if let bmiCalculate = result.value(forKey: "bmiCalculate") as? Double {
                            bmilabel = String(bmiCalculate)
                            
                            
                        }
                        
                        if let bmrCalculate = result.value(forKey: "bmrCalculate") as? Double {
                            bmrlabel = String(bmrCalculate)
                        }
                        
                        if let bmiValue = result.value(forKey: "bmiValue") as? String {
                            bmivaluelabel = bmiValue
                        }
                        
                        
                        if let idealWeight =  result.value(forKey: "idealWeight") as? Double {
                            if idealWeight != 0.0 {
                                idealweightlabel = String(idealWeight)
                                
                                
                            }
                            
                            
                            if let normalWeight = result.value(forKey: "normalWeight") as? String {
                                normalweightlabel = normalWeight
                          
                            }
                            
                            
                            if let yourBmi = result.value(forKey: "yourBmi") as? String {
                                yourbmilabel = yourBmi
                            }
                            
                            if let needWeight = result.value(forKey: "needWeight") as? String {
                                needweightlabel = needWeight
                            }
                            
                            
                            
                            
                           
                            
                            
                    }
                    
                }
                    
            }
            
        } catch {
            print("error")
        }
        } else {
            bmiLabel.text = ""
            bmrLabel.text = ""
            bmiValueLabel.text = ""
            idealWeightLabel.text = ""
        }
        
        
        
        bmrLabel.text = "\(bmrlabel)"
        bmiValueLabel.text = "\(bmivaluelabel)"
        bmiLabel.text = "\(bmilabel)"
        idealWeightLabel.text = "\(idealweightlabel)"
        normalWeightLabel.text = "\(normalweightlabel)"
        needWeightLabel.text = "\(needweightlabel)"
        overWeight.image = overweight
        verySeverlyUnderWeight.image = veryseverlyunderweight
        severlyUnderWeight.image = severlyunderweight
        underWeight.image = underweight
        normalWeight.image = normalweight
        oneObesseWeight.image = oneobesseweight
        secondObesseWeight.image = secondobesseweight
        thirdObesseWeight.image = thirdobesseweight
       
    }
    
    
    
    @IBAction func okButtonClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newBmiValues = NSEntityDescription.insertNewObject(forEntityName: "BmiValues", into: context)
        
        // Attributes
        
        
        newBmiValues.setValue(bmivaluelabel, forKey: "bmiValue")
        
        newBmiValues.setValue(UUID(), forKey: "id")
        
        
        if let bmiCalculate = Double(bmilabel) {
            newBmiValues.setValue(bmiCalculate, forKey: "bmiCalculate")
        }
        
        if let bmrCalculate = Double(bmrlabel) {
            newBmiValues.setValue(bmrCalculate, forKey: "bmrCalculate")
        }
        
        if let idealWeight = Double (idealweightlabel) {
            if idealWeight != 0.0 {
                newBmiValues.setValue(idealWeight, forKey: "idealWeight")
            }
           
        }
        
        
    
        newBmiValues.setValue(normalweightlabel, forKey: "normalWeight")
        
        newBmiValues.setValue(yourbmilabel, forKey: "yourBmi")
        
        newBmiValues.setValue(needweightlabel, forKey: "needWeight")
        
        
        
        
        
        do {
            try context.save()
            print("success")
        } catch {
            print("error")
        }
        
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newData"), object: nil)
        performSegue(withIdentifier: "toHistory", sender: nil)
        
        
    }
    
    
    
}
    





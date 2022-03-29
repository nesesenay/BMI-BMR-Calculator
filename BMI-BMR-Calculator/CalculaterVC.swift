import UIKit
import CoreData

class CalculaterVC: UIViewController {
    
   
    
    var bmr = ""
    var bmi = ""
    var bmivalue = ""
    var idealweight = ""
    var yourbmi = ""
    var needweight = ""
    var normalweight = ""
    
    var over : UIImageView?
    var overImage : UIImage?
    
    var normal : UIImageView?
    var normalImage : UIImage?
    
    var under : UIImageView?
    var underImage : UIImage?
    
    var severly : UIImageView?
    var severlyImage : UIImage?
    
    var verySeverly : UIImageView?
    var verySeverlyImage : UIImage?
    
    var oneObesse : UIImageView?
    var oneObesseImage : UIImage?
    
    var secondObesse : UIImageView?
    var secondObesseImage : UIImage?
    
    var thirdObesse : UIImageView?
    var thirdObesseImage : UIImage?
    
    
   
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var secondMaleIcon: UIImageView!
    @IBOutlet weak var secondFemaleIcon: UIImageView!
    @IBOutlet weak var firstMaleIcon: UIImageView!
    @IBOutlet weak var firstFemaleIcon: UIImageView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        firstMaleIcon.isUserInteractionEnabled = true
        let firstMaleGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseFirstMale))
        firstMaleIcon.addGestureRecognizer(firstMaleGestureRecognizer)
        
        secondMaleIcon.isUserInteractionEnabled = true
        let secondMaleGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseSecondMale))
        secondMaleIcon.addGestureRecognizer(secondMaleGestureRecognizer)
        
        firstFemaleIcon.isUserInteractionEnabled = true
        let firstFemaleGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseFirstFemale))
        firstFemaleIcon.addGestureRecognizer(firstFemaleGestureRecognizer)
        
        secondFemaleIcon.isUserInteractionEnabled = true
        let secondFemaleGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseSecondFemale))
        secondFemaleIcon.addGestureRecognizer(secondFemaleGestureRecognizer)
        
        
    
        
        
    }
    
    
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let heightValue = Int(sender.value)
        heightLabel.text = "\(heightValue)"
    }
    
    @IBAction func ageSliderValueChanged(_ sender: UISlider) {
        let ageValue = Int(sender.value)
        ageLabel.text = "\(ageValue)"
    }
    
    
    @IBAction func weightSliderValueChanged(_ sender: UISlider) {
        let weightValue = Int(sender.value)
        weightLabel.text = "\(weightValue)"
    }
    
    
    
    @objc func chooseFirstMale() {
        firstMaleIcon.isHidden = true
        secondMaleIcon.isHidden = false
    }
    
    @objc func chooseSecondMale() {
        firstFemaleIcon.isHidden = true
        secondFemaleIcon.isHidden = false
        secondMaleIcon.isHidden = true
        firstMaleIcon.isHidden = false
    }
    
    @objc func chooseFirstFemale() {
        firstFemaleIcon.isHidden = true
        secondFemaleIcon.isHidden = false
    }
    
    @objc func chooseSecondFemale() {
        firstMaleIcon.isHidden = true
        secondMaleIcon.isHidden = false
        secondFemaleIcon.isHidden = true
        firstFemaleIcon.isHidden = false
    }
    
    
    

    @IBAction func calculateClicked(_ sender: Any) {
        
        
        
        
        guard let weightInKG = weightLabel.text,
              let heightInCM = heightLabel.text,
              let ageInNum = ageLabel.text
        else {
            return
        }
        
        let bmrForFemaleResult = bmrFemale.init(weightInKG: weightInKG, heightInCM: heightInCM, ageInNum: ageInNum)
        let bmrFemaleCalculate = bmrForFemaleResult.bmrFemaleCalc()
        
        let bmrForMaleResult = bmrMale.init(weightInKG: weightInKG, heightInCM: heightInCM, ageInNum: ageInNum)
        let bmrMaleCalculate = bmrForMaleResult.bmrMaleCalc()
        
        
        
        if firstMaleIcon.isHidden == false && firstFemaleIcon.isHidden == true && secondFemaleIcon.isHidden == false && secondMaleIcon.isHidden == true {
            bmr = "\(bmrMaleCalculate)"
           
        } else if firstMaleIcon.isHidden == true && firstFemaleIcon.isHidden == false && secondFemaleIcon.isHidden == true && secondMaleIcon.isHidden == false {
            bmr = "\(bmrFemaleCalculate)"
           
        } else {
            //
        }
        
        if bmr == "" {
            bmr = "0.0"
        }
        
        let bmiResult = bmiCalculator.init(weightInKG: weightInKG, heightInCM: heightInCM)
        let bmiCalculate = bmiResult.calcBmi()

        bmi = "\(bmiCalculate)"
        yourbmi = "Your BMI Value"
        
       
       
                
            
        
        
        if (bmiCalculate >= 25.0 && bmiCalculate <= 29.9) {
            bmivalue = "Your BMI Value : Overweight"
            let kilos = Need(weightInKG: weightInKG, heightInCM: heightInCM)
            let idealWeightCalculate = kilos.needCalc()
            needweight = "Weight you need to lose:"
            idealweight = "\(idealWeightCalculate)"
            overImage = UIImage(named: "shape.png")
            over?.image = overImage
        
            
        } else if (bmiCalculate < 16.0) {
            bmivalue = "Your BMI Value : Very Severely Underweight"
            let secondKilos = secondNeed(weightInKG: weightInKG, heightInCM: heightInCM)
            let secondCalculate = secondKilos.secondNeedCalc()
            needweight = "Weight you need to gain:"
            idealweight = "\(secondCalculate)"
            verySeverlyImage = UIImage(named: "shape.png")
            verySeverly?.image = verySeverlyImage
            return
        } else if (bmiCalculate >= 16.0 && bmiCalculate <= 16.9) {
            bmivalue = "Your BMI Value : Severely Underweight"
            let secondKilos = secondNeed(weightInKG: weightInKG, heightInCM: heightInCM)
            let secondCalculate = secondKilos.secondNeedCalc()
            needweight = "Weight you need to gain:"
            idealweight = "\(secondCalculate)"
            severlyImage = UIImage(named: "shape.png")
            severly?.image = severlyImage
            return
        } else if (bmiCalculate <= 18.4 && bmiCalculate >= 17.0){
            bmivalue = "Your BMI Value : Underweight"
            let secondKilos = secondNeed(weightInKG: weightInKG, heightInCM: heightInCM)
            let secondCalculate = secondKilos.secondNeedCalc()
            needweight = "Weight you need to gain:"
            idealweight = "\(secondCalculate)"
            underImage = UIImage(named: "shape.png")
            under?.image = underImage
            return
        } else if (bmiCalculate >= 18.5 && bmiCalculate <= 24.9 ){
            bmivalue = "Your BMI Value : Normalweight"
            let normalWeightt = "Congratulations, your weight is normal."
            normalweight = "\(normalWeightt)"
            normalImage = UIImage(named: "shape.png")
            normal?.image = normalImage
            
            
        } else if (bmiCalculate >= 30.0 && bmiCalculate <= 34.9) {
            bmivalue = "Your BMI Value : Obesse Class 1"
            let kilos = Need(weightInKG: weightInKG, heightInCM: heightInCM)
            let idealWeightCalculate = kilos.needCalc()
            needweight = "Weight you need to lose:"
            idealweight = "\(idealWeightCalculate)"
            oneObesseImage = UIImage(named: "shape.png")
            oneObesse?.image = oneObesseImage
        } else if (bmiCalculate >= 35.0 && bmiCalculate <= 39.9) {
            bmivalue = "Your BMI Value : Obesse Class 2"
            let kilos = Need(weightInKG: weightInKG, heightInCM: heightInCM)
            let idealWeightCalculate = kilos.needCalc()
            needweight = "Weight you need to lose:"
            idealweight = "\(idealWeightCalculate)"
            secondObesseImage = UIImage(named: "shape.png")
            secondObesse?.image = secondObesseImage
        } else if (bmiCalculate >= 40.0) {
            bmivalue = "Your BMI Value : Obesse Class 3"
            let kilos = Need(weightInKG: weightInKG, heightInCM: heightInCM)
            let idealWeightCalculate = kilos.needCalc()
            needweight = "Weight you need to lose:"
            idealweight = "\(idealWeightCalculate)"
            thirdObesseImage = UIImage(named: "shape.png")
            thirdObesse?.image = thirdObesseImage
           
        } else {
            //
        }
       
        performSegue(withIdentifier: "toResultVC", sender: nil)
        
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultVC" {
            let destinationVC = segue.destination as! ResultVC
            destinationVC.bmrlabel = bmr
            destinationVC.bmilabel = bmi
            destinationVC.bmivaluelabel = bmivalue
            destinationVC.idealweightlabel = idealweight
            destinationVC.yourbmilabel = yourbmi
            destinationVC.needweightlabel = needweight
            destinationVC.normalweightlabel = normalweight
            
            destinationVC.overweight = overImage
            destinationVC.normalweight = normalImage
            destinationVC.underweight = underImage
            destinationVC.oneobesseweight = oneObesseImage
            destinationVC.secondobesseweight = secondObesseImage
            destinationVC.thirdobesseweight = thirdObesseImage
            destinationVC.severlyunderweight = severlyImage
            destinationVC.veryseverlyunderweight = verySeverlyImage
        }
        
    }
    
    
        
   
    }
        
        
    
   


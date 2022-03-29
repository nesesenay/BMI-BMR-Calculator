import Foundation
import UIKit

struct bmrFemale {
    var weightInKG : Double 
    var heightInCM : Double
    var ageInNum : Double
    
    init(weightInKG : String, heightInCM : String, ageInNum : String ) {
        self.weightInKG = Double(weightInKG) ?? 0.0
        self.heightInCM = Double(heightInCM) ?? 0.0
        self.ageInNum = Double(ageInNum) ?? 0.0
}
    
    func bmrFemaleCalc() -> Double {
        
        if weightInKG.isNaN || weightInKG.isInfinite || weightInKG == 0.0 {
            return 0
        }
        
        if heightInCM.isNaN || heightInCM.isInfinite || heightInCM == 0.0 {
            return 0
        }
        
        if ageInNum.isNaN || ageInNum.isInfinite || ageInNum == 0.0 {
            return 0
        }
        
        return  Double(Int(round(655.1 + (9.56 * weightInKG) + (1.85 * heightInCM) - (4.68 * ageInNum))))
    }
    
}

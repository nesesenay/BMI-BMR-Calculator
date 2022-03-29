import Foundation
import UIKit

struct bmiCalculator {
let weightInKG: Double
let heightInCM: Double

init(weightInKG: String, heightInCM: String) {
    self.weightInKG = Double(weightInKG) ?? 0.0
    self.heightInCM = Double(heightInCM) ?? 0.0
    

}

func calcBmi() -> Double {
    
   
    
    if weightInKG.isNaN || weightInKG.isInfinite  || weightInKG == 0.0 {
        return 0
    }
    
    
    if heightInCM.isNaN || weightInKG.isInfinite || heightInCM == 0.0 {
        return 0
    }
    
    return Double(Int(round(weightInKG / ((heightInCM * heightInCM) / 10000))))
    
}
}

    


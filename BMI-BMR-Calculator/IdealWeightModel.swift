import Foundation
import UIKit

struct Need {
    var weightInKG : Double = 0.0
    var heightInCM : Double = 0.0
    
    init(weightInKG : String, heightInCM : String ) {
        self.weightInKG = Double(weightInKG) ?? 0.0
        self.heightInCM = Double(heightInCM) ?? 0.0
}
    
    func needCalc() -> Double {
        return  Double(Int(round(weightInKG - ( 24.9 * (heightInCM * heightInCM) / 10000))))
        
    }

}

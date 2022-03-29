//
//  bmrForMale.swift
//  BMICalculator
//
//  Created by Erdem Okçu on 31.01.2022.
//

import Foundation
import UIKit

struct bmrMale {
    var weightInKG : Double
    var heightInCM : Double
    var ageInNum : Double 
    
    init(weightInKG : String, heightInCM : String, ageInNum : String ) {
        self.weightInKG = Double(weightInKG) ?? 0.0
        self.heightInCM = Double(heightInCM) ?? 0.0
        self.ageInNum = Double(ageInNum) ?? 0.0
}
    
    func bmrMaleCalc() -> Double {
        if weightInKG.isNaN || weightInKG.isInfinite || weightInKG == 0.0 {
            return 0
        }
        
        if heightInCM.isNaN || heightInCM.isInfinite || heightInCM == 0.0 {
            return 0
        }
        
        if ageInNum.isNaN || ageInNum.isInfinite || ageInNum == 0.0 {
            return 0
        }
        
        return  Double(Int(round(66.5 + (13.75 * weightInKG) + (5.03 * heightInCM) - (6.75 * ageInNum))))
    }
    
}


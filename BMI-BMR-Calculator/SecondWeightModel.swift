//
//  SecondWeightModel.swift
//  BMICalculator
//
//  Created by Erdem Okçu on 19.01.2022.
//

import Foundation
import UIKit

struct  secondNeed{
    var weightInKG : Double = 0.0
    var heightInCM : Double = 0.0
    
    init(weightInKG : String, heightInCM : String ) {
        self.weightInKG = Double(weightInKG) ?? 0.0
        self.heightInCM = Double(heightInCM) ?? 0.0
}
    
    func secondNeedCalc() -> Double {
        return  Double(Int(round( 18.5 * (heightInCM * heightInCM) / 10000) - weightInKG))
        
    }

}

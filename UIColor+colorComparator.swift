//
//  UIColor+colorComparator.swift
//  OOTDPicker
//
//  Created by Ler Wilson on 18/10/16.
//  Copyright © 2016 Ler Wilson. All rights reserved.
//

import UIKit


extension UIColor {
    
    func compare(colorToCompare: UIColor) -> Double {
        
        let originalL = Double(colorToCompare.CIE_LAB().l)
        let originalB = Double(colorToCompare.CIE_LAB().b)
        let originalA = Double(colorToCompare.CIE_LAB().a)
        
        let colorL = Double(self.CIE_LAB().l)
        let colora = Double(self.CIE_LAB().a)
        let colorb = Double(self.CIE_LAB().b)
        
        let differenceL = pow(originalL-colorL, 2)
        let differenceA = pow(originalA-colora, 2)
        let differenceB = pow(originalB-colorb, 2)
        
        
        
        let difference = sqrt((differenceL)+(differenceA)+(differenceB))
        //print(difference)
        
        return difference
    
    }
}

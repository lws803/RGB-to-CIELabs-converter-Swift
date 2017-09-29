//
//  UIColor+CielabsConversion.swift
//  OOTDPicker
//
//  Created by Ler Wilson on 18/10/16.
//  Copyright © 2016 Ler Wilson. All rights reserved.
//

import UIKit

extension UIColor {
    
    
    /// Color transformer from rgba to cieLabs
    typealias TransformBlock = (CGFloat) -> CGFloat
    
    func rgba() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let components = self.cgColor.components
        let numberOfComponents = self.cgColor.numberOfComponents
        
        switch numberOfComponents {
        case 4:
            return (components![0], components![1], components![2], components![3])
        case 2:
            return (components![0], components![0], components![0], components![1])
        default:
            // FIXME: Fallback to black
            return (0, 0, 0, 1)
        }
    }
    
    func xyz() -> (x: CGFloat, y: CGFloat, z: CGFloat, alpha: CGFloat) {
        // Get RGBA values
        let rgbaT = rgba()
        
        // Transfrom values to XYZ
        let deltaR: TransformBlock = { R in
            return (R > 0.04045) ? pow((R + 0.055)/1.055, 2.40) : (R/12.92)
        }
        let R = deltaR(rgbaT.r)
        let G = deltaR(rgbaT.g)
        let B = deltaR(rgbaT.b)
        let X = (R*41.24 + G*35.76 + B*18.05)
        let Y = (R*21.26 + G*71.52 + B*7.22)
        let Z = (R*1.93 + G*11.92 + B*95.05)
        
        return (X, Y, Z, rgbaT.a)
    }
    
    
    
    func CIE_LAB() -> (l: CGFloat, a: CGFloat, b: CGFloat, alpha: CGFloat) {
        // Get XYZ
        let xyzT = xyz()
        let x = xyzT.x/95.047
        let y = xyzT.y/100.000
        let z = xyzT.z/108.883
        
        // Transfrom XYZ to L*a*b
        let deltaF: TransformBlock = { f in
            let transformation = (f > 0.00885645167904) ? pow(f, 1.0/3.0) : (1/3) * (841/36) * f + 4/29.0
            
            return (transformation)
        }
        let X = deltaF(x)
        let Y = deltaF(y)
        let Z = deltaF(z)
        let L = 116*Y - 16
        let a = 500 * (X - Y)
        let b = 200 * (Y - Z)
        return (L, a, b, xyzT.alpha)
    }
    



}




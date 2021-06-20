//
//  Color.swift
//  PandaMovies
//
//  Created by Arlin Ropero on 20/06/21.
//

import UIKit

extension UIColor {
    
    func inverseColor() -> UIColor {
        var alpha: CGFloat = 1.0

        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: 1.0 - red, green: 1.0 - green, blue: 1.0 - blue, alpha: alpha)
        }

        var hue: CGFloat = 0.0, saturation: CGFloat = 0.0, brightness: CGFloat = 0.0
        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: 1.0 - hue, saturation: 1.0 - saturation, brightness: 1.0 - brightness, alpha: alpha)
        }

        var white: CGFloat = 0.0
        if self.getWhite(&white, alpha: &alpha) {
            return UIColor(white: 1.0 - white, alpha: alpha)
        }

        return self
    }
    
    // Check if the color is light or dark, as defined by the injected lightness threshold.
    // Some people report that 0.7 is best. I suggest to find out for yourself.
    // A nil value is returned if the lightness couldn't be determined.
    func isLight(threshold: Float = 0.5) -> Bool? {
        let originalCGColor = self.cgColor
        // Now we need to convert it to the RGB colorspace. UIColor.white / UIColor.black are greyscale and not RGB.
        // If you don't do this then you will crash when accessing components index 2 below when evaluating greyscale colors.
        let RGBCGColor = originalCGColor.converted(to: CGColorSpaceCreateDeviceRGB(), intent: .defaultIntent, options: nil)
        guard let components = RGBCGColor?.components else {
            return nil
        }
        guard components.count >= 3 else {
            return nil
        }
        let brightness = Float(((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000)
        return (brightness > threshold)
    }
    
}

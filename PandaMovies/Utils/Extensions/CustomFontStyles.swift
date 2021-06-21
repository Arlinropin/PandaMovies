//
//  CustomFontStyles.swift
//  CBook
//
//  Created by Arlin Ropero on 1/06/21.
//

import UIKit

extension String {
    
    func N(size: Int = 17, color: UIColor = .black) -> NSMutableAttributedString {
        let attributes: [NSMutableAttributedString.Key: Any] = [
            .font : UIFont(name: "DINAlternate-Bold", size: CGFloat(size)) as Any,
            .foregroundColor: color,
        ]
        // set label Attribute
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
    
    func B(size: Int = 17, color: UIColor = .black) -> NSMutableAttributedString {
        let attributes: [NSMutableAttributedString.Key: Any] = [
            .font : UIFont(name: "DINCondensed-Bold", size: CGFloat(size)) as Any,
            .foregroundColor: color,
        ]
        // set label Attribute
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
}

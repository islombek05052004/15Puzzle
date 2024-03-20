//
//  ExtensionUIElements.swift
//  15Puzzle_1_1
//
//  Created by Abdurazzoqov Islombek on 04/06/23.
//

import UIKit

extension UILabel {
    static func textPropertiesBackColor(_ backColor: UIColor, _ textColor: UIColor, _ textAligment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.backgroundColor = backColor
        label.textColor = textColor
        label.textAlignment = textAligment
        return label 
    }
}

extension UIButton {
    static func borRadBackColor(_ clipToBounds: Bool, _ cornerRadius: CGFloat, _ backColor: UIColor ) -> UIButton {
        let btn = UIButton()
        btn.clipsToBounds = clipToBounds
        btn.layer.cornerRadius = cornerRadius
        btn.backgroundColor = backColor
        return btn
    }
}

extension UITextField {
    static func placeHBorderSTextandBackC(_ borderS: BorderStyle, _ textC : UIColor, _ backC: UIColor) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = borderS
        textField.textColor = textC
        textField.backgroundColor = backC
        return textField
    }
}

extension UIColor {
    static func rgbColor(r: CGFloat, g: CGFloat, b: CGFloat, aplha:CGFloat = 1) -> UIColor {
        UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

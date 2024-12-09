import UIKit

extension UILabel {
    
    convenience init(text: String?, lines: Int = 1, alignment: NSTextAlignment = .left, textColor: UIColor = .label, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = lines
        self.textAlignment = alignment
        self.textColor = textColor
        self.font = font
    }
}

import Foundation

extension UIColor {

    convenience init(hexValue: Int) {
        let red = CGFloat((hexValue & 0xFF0000) >> 16) / 255
        let green = CGFloat((hexValue & 0xFF00) >> 8) / 255
        let blue = CGFloat(hexValue & 0xFF) / 255

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

    class func customBackgroundColor() -> UIColor! {
        return UIColor(hexValue: 0x0079FF)
    }

}

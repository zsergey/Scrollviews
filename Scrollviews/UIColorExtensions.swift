import UIKit

extension UIColor {
	
	static var pageBackground = UIColor(hex: 0x202025)
	
	static var color1 = UIColor(hex: 0xE3529B)
	static var color2 = UIColor(hex: 0x65BBDC)
	static var color3 = UIColor(hex: 0xEC6B69)
	static var color4 = UIColor(hex: 0x82D4C1)
	static var color5 = UIColor(hex: 0xB283F8)
	
	convenience init(hex: Int, alpha: CGFloat = 1) {
		let r = CGFloat((hex & 0xFF0000) >> 16) / 255
		let g = CGFloat((hex & 0xFF00) >> 8) / 255
		let b = CGFloat((hex & 0xFF)) / 255
		self.init(red: r, green: g, blue: b, alpha: alpha)
	}
}

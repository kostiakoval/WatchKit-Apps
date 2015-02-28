
import UIKit

extension String {

  public var CGColor: CGColorRef {
    return self.CGColor(1)
  }

  public var UIColor: UIKit.UIColor {
    return self.UIColor(1)
  }
  
  public func CGColor (alpha: CGFloat) -> CGColorRef {
    return self.UIColor(alpha).CGColor
  }
  
  public func UIColor (alpha: CGFloat) -> UIKit.UIColor {
    var hex = self
    
    if hex.hasPrefix("#") { // Strip leading "#" if it exists
      hex = hex.substringFromIndex(hex.startIndex.successor())
    }
    
    switch count(hex) {
      case 1: // Turn "f" into "ffffff"
        hex = hex.repeat(6)
      case 2: // Turn "ff" into "ffffff"
        hex = hex.repeat(3)
      case 3: // Turn "123" into "112233"
        hex = hex[0].repeat(2) + hex[1].repeat(2) + hex[2].repeat(2)
      default:
        break
    }
    
    assert(count(hex) == 6, "Invalid hex value")
    
    var r: UInt32 = 0
    var g: UInt32 = 0
    var b: UInt32 = 0
    
    NSScanner(string: "0x" + hex[0...1]).scanHexInt(&r)
    NSScanner(string: "0x" + hex[2...3]).scanHexInt(&g)
    NSScanner(string: "0x" + hex[4...5]).scanHexInt(&b)
    
    let red = CGFloat(Int(r)) / CGFloat(255.0)
    let green = CGFloat(Int(g)) / CGFloat(255.0)
    let blue = CGFloat(Int(b)) / CGFloat(255.0)
    
    return UIKit.UIColor(red: red, green: green, blue: blue, alpha: alpha)
  }
}

private extension String {
  
  func repeat (countNumber: Int) -> String {
    return "".stringByPaddingToLength(count(self) * countNumber, withString: self, startingAtIndex:0)
  }
  
  subscript (i: Int) -> String {
    return String(Array(self)[i])
  }
  
  subscript (r: Range<Int>) -> String {
    return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
  }
}

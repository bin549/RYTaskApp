import Foundation

struct ButtonOptions: OptionSet {
    let rawValue: Int
    
    static let roundedText = ButtonOptions(rawValue: 1 << 0)
    static let squareIcon = ButtonOptions(rawValue: 1 << 1)
}

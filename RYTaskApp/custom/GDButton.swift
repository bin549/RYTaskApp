import UIKit

class GDButton:UIButton {
    var title:String!
    var type:ButtonOptions!
    var radius:CGFloat!
    
    init(title:String = "button text", frame:CGRect = .zero, type:ButtonOptions = .roundedText, radius:CGFloat = 30) {
        super.init(frame: frame)
        if frame == .zero {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        self.title = title
        self.type = type
        self.radius = radius
        self.phaseTwo()
    }
    
    func phaseTwo() {
        self.backgroundColor = .white
        if let titleLabel = self.titleLabel {
            titleLabel.font = UIFont(name: "Raleway-v4020-Regular", size: 36)
        }
        switch self.type {
            case ButtonOptions.roundedText:
                self.roundedText()
            case ButtonOptions.squareIcon:
                self.squareIcon()
            default: break;
        }
    }
    
    func squareIcon() {
        self.setImage(UIImage(named: "add-icon"), for: .normal)
    }

    func roundedText() {
        self.setTitle(self.title, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.layer.cornerRadius = self.radius
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

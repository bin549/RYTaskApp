import UIKit

class GDHeaderView:UIView {
    let bg = GDGradient()
    let titleLabel = GDLabel(size: 14)
    let subtitleLabel = GDLabel(size: 24)
    let addButton = GDButton(type: .squareIcon)
    var delegate:GDHeaderDelegate?
    
    init(frame: CGRect = .zero, title:String = "header title", subtitle:String = "header subtitle") {
        super.init(frame: frame)
        if frame == .zero {
            translatesAutoresizingMaskIntoConstraints = false
        }
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        setupLayout()
    }
    
    var itemsLeft:Int = 0 {
        didSet {
            self.subtitleLabel.text = "剩下\(itemsLeft)项"
        }
    }

    func setupLayout() {
        addSubview(bg)
        bg.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bg.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 32).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20 + 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: centerXAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20 + 16).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: centerXAnchor, constant: 50).isActive = true
        addSubview(addButton)
        addButton.bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor).isActive = true
        addButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20 - 16 - 14).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor, multiplier: 1).isActive = true
        addButton.addTarget(self, action: #selector(self.handleAddButton), for: .touchUpInside)
    }
    
    @objc func handleAddButton() {
        if let delegate = self.delegate {
            delegate.openAddItemPopup()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

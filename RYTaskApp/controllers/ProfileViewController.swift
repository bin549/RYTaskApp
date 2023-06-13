import UIKit

class ProfileViewController: UIViewController {
    var vc = DrawController()
    let backProgressLayer = CAShapeLayer()
    let bg:UIView = {
        let view = GDGradient()
        view.layer.cornerRadius = 24
        return view
    }()
    let titleLabel = GDLabel(title: "GET IT DONE", size: 24, textAlign: .center)
    let infoLabel:UILabel = {
        let label = GDLabel(title: "WELCOME. GET IT DONE IS A TO DO LIST.\nA REALLY DOPE TO-DO-LIST.", size: 14, textAlign: .center)
        label.numberOfLines = 2
        return label
    }()
    let nextButton = GDButton(title: "START WINNING", type: .roundedText)
     
    @objc func handleNext() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.nextButton.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { (_) in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.nextButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            }) { (_) in
                self.present(self.vc, animated: true)
//                self.present(DrawController(), animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vc = storyboard?.instantiateViewController(withIdentifier: "draw_vc") as! DrawController
        UserDefaults.standard.set(true, forKey: "welcome-controller-visited")
        nextButton.addTarget(self, action: #selector(self.handleNext), for: [.touchUpInside,.touchUpOutside])
        view.backgroundColor = .white
        view.addSubview(bg)
        bg.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        bg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        bg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        bg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        bg.addSubview(titleLabel)
        titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: bg.topAnchor, constant: 60).isActive = true
        bg.addSubview(infoLabel)
        infoLabel.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: bg.centerYAnchor).isActive = true
        infoLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        bg.addSubview(nextButton)
        nextButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: bg.bottomAnchor, constant: -60).isActive = true
    }
}

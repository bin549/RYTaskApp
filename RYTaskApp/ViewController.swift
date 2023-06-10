import UIKit

class ViewController: UIViewController {
    lazy var logoImage: UIImageView = {
        let image = UIImage(named: "cat")!
        let imageView = UIImageView(image: image)
        imageView.layer.masksToBounds = true
        return imageView
    }()

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginView: UIView!
    var moveLogoAnimator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        loginView.addSubview(logoImage)
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: loginView.centerYAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: CGFloat(100.0)),
            logoImage.widthAnchor.constraint(equalToConstant: CGFloat(100.0))
        ])
        loginView.transform = CGAffineTransform(scaleX: 0, y: 0)
        usernameTextField.alpha = CGFloat(0)
        passwordTextField.alpha = CGFloat(0)
        loginButton.alpha = CGFloat(0)
        loginView.backgroundColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1.0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginView.layer.cornerRadius = CGFloat(7.0)
        loginButton.layer.cornerRadius = CGFloat(5.0)
        logoImage.layer.cornerRadius = CGFloat(50.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.8, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseOut, animations: {
            self.loginView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (success) in
            self.setupMoveLogoAnimation()
            self.moveLogoAnimator.startAnimation()
        }
    }
    
    func setupMoveLogoAnimation() {
        moveLogoAnimator = UIViewPropertyAnimator(duration: 2.0, curve: .easeIn, animations: nil)
        moveLogoAnimator.addAnimations({
            self.logoImage.frame.origin.y = CGFloat(20.0)
            self.loginView.backgroundColor = UIColor.white
        }, delayFactor: 0.2)
        moveLogoAnimator.addAnimations({
            self.usernameTextField.alpha = 1.0
        }, delayFactor: 0.6)
        moveLogoAnimator.addAnimations({
            self.passwordTextField.alpha = 1.0
        }, delayFactor: 0.7)
        moveLogoAnimator.addAnimations({
            self.loginButton.alpha = 1.0
        }, delayFactor: 0.8)
    }
}


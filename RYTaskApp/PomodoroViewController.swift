import UIKit

class PomodoroViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    let foreProgressLayer = CAShapeLayer()
    let backProgressLayer = CAShapeLayer()
    let animation = CABasicAnimation(keyPath: "strokeEnd")


    var timer = Timer()
    var isTimerStarted = false
    var isAnimationStarted = false
    // var time = 1500
    var time = 5


    override func viewDidLoad() {
        super.viewDidLoad()
        drawBackLayer()
    }
    
    @IBAction func didTapButton() {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        cancelButton.isEnabled = true
        cancelButton.alpha = 1.0
        if !isTimerStarted {
            startTimer()
            isTimerStarted = true
            startButton.setTitle("Pause", for: .normal)
            startButton.setTitleColor(UIColor.orange, for: .normal)
        } else {
            timer.invalidate()
            isTimerStarted = false
            startButton.setTitle("Resume", for: .normal)
            startButton.setTitleColor(UIColor.green, for: .normal)
        }
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        cancelButton.isEnabled = false
        cancelButton.alpha = 0.5
        startButton.setTitle("Start", for: .normal)
        timer.invalidate()
        time = 1500
        isTimerStarted = false
        timeLabel.text = "25:00"
    }

    func startTimer(){
       timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
     }

    @objc func updateTimer(){
        if time<1 {
            cancelButton.isEnabled = false
            cancelButton.alpha = 0.5
            startButton.setTitle("Start", for: .normal)
            startButton.setTitleColor(UIColor.green, for: .normal)
            timer.invalidate()
            time = 5
            isTimerStarted = false
            timeLabel.text = "25:00"
        } else {
            time -= 1
            timeLabel.text = formatTime()
        }
    }

    func formatTime()->String{
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }

    func drawBackLayer() {
        backProgressLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY), radius: 100, startAngle: -90.degressToRadians, endAngle: 270.degressToRadians, clockwise: true).cgPath
        backProgressLayer.strokeColor = UIColor.white.cgColor
        backProgressLayer.fillColor = UIColor.clear.cgColor
        backProgressLayer.lineWidth = 15
        view.layer.addSublayer(backProgressLayer)
    }
}


extension Int {
    var degressToRadians: CGFloat {
        return CGFloat(self) * .pi / 100
    }
}
    

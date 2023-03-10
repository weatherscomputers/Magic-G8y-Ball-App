//  Magic G8y Ball
//
//
//  Created by Mark Weathers on 2/2/23.
//
//Customer hits rules, pop up happens that say rules and what to say, shakes the phone, answers appear that they are randomly selected but actually always yes gay answers appear

// 1. VC needs to be first responder to the
// 2. VC needs to be able to become 1st responder
// 3. Detect Shake

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var eightBallImage: UIImageView!
    @IBOutlet var eightBallLabel: UILabel!
    
    var images: [UIImage] = EightBallImages.images

    
    
    var seconds = 2
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make 8BallVC first responder
        becomeFirstResponder()
        
    }
    // by default the view controller is not able to become a first responder so override canBecomeFirstResponder and return true
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    // functions to detect when motion begins and ends when user shakes the phone
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if motion == .motionShake {
            
            
            // Scheduled timer 1 second that repeats itself that when seconds variable goes down by 1 second when hits 0 displays answer
            //**BUG fixed** after you shake once shaking again is caught in endless loop of shaking with nothing displayed -- fixed by resetting seconds to 2 in the if statement
            
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.seconds -= 1
                self.eightBallImage.image = UIImage(named: "Back8Ball")
                self.eightBallLabel.text = " "
                self.eightBallImage.shake(shakeCount: 3)
                if self.seconds == 0 {
                    self.eightBallImage.image = self.images.randomElement() ?? UIImage(named: "Back8Ball")
                    self.eightBallLabel.text = "You are Gay shake again if you would like"
                    timer.invalidate()
                    self.seconds = 2
                }
            }
            
            
            
           
           
        }
        
    }
    
    
    
}

extension UIView{
    
    func shake(duration: TimeInterval = 0.05, shakeCount: Float = 6, xValue: CGFloat = 12, yValue: CGFloat = 0){
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = duration
            animation.repeatCount = shakeCount
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - xValue, y: self.center.y - yValue))
            animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + xValue, y: self.center.y - yValue))
            self.layer.add(animation, forKey: "shake")
        }
}
// Notes:
//a Responder is first in line to respond to any given event
// in iOS you have a bunch of objects that can respond to any given event and they are setup in a Responder chain
// in this case we are making our 8BallVC the first responder in this chain to respond to the given event

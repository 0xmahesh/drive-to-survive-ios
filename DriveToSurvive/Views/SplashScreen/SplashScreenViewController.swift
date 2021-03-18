//
//  SplashScreenViewController.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 2/10/21.
//

import UIKit
import Lottie

let reuseIdentifier = "CellIdentifer"

class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var launchButton: UIButton!
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            animationView.contentMode = .scaleAspectFit
          
          animationView.loopMode = .loop
        animationView.transform = CGAffineTransform(scaleX: 2, y: 2)
          animationView.animationSpeed = 1
        animationView.flash(numberOfFlashes: 1000)
          animationView.play()
    }
 
//    @IBAction func launchButtonTapped(_ sender: Any) {
//        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
//        self.present(homeVC, animated: true, completion: nil)
//        //self.navigationController?.pushViewController(homeVC, animated: true)
//    }
//
    @IBAction func launchButtonTapped(_ sender: Any) {
        
        
        let introVC = IntroScreenViewController(nibName: "IntroScreenViewController", bundle: nil)
        self.present(introVC, animated: true, completion: nil)
        
        /* when user taps this button, set lottie frame to make sure the car is
         headed towards the right side, and then animate it off the screen. as soon as it
         goes off screen we show the next view controller. */
        
//        UIView.animateKeyframes(withDuration: 3.0, delay: 0, options: .calculationModeLinear, animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
//                self.animationView.animationSpeed = 5
//            })
//            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1, animations: {
//                self.animationView.animationSpeed = 15
//            })
//            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 1, animations: {
//                self.animationView.animationSpeed = 20
//                self.animationView.alpha = 0
//            })
//
//        }, completion: { completed in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//
//                let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
//                self.present(homeVC, animated: true, completion: nil)
//            })
//        })

    }
    
    
    
}

extension UIView {
        func flash(numberOfFlashes: Float) {
           let flash = CABasicAnimation(keyPath: "opacity")
           flash.duration = 0.5
           flash.fromValue = 1
           flash.toValue = 0.75
           flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
           flash.autoreverses = true
           flash.repeatCount = numberOfFlashes
           layer.add(flash, forKey: nil)
       }
 }

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
        
        self.navigationController?.navigationBar.isHidden = true
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.transform = CGAffineTransform(scaleX: 2, y: 2)
        animationView.animationSpeed = 1
        animationView.flash(numberOfFlashes: .greatestFiniteMagnitude)
        animationView.play()
    }
    
    @IBAction func launchButtonTapped(_ sender: Any) {
        let introVC = IntroScreenViewController(nibName: "IntroScreenViewController", bundle: nil)
        self.presentInFullScreen(introVC, animated: true, completion: nil)
        
        
        // TODO: Mahesh
        /* when user taps this button, set lottie frame to make sure the car is
         headed towards the right side, and then animate it off the screen. as soon as it
         goes off screen we show the next view controller. */
       
        
    }
    
    
    
}

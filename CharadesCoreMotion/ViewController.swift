//
//  ViewController.swift
//  CharadesCoreMotion
//
//  Created by Mariano Patino-Paul on 2015.
//  Prepared for Github on 1/6/21.
//  mariano@patinopaul.com
//

import UIKit
import CoreMotion

let manager = CMMotionManager()
var initialAttitude = manager.deviceMotion!.attitude
var data = manager.deviceMotion

// Landmarks
let L1 = 0.55 // 0.55 Pass

let L2 = 1.10 // Forehead Start
let L3 = 2.20 // 1.85 Forehead End

let L4 = 2.65 // 2.65 Correct

class ViewController: UIViewController {

    @IBOutlet var myLabel: UILabel!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        func motionData(from attitude: CMAttitude) -> Double {
            return attitude.roll
        }
        
        if manager.isDeviceMotionAvailable {
            
            // Start getting data from device movement
            manager.startDeviceMotionUpdates(to: .main) {
             
                [weak self] (data: CMDeviceMotion?, error: Error?) in
                guard let data = data else { return }
                
                let deviceMotionData = motionData(from: data.attitude)*(-1)
                
                //Phone is in Forehead
                if deviceMotionData > L2 && deviceMotionData < L3 {
                    self!.myLabel?.text = "Forehead"
                    self?.view.backgroundColor = .blue
                }
                
                //Phone is in "Pass" position
                if deviceMotionData > L1 && deviceMotionData < L2 {
                    self!.myLabel?.text = "Pass"
                    self?.view.backgroundColor = .red
                }
                    
                //Phone is in "Correct" position
                if deviceMotionData > L3 && deviceMotionData < L4 {
                    self!.myLabel?.text = "Correct"
                    self?.view.backgroundColor = .green
                }
            }
        }
    }


}


//
//  CustomHapticsViewController.swift
//  HapticFeedbackTests
//
//  Created by DenisSuspitsyn on 07.09.2020.
//  Copyright © 2020 Denis Suspicin. All rights reserved.
//

import UIKit
import CoreHaptics

class CustomHapticsViewController: UIViewController {
    
    // A haptic engine manages the connection to the haptic server.
    var engine: CHHapticEngine!
    
    // Maintain a variable to check for Core Haptics compatibility on device.
    lazy var suppportsHaptics: Bool = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.supportsHaptics
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the engine before doing anything else.
        createEngine()
    }
    
    /// - Tag: CreateEngine
    func createEngine() {
        // Create and configure a hapric engine
        do {
            engine = try CHHapticEngine()
        } catch let error {
            print("Engine Creation Error: \(error)")
        }
        
        if engine == nil {
            print("Failed to create engine!")
        }
        
        // The stopped handler alerts you of engint stoppage due external causes.
        engine.stoppedHandler = { reason in
            print("The engine stopped for reason: \(reason.rawValue)")
            switch reason {
            case .audioSessionInterrupt:
                print("Audio session interrupt")
            case .applicationSuspended:
                print("Application suspended")
            case .idleTimeout:
                print("Idle timeout")
            case .systemError:
                print("System error")
            case .notifyWhenFinished:
                print("Playback finished")
            @unknown default:
                print("Unknown error")
            }
        }
    }
    
    /// - Tag: PlayAHAP
    func playHapticsFile(named filename: String) {
        
        // If the device doesn`t support Core Haptics, abort.
        if !suppportsHaptics { return }
        
        guard let path = Bundle.main.path(forResource: filename, ofType: "ahap") else { return }
        
        do {
            // Start the enhine in case it`s idle.
            try engine.start()
            
            // Tell the engine to play a pattern.
            try engine.playPattern(from: URL(fileURLWithPath: path))
            
        } catch {
            print("An error occured playing \(filename): \(error).")
        }
    }
    
    @IBAction func customHupticButtonPressed(_ sender: UIButton) {
        playHapticsFile(named: "AHAP/CrackingIce/Short/haptic")
    }
    
    //MARK: - Actions play Transient AHAPs
    @IBAction func test1ButtonPressed(_ sender: UIButton) {
        playHapticsFile(named: "AHAP/TransientTests/Test1")
    }
    @IBAction func test2ButtonPressed(_ sender: UIButton) {
        playHapticsFile(named: "AHAP/TransientTests/Test2")
    }
    
    @IBAction func test3ButtonPressed(_ sender: UIButton) {
        playHapticsFile(named: "AHAP/TransientTests/Test3")
    }
    
    @IBAction func test4ButtonPressed(_ sender: UIButton) {
        playHapticsFile(named: "AHAP/TransientTests/Test4")
    }
    
    
    //MARK: - Actions play Continuous AHAPs
    
    @IBAction func cTest1ButtonPressed(_ sender: UIButton) {
        playHapticsFile(named: "AHAP/ContinuousTests/CTest1")
    }
    
    @IBAction func cTest2ButtonPressed(_ sender: UIButton) {
        playHapticsFile(named: "AHAP/ContinuousTests/CTest2")
    }
    
    @IBAction func cTest3ButtonPressed(_ sender: UIButton) {
        playHapticsFile(named: "AHAP/ContinuousTests/CTest3")
    }
    
    @IBAction func cTest4ButtonPressed(_ sender: UIButton) {
        playHapticsFile(named: "AHAP/ContinuousTests/CTest4")
    }
    
    
    
}

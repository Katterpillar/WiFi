//
//  ButtoBuilder.swift
//  FINAL Project
//
//  Created by Katherine on 07/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    let timerStep: TimeInterval = 0.01
    let animateTime: TimeInterval = 0.4
    let touchDownAlpha: CGFloat = 0.3
    var color: UIColor = .black
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                touchDown()
            } else {
                cancelTracking(with: nil)
                touchUp()
            }
        }
    }
    
    weak var timer: Timer?
    
    lazy var alphaStep: CGFloat = {
        return (1 - touchDownAlpha) / CGFloat(animateTime / timerStep)
    }()
    
    func stopTimer() {
        timer?.invalidate()
    }
    deinit {
        stopTimer()
    }
    
    func setup() {
        backgroundColor = .clear
        layer.backgroundColor = color.cgColor
        
        layer.cornerRadius = 6
        clipsToBounds = true
    }
    
    convenience init(color: UIColor? = nil, title: String? = nil) {
        self.init(type: .custom)
        if let color = color {
            self.color = color
        }
        if let title = title {
            setTitle(title, for: .normal)
        }
        setup()
    }
    
    func touchDown() {
        stopTimer()
        layer.backgroundColor = color.withAlphaComponent(touchDownAlpha).cgColor
    }
    
    func touchUp() {
        timer = Timer.scheduledTimer(timeInterval: timerStep,
                                     target: self,
                                     selector: #selector(animation),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func animation() {
        guard let backgroundAlpha = layer.backgroundColor?.alpha else {
            stopTimer()
            
            return
        }
        
        let newAlpha = backgroundAlpha + alphaStep
        
        if newAlpha < 1 {
            layer.backgroundColor = color.withAlphaComponent(newAlpha).cgColor
        } else {
            layer.backgroundColor = color.cgColor
            
            stopTimer()
        }
    }
}



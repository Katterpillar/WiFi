//
//  ButtoBuilder.swift
//  FINAL Project
//
//  Created by Katherine on 07/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

///класс для создания кнопки
class CustomButton: UIButton {
    
    private let timerStep: TimeInterval = 0.01
    private let animateTime: TimeInterval = 0.4
    private let touchDownAlpha: CGFloat = 0.3
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
    
    private lazy var alphaStep: CGFloat = {
        return (1 - touchDownAlpha) / CGFloat(animateTime / timerStep)
    }()
    
    ///останавливает таймер
    private func stopTimer() {
        timer?.invalidate()
    }
    deinit {
        stopTimer()
    }
    
    ///устанавливает атрибуты для кновки: цвет фона, закругление
    private func setup() {
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
    
    ///действие при нажатии кнопки
    private func touchDown() {
        stopTimer()
        layer.backgroundColor = color.withAlphaComponent(touchDownAlpha).cgColor
    }
    
    ///действие при отпускании кнопки
    private func touchUp() {
        timer = Timer.scheduledTimer(timeInterval: timerStep,
                                     target: self,
                                     selector: #selector(animation),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    ///добавление к кнопке анимации
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



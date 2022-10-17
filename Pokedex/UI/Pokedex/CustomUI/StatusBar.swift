//
//  StatusBar.swift
//  Pokedex
//
//  Created by Eliano Corallo on 14/10/22.
//

import UIKit

class StatusBar: UIView {
    
    private var color: UIColor?
    private var value: Int = 0
    private let maxValue: Int = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let radius = rect.height / 2.0
        drawBackgroundPath(in: rect, radius: radius)
        
        var newRect = rect
        let maxVal: CGFloat = CGFloat(max(value, maxValue))
        newRect.size.width = (CGFloat(value) / maxVal) * rect.width
        drawProgress(in: newRect, radius: radius)
    }
    
    private func drawBackgroundPath(in rect: CGRect, radius: CGFloat) {
        let whitePath = UIBezierPath(roundedRect: rect, cornerRadius: radius)
        UIColor.lightGray.setFill()
        whitePath.fill()
    }
    
    private func drawProgress(in rect: CGRect, radius: CGFloat) {
        let progressPath = UIBezierPath(roundedRect: rect, cornerRadius: radius)
        color?.setFill()
        progressPath.fill()
    }
    
    func configure(with item: StatisticItem) {
        value = item.baseStat
        color = item.statEnum?.color
        setNeedsDisplay()
    }
}

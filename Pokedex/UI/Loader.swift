//
//  Loader.swift
//  Pokedex
//
//  Created by Eliano Corallo on 14/10/22.
//
import UIKit
import Lottie

final class Loader: UIView {
    
    @ProgrammaticallyConstrained private var lottieAnimation: LottieAnimationView
    
    override init(frame: CGRect) {
        lottieAnimation = LottieAnimationView(name: "PokeballLoading")
        super.init(frame: frame)
        setupLottieAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLottieAnimation() {
        lottieAnimation.backgroundBehavior = .pauseAndRestore
        lottieAnimation.loopMode = .loop
        lottieAnimation.edgeTo(view: self)
    }
    
    func animate() {
        DispatchQueue.main.async { [weak self] in
            self?.lottieAnimation.play()
        }
    }
    
    func stop() {
        DispatchQueue.main.async { [weak self] in
            self?.lottieAnimation.stop()
        }
    }
}

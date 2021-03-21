//
//  CardConfig.swift
//  CinemaTv
//
//  Created by Danilo Requena on 21/03/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

enum CardState {
    case collapsed, expanded
}

final class CardConfig {
    var viewModel: DetailViewModel?
    var runningAnimations = [UIViewPropertyAnimator]()
    var cardVisible = false
    var cardViewController: OverlayViewController!
    var animationProgressWhenInterrupted: CGFloat =  0
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    var visualEffectView: UIVisualEffectView!
    var endCardHeight: CGFloat = 0
    var startCardHeight: CGFloat = 0
    var view: UIView
    
    init(view: UIView) {
        self.view = view
    }
    
    func setupCardMovies(infos: ResultDiscover) {
        endCardHeight =  view.frame.height * 0.8
        startCardHeight =  view.frame.height * 0.3
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = view.frame
        view.addSubview(visualEffectView)
        
        cardViewController = OverlayViewController(discoverMovies: infos)
        view.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x: 0, y: view.frame.height / 2, width: view.bounds.width, height: endCardHeight)
        cardViewController.view.clipsToBounds = true
        cardViewController.view.layer.cornerRadius = 10

        let tapGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(handleCardTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))

        cardViewController.handleView.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleView.addGestureRecognizer(panGestureRecognizer)
    }
    
    func setupCardPop(mainView: UIView, infos: ResultSeries) {
        endCardHeight =  view.frame.height * 0.8
        startCardHeight =  view.frame.height * 0.3
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = view.frame
        view.addSubview(visualEffectView)
        
        cardViewController = OverlayViewController(seriesPop: infos)
        view.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x: 0, y: view.frame.height / 2, width: view.bounds.width, height: endCardHeight)
        cardViewController.view.clipsToBounds = true
        cardViewController.view.layer.cornerRadius = 10

        let tapGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(handleCardTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))

        cardViewController.handleView.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleView.addGestureRecognizer(panGestureRecognizer)
    }
    
    func setupCardSeriesOnAir(mainView: UIView, infos: ResultDiscoverSeries) {
        endCardHeight =  view.frame.height * 0.8
        startCardHeight =  view.frame.height * 0.3
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = view.frame
        view.addSubview(visualEffectView)
        
        cardViewController = OverlayViewController(discoverSeries: infos)
        view.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x: 0, y: view.frame.height / 2, width: view.bounds.width, height: endCardHeight)
        cardViewController.view.clipsToBounds = true
        cardViewController.view.layer.cornerRadius = 10

        let tapGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(handleCardTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))

        cardViewController.handleView.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleView.addGestureRecognizer(panGestureRecognizer)
    }
    
    func setupCardOnAir(mainView: UIView, infos: ResultSeriesOnAir) {
        endCardHeight =  view.frame.height * 0.8
        startCardHeight =  view.frame.height * 0.3
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = view.frame
        view.addSubview(visualEffectView)
        
        cardViewController = OverlayViewController(seriesOnAir: infos)
        view.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x: 0, y: view.frame.height / 2, width: view.bounds.width, height: endCardHeight)
        cardViewController.view.clipsToBounds = true
        cardViewController.view.layer.cornerRadius = 10

        let tapGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(handleCardTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))

        cardViewController.handleView.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleView.addGestureRecognizer(panGestureRecognizer)
    }
    
    func setupCardDiscoverSeries(mainView: UIView, infos: ResultDiscoverSeries) {
        endCardHeight =  view.frame.height * 0.8
        startCardHeight =  view.frame.height * 0.3
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = view.frame
        view.addSubview(visualEffectView)
        
        cardViewController = OverlayViewController(discoverSeries: infos)
        view.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x: 0, y: view.frame.height / 2, width: view.bounds.width, height: endCardHeight)
        cardViewController.view.clipsToBounds = true
        cardViewController.view.layer.cornerRadius = 10

        let tapGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(handleCardTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))

        cardViewController.handleView.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc
    func handleCardTap(recognizer recognzier: UITapGestureRecognizer) {
        switch recognzier.state {
        // Animate card when tap finishes
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
            
        default:
            break
        }
    }
    
    @objc
    func handleCardPan(recognizer:UIPanGestureRecognizer) {
            switch recognizer.state {
            case .began:
                // Start animation if pan begins
                startInteractiveTransition(state: nextState, duration: 0.9)
                
            case .changed:
                // Update the translation according to the percentage completed
                let translation = recognizer.translation(in: self.cardViewController.handleView)
                var fractionComplete = translation.y / endCardHeight
                fractionComplete = cardVisible ? fractionComplete : -fractionComplete
                updateInteractiveTransition(fractionCompleted: fractionComplete)
            case .ended:
                // End animation when pan ends
                continueInteractiveTransition()
            default:
                break
            }
        }
    
    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
            // Check if frame animator is empty
            if runningAnimations.isEmpty {
                // Create a UIViewPropertyAnimator depending on the state of the popover view
                let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                    switch state {
                    case .expanded:
                        // If expanding set popover y to the ending height and blur background
                        self.cardViewController.view.frame.origin.y = self.view.frame.height - self.endCardHeight
                        UIVisualEffectView().effect = UIBlurEffect(style: .dark)
       
                    case .collapsed:
                        // If collapsed set popover y to the starting height and remove background blur
                        self.cardViewController.view.frame.origin.y = self.view.frame.height / 1.8
                        
                        UIVisualEffectView().effect = nil
                    }
                }
                
                // Complete animation frame
                frameAnimator.addCompletion { _ in
                    self.cardVisible = !self.cardVisible
                    self.runningAnimations.removeAll()
                }
                
                // Start animation
                frameAnimator.startAnimation()
                
                // Append animation to running animations
                runningAnimations.append(frameAnimator)
                
                // Create UIViewPropertyAnimator to round the popover view corners depending on the state of the popover
                let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                    switch state {
                    case .expanded:
                        // If the view is expanded set the corner radius to 30
                        self.cardViewController.view.layer.cornerRadius = 30
                        
                    case .collapsed:
                        // If the view is collapsed set the corner radius to 0
                        self.cardViewController.view.layer.cornerRadius = 10
                    }
                }
                
                // Start the corner radius animation
                cornerRadiusAnimator.startAnimation()
                
                // Append animation to running animations
                runningAnimations.append(cornerRadiusAnimator)
                
            }
        }
    
    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        
        // If animation is empty start new animation
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        
        // For each animation in runningAnimations
        for animator in runningAnimations {
            // Pause animation and update the progress to the fraction complete percentage
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    // Funtion to update transition when view is dragged
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        // For each animation in runningAnimations
        for animator in runningAnimations {
            // Update the fraction complete value to the current progress
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    // Function to continue an interactive transisiton
    func continueInteractiveTransition (){
        // For each animation in runningAnimations
        for animator in runningAnimations {
            // Continue the animation forwards or backwards
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}

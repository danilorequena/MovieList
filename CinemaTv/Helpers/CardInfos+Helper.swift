//
//  CardInfos+Helper.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 08/10/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

enum CardState {
    case collapsed
    case expanded
}

protocol CardInfosProtocol {
    func setupCardPop(mainView: UIView, infos: ResultSeries)
    func setupCardMovies(mainView: UIView, infos: ResultDiscover)
    func setupCardOnAir(mainView: UIView, infos: ResultSeriesOnAir)
}

class CardInfos: CardInfosProtocol {
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    var cardVisible = false
    var cardViewController: OverlayViewController!
    var visualEffectView: UIVisualEffectView!
    var endCardHeight: CGFloat = 0
    var startCardHeight: CGFloat = 0
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted: CGFloat =  0
    
    func setupCardPop(mainView: UIView, infos: ResultSeries) {
        endCardHeight =  mainView.frame.height * 0.8
        startCardHeight =  mainView.frame.height / 3
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = mainView.frame
        mainView.addSubview(visualEffectView)
        
        cardViewController = OverlayViewController(seriesPop: infos)
        mainView.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x: 0, y: mainView.frame.height / 2, width: mainView.bounds.width, height: endCardHeight)
        cardViewController.view.clipsToBounds = true
        cardViewController.view.layer.cornerRadius = 10

        let tapGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(handleCardTap(recognzier:view:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:view:)))

        cardViewController.handleView.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleView.addGestureRecognizer(panGestureRecognizer)
    }
    
    func setupCardDiscoverSeries(mainView: UIView, infos: ResultDiscoverSeries) {
        endCardHeight =  mainView.frame.height * 0.8
        startCardHeight =  mainView.frame.height / 3
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = mainView.frame
        mainView.addSubview(visualEffectView)
        
        cardViewController = OverlayViewController(discoverSeries: infos)
        mainView.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x: 0, y: mainView.frame.height / 2, width: mainView.bounds.width, height: endCardHeight)
        cardViewController.view.clipsToBounds = true
        cardViewController.view.layer.cornerRadius = 10

        let tapGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(handleCardTap(recognzier:view:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:view:)))

        cardViewController.handleView.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleView.addGestureRecognizer(panGestureRecognizer)
    }
    
    func setupCardOnAir(mainView: UIView, infos: ResultSeriesOnAir) {
        endCardHeight =  mainView.frame.height * 0.8
        startCardHeight =  mainView.frame.height / 3
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = mainView.frame
        mainView.addSubview(visualEffectView)
        
        cardViewController = OverlayViewController(seriesOnAir: infos)
        mainView.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x: 0, y: mainView.frame.height / 2, width: mainView.bounds.width, height: endCardHeight)
        cardViewController.view.clipsToBounds = true
        cardViewController.view.layer.cornerRadius = 10

        let tapGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(handleCardTap(recognzier:view:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:view:)))

        cardViewController.handleView.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleView.addGestureRecognizer(panGestureRecognizer)
    }
    
    func setupCardMovies(mainView: UIView, infos: ResultDiscover) {
        endCardHeight =  mainView.frame.height * 0.8
        startCardHeight =  mainView.frame.height / 3
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = mainView.frame
        mainView.addSubview(visualEffectView)
        
        cardViewController = OverlayViewController(discoverMovies: infos)
        mainView.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x: 0, y: mainView.frame.height / 2, width: mainView.bounds.width, height: endCardHeight)
        cardViewController.view.clipsToBounds = true
        cardViewController.view.layer.cornerRadius = 10

        let tapGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(handleCardTap(recognzier:view:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:view:)))

        cardViewController.handleView.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc
    func handleCardTap(recognzier:UITapGestureRecognizer, view: UIView) {
            switch recognzier.state {
                // Animate card when tap finishes
            case .ended:
                animateTransitionIfNeeded(state: nextState, duration: 0.9, view: view)
            
            default:
                break
            }
        }
    
    @objc
    func handleCardPan (recognizer:UIPanGestureRecognizer, view: UIView) {
            switch recognizer.state {
            case .began:
                // Start animation if pan begins
                startInteractiveTransition(state: nextState, duration: 0.9, view: view)
                
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
    
    // Animate transistion function
    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval, view: UIView) {
            // Check if frame animator is empty
            if runningAnimations.isEmpty {
                // Create a UIViewPropertyAnimator depending on the state of the popover view
                let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                    switch state {
                    case .expanded:
                        // If expanding set popover y to the ending height and blur background
                        self.cardViewController.view.frame.origin.y = view.frame.height
                        self.visualEffectView.effect = UIBlurEffect(style: .dark)
       
                    case .collapsed:
                        // If collapsed set popover y to the starting height and remove background blur
                        self.cardViewController.view.frame.origin.y = view.frame.height + 400
                        
                        self.visualEffectView.effect = nil
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
    
    // Function to start interactive animations when view is dragged
    func startInteractiveTransition(state:CardState, duration:TimeInterval, view: UIView) {
        
        // If animation is empty start new animation
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration, view: view)
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

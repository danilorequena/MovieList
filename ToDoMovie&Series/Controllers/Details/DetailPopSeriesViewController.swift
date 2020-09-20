//
//  DetailSeriesViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 03/04/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

enum CardState {
    case collapsed
    case expanded
}

class DetailPopSeriesViewController: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var ivSerie: UIImageView!
    @IBOutlet weak var viewOverview: UIView!
    @IBOutlet weak var lbOverview: UILabel!
    @IBOutlet weak var scrollOverview: UIScrollView!
    
    let vcDetailSeriesViewController = "DatailSeriesViewController"
    var series: ResultSeries
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    var cardViewController: OverlayViewController!
    var visualEffectView: UIVisualEffectView!
    var endCardHeight: CGFloat = 0
    var startCardHeight: CGFloat = 0
    var cardVisible = false
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted: CGFloat =  0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(largeTitleColor: .white, backgoundColor: #colorLiteral(red: 0.1628865302, green: 0.1749416888, blue: 0.1923300922, alpha: 1), tintColor: .white, title: "Pop Series", preferredLargeTitle: true)
        setupOverview()
        setupImage()
        setupCard()
    }
    
    required init(series: ResultSeries) {
        self.series = series
        super.init(nibName: vcDetailSeriesViewController, bundle: Bundle(for: DetailPopSeriesViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCard() {
        endCardHeight =  self.view.frame.height * 0.8
        startCardHeight =  self.view.frame.height * 0.3
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        cardViewController = OverlayViewController(infos: series)
        self.view.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - startCardHeight, width: self.view.bounds.width, height: endCardHeight)
        cardViewController.view.clipsToBounds = true
        self.cardViewController.view.layer.cornerRadius = 10
        
        let tapGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(DetailPopSeriesViewController.handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DetailPopSeriesViewController.handleCardPan(recognizer:)))
        
        cardViewController.handleView.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc
        func handleCardTap(recognzier:UITapGestureRecognizer) {
            switch recognzier.state {
                // Animate card when tap finishes
            case .ended:
                animateTransitionIfNeeded(state: nextState, duration: 0.9)
            
            default:
                break
            }
        }
    
    @objc
        func handleCardPan (recognizer:UIPanGestureRecognizer) {
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
    
    // Animate transistion function
        func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
            // Check if frame animator is empty
            if runningAnimations.isEmpty {
                // Create a UIViewPropertyAnimator depending on the state of the popover view
                let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                    switch state {
                    case .expanded:
                        // If expanding set popover y to the ending height and blur background
                        self.cardViewController.view.frame.origin.y = self.view.frame.height - self.endCardHeight
                        self.visualEffectView.effect = UIBlurEffect(style: .dark)
       
                    case .collapsed:
                        // If collapsed set popover y to the starting height and remove background blur
                        self.cardViewController.view.frame.origin.y = self.view.frame.height - self.startCardHeight
                        
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
    
    func setupOverview() {
        lbTitle.text = series.name
        lbOverview.text = series.overview
        lbOverview.textColor = .white
        viewOverview.clipsToBounds = true
        let path = UIBezierPath(roundedRect: viewOverview.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        viewOverview.layer.mask = maskLayer
        viewOverview.backgroundColor = #colorLiteral(red: 0.0341934419, green: 0.04082306338, blue: 0.06327024648, alpha: 0.5)
    }
    
    func setupImage() {
        if let backdropPath = series.backdropPath {
            guard let posterURL = URL(string: "https://image.tmdb.org/t/p/original/" + backdropPath) else {return}
            do {
                let data = try Data(contentsOf: posterURL)
                self.ivSerie.image = UIImage(data: data)
            } catch let jsonErr {
                print(jsonErr)
            }
        }
    }
    @IBAction func goToTrailer(_ sender: Any) {
        let vc = TrailerViewController(videoID: series.id ?? 12)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
}

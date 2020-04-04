//
//  MovieViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 27/03/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit
import Foundation

class MovieViewController: UIViewController {

    @IBOutlet weak var ivMovieImage: UIImageView!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var viewDescription: UIView!
    
    var movie: Result?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie?.title
        setup()
        setupViewDescrition()
    }
    
    func setupViewDescrition() {
        self.viewDescription.clipsToBounds = true
        let path = UIBezierPath(roundedRect: viewDescription.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.viewDescription.layer.mask = maskLayer
    }
    

    func setup() {
        self.lbDescription.text = movie?.overview
        if let posterPath = movie?.posterPath {
            guard let posterURL = URL(string: "https://image.tmdb.org/t/p/original" + posterPath) else {return}
            do {
                let data = try Data(contentsOf: posterURL)
                self.ivMovieImage.image = UIImage(data: data)
            } catch let jsonErr {
                print(jsonErr)
            }
        }
    }
}

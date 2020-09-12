//
//  DetailSeriesViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 03/04/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class DetailSeriesViewController: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var ivSerie: UIImageView!
    @IBOutlet weak var viewOverview: UIView!
    @IBOutlet weak var lbOverview: UILabel!
    @IBOutlet weak var scrollOverview: UIScrollView!
    
    let vcDetailSeriesViewController = "DatailSeriesViewController"
    var series: ResultSeries
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOverview()
        setupImage()
    }
    
    required init(series: ResultSeries) {
        self.series = series
        super.init(nibName: vcDetailSeriesViewController, bundle: Bundle(for: DetailSeriesViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        if let posterPath = series.posterPath {
            guard let posterURL = URL(string: "https://image.tmdb.org/t/p/original/" + posterPath) else {return}
            do {
                let data = try Data(contentsOf: posterURL)
                self.ivSerie.image = UIImage(data: data)
            } catch let jsonErr {
                print(jsonErr)
            }
        }
    }
    @IBAction func btClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

//
//  DetailViewModel.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 12/10/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewModelProtocol: AnyObject {
    func configCard(view: UIView, infos: ResultDiscover)
}

final class DetailViewModel: DetailViewModelProtocol {
    
    var seriesPop: ResultPopularSeries?
    var seriesOnAir: ResultSeriesOnAir?
    var discoverMovies: ResultDiscover?
    var createdBy: [CreatedBy] = []
    var genre: [Genre] = []
    var networks: [Network] = []
    var season: [Season] = []
    var cardConfig: CardConfig?
    
    func setNavigation(controller: UIViewController, title: String) {
        controller.configureNavigationBar(
            largeTitleColor: .white, backgoundColor: #colorLiteral(red: 0.1628865302, green: 0.1749416888, blue: 0.1923300922, alpha: 1),
            tintColor: .white, title: title,
            preferredLargeTitle: true
        )
    }
    
    func configCard(view: UIView, infos: ResultDiscover) {
        cardConfig?.setupCardMovies(infos: infos)
    }
}

//
//  MovieTableViewCell.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 30/03/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lbTitleMovie: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    
    //MARK: - Super Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareCell(with movie: Result) {
        self.lbTitleMovie.text = movie.originalTitle
        self.lbReleaseDate.text = movie.releaseDate
        
        if let posterPath = movie.posterPath {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500/" + posterPath)
            let data = try? Data(contentsOf: posterURL!)
            self.ivMovie.image = UIImage(data: data!)
        }
    }
    
}

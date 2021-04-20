//
//  EpisodeDetailViewController.swift
//  afyaTVShows
//
//  Created by administrador on 20/04/21.
//

import UIKit
import SnapKit
class EpisodeDetailViewController: UIViewController {
    
    var seasonNumber = Int()
    var episodeNumber = Int()
    var container = UIView()
    var cover = UIImageView()
    var showTitle = UILabel()
    var scheduleLabel = UILabel()
    var schedule = UILabel()
    var genresLabel = UILabel()
    var genres = UILabel()
    var episodeLabel = UILabel()
    var showDescription = UILabel()
    var gradientContainer = UIView()
    var gradient : CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .axial
        gradientLayer.colors = [
            #colorLiteral(red: 0.8421594501, green: 0.8371540308, blue: 0.8460076451, alpha: 0.05).cgColor,
            #colorLiteral(red: 0.2364963889, green: 0.2350968719, blue: 0.2375763059, alpha: 0.75).cgColor,
            #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor,
        ]
        gradientLayer.locations = [0,0.85 ,1]
        gradientLayer.frame = CGRect.zero
        return gradientLayer
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = showTitle.text
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setupElements()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        gradient.frame = gradientContainer.frame
    }
    
    
    func setupElements(){
        container.backgroundColor = .black
        
        //Cover
        
        //Title Label
        showTitle.textAlignment = .center
        showTitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        showTitle.font = UIFont.systemFont(ofSize: 22)
        
        //Episode
        episodeLabel.text = "Episode: \(episodeNumber) Season: \(seasonNumber)"
        episodeLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        episodeLabel.font = UIFont.systemFont(ofSize: 12)
        //Genres
        genresLabel.text = "Genres"
        genresLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        genresLabel.font = UIFont.systemFont(ofSize: 12)
        genres.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        genres.font = UIFont.systemFont(ofSize: 16)
        //Schedule
        scheduleLabel.text = "Schedule"
        scheduleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        scheduleLabel.font = UIFont.systemFont(ofSize: 12)
        schedule.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        schedule.font = UIFont.systemFont(ofSize: 16)
        schedule.numberOfLines = 0
        
        //Description
        showDescription.numberOfLines = 0
        showDescription.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        showDescription.font = UIFont.systemFont(ofSize: 12)
        
    }
    
    func setupLayout() {
        view.addSubview(container)
        container.addSubview(cover)
        container.addSubview(genresLabel)
        container.addSubview(genres)
        container.addSubview(scheduleLabel)
        container.addSubview(schedule)
        container.addSubview(episodeLabel)
        container.addSubview(showDescription)
        cover.addSubview(gradientContainer)
        gradientContainer.layer.addSublayer(gradient)
        gradientContainer.addSubview(showTitle)
        
        
        container.snp.makeConstraints(){ make in
            make.edges.equalTo(view)
        }
        
        cover.snp.makeConstraints(){make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(container.snp.centerY)
        }
        gradientContainer.snp.makeConstraints(){make in
            make.edges.equalTo(cover)
        }

        episodeLabel.snp.makeConstraints(){ make in
            make.top.equalTo(schedule.snp.bottom)
            make.height.equalTo(20)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
        }
        
        showDescription.snp.makeConstraints(){ make in
            make.top.equalTo(episodeLabel.snp.bottom)
            make.bottom.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
        }
        
        showTitle.snp.makeConstraints(){make in
            make.bottom.equalTo(gradientContainer.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        scheduleLabel.snp.makeConstraints(){ make in
            make.top.equalTo(cover.snp.bottom).offset(20)
            make.leading.equalTo(container.snp.centerX)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(25)
        }
        
        schedule.snp.makeConstraints(){ make in
            make.top.equalTo(scheduleLabel.snp.bottom).offset(5)
            make.leading.equalTo(container.snp.centerX)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(75)
        }
        
        genresLabel.snp.makeConstraints(){ make in
            make.top.equalTo(cover.snp.bottom).offset(25)
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalTo(container.snp.centerX)
        }
        
        genres.snp.makeConstraints(){ make in
            make.top.equalTo(scheduleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalTo(container.snp.centerX)
            make.height.equalTo(75)
        }
        
        
    }
    
}

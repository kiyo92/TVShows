//
//  ShowDetailViewController.swift
//  afyaTVShows
//
//  Created by administrador on 19/04/21.
//

import UIKit
import SnapKit
class ShowDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let viewModel = ShowDetailViewModel()
    var showId: Int?
    var filteredArray: [Episode]?
    
    var container = UIView()
    var cover = UIImageView()
    var showTitle = UILabel()
    var schedule = UILabel()
    var genres = UILabel()
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
    
    var tableView = UITableView()
    
    var collectionView : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = showTitle.text
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setupElements()
        setupLayout()
        
        getSeasonsData(showId: self.showId ?? 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        gradient.frame = gradientContainer.frame
    }
    
    func getSeasonsData(showId: Int){
        viewModel.fetchSeasons(showId: showId)
        
        viewModel.didFinishFetch = {
            self.getEpisodesData(showId: self.showId ?? 1)
            self.collectionView?.reloadData()
        }
    }
    
    func getEpisodesData(showId: Int){
        viewModel.fetchEpisodes(showId: showId)
        
        viewModel.didFinishFetchEpisodes = {
            self.filteredArray = self.viewModel.episodes?.filter{$0.season == self.viewModel.episodes?.first?.season}
            self.tableView.reloadData()
        }
    }
    
    func setupElements(){
        container.backgroundColor = .black
        
        //Cover
        
        //Title Label
        showTitle.textAlignment = .center
        showTitle.textColor = .white
        showTitle.font = UIFont.systemFont(ofSize: 34)
        
        //Genres
        genres.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        genres.font = UIFont.systemFont(ofSize: 10)
        //Schedule
        schedule.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        schedule.font = UIFont.systemFont(ofSize: 10)
        schedule.numberOfLines = 0
        
        //Description
        showDescription.numberOfLines = 0
        showDescription.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        showDescription.font = UIFont.systemFont(ofSize: 12)
        
        //TableView
        tableView.register(ShowDetailTableViewCell.self, forCellReuseIdentifier: "cellEpisodes")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        
        //CollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        layout.itemSize = CGSize(width: 60, height: 55)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(SeasonCollectionViewCell.self, forCellWithReuseIdentifier: "cellSeasons")
        collectionView?.backgroundColor = UIColor.black
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    func setupLayout() {
        view.addSubview(container)
        container.addSubview(cover)
        cover.addSubview(gradientContainer)
        gradientContainer.layer.addSublayer(gradient)
        gradientContainer.addSubview(showTitle)
        gradientContainer.addSubview(genres)
        gradientContainer.addSubview(schedule)
        gradientContainer.addSubview(showDescription)
        container.addSubview(collectionView!)
        container.addSubview(tableView)
        
        tableView.snp.makeConstraints() { make in
            make.top.equalTo(collectionView!.snp.bottom).offset(0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        collectionView?.snp.makeConstraints() { make in
            make.top.equalTo(cover.snp.bottom).offset(0)
            make.height.equalTo(60)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        container.snp.makeConstraints(){ make in
            make.edges.equalTo(view)
        }
        
        cover.snp.makeConstraints(){make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(container.snp.centerY).offset(100)
        }
        gradientContainer.snp.makeConstraints(){make in
            make.edges.equalTo(cover)
        }
        
        
        showDescription.snp.makeConstraints(){ make in
            make.bottom.equalTo(gradientContainer.snp.bottom)
            make.height.equalTo(50)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
        }
        
        schedule.snp.makeConstraints(){ make in
            make.bottom.equalTo(showDescription.snp.top).offset(-5)
            make.leading.equalTo(container.snp.centerX)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(25)
        }
        genres.snp.makeConstraints(){ make in
            make.bottom.equalTo(showDescription.snp.top).offset(-5)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalTo(container.snp.centerX)
        }
        showTitle.snp.makeConstraints(){make in
            make.bottom.equalTo(schedule.snp.top).offset(-10)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellEpisodes", for: indexPath) as? ShowDetailTableViewCell
        cell?.title.text = filteredArray?[indexPath.row].name
        cell?.coverUrl = filteredArray?[indexPath.row].image?.original
        cell?.showDescription.text = filteredArray?[indexPath.row].summary?.htmlToString
        cell?.episodeNumber = filteredArray?[indexPath.row].number ?? 0
        cell?.seasonNumber = filteredArray?[indexPath.row].season ?? 0
        return cell ?? ShowDetailTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow

        let currentCell = tableView.cellForRow(at: indexPath!) as! ShowDetailTableViewCell
        
        let vc = EpisodeDetailViewController()
        vc.modalPresentationStyle = .formSheet
        let coverImage = currentCell.cover.image
        let name = currentCell.title
        let description = currentCell.showDescription
        let episodeNumber = currentCell.episodeNumber
        let seasonNumber = currentCell.seasonNumber
        vc.cover.image = coverImage
        vc.schedule.text = schedule.text
        vc.genres.text = genres.text
        vc.showTitle.text = name.text
        vc.showDescription.text = description.text
        vc.episodeNumber = episodeNumber
        vc.seasonNumber = seasonNumber
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.seasons?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellSeasons", for: indexPath) as? SeasonCollectionViewCell
    
        cell?.cellLabel.text = "\(indexPath.item + 1)"

        return cell ?? SeasonCollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        filteredArray?.removeAll()

        filteredArray = viewModel.episodes?.filter{$0.season == viewModel.seasons?[indexPath.item].number}
        tableView.reloadData()
    }
    
}

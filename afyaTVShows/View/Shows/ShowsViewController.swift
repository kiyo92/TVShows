//
//  ShowsViewController.swift
//  afyaTVShows
//
//  Created by administrador on 19/04/21.
//

import UIKit
import SnapKit
class ShowsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let viewModel = ShowViewModel()
    var tableView = UITableView()
    var pageContainer = UIView()
    var pageNumberLabel = UILabel()
    var pageNumber = 1;
    var nextButton = UIButton()
    var backButton = UIButton()
    
    var searchButton = UIButton()
    var searchTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TV Shows"
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false;
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        getData(page: 1)
        
        setupElements()
        setupLayout()
    }
    func getData(page: Int){
        viewModel.fetchShows(page: page)
        
        viewModel.didFinishFetch = {
            self.pageNumberLabel.text = "Page \(self.pageNumber)"
            self.tableView.reloadData()
        }
    }
    func searchData(word: String){
        viewModel.searchShows(word: word)
        
        viewModel.didFinishFetch = {
            self.tableView.reloadData()
        }
    }
    
    @objc func nextPage(){
        pageNumber += 1
        getData(page: pageNumber)
    }
    @objc func previousPage(){
        if(pageNumber > 1){
            pageNumber -= 1
        }
        getData(page: pageNumber)
    }
    
    @objc func onSearchPressed(){
        searchData(word: searchTextField.text ?? "")
        pageNumber = 1
        self.pageNumberLabel.text = "Page \(self.pageNumber)"
        
    }
    
    func setupElements(){
        pageContainer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        pageNumberLabel.text = "Page \(pageNumber)"
        pageNumberLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pageNumberLabel.textAlignment = .center
        pageNumberLabel.font = UIFont.systemFont(ofSize: 12)
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        backButton.setTitle("Previous", for: .normal)
        backButton.addTarget(self, action: #selector(previousPage), for: .touchUpInside)
        
        searchButton.layer.borderWidth = 1.0
        searchButton.layer.masksToBounds = false
        searchButton.layer.cornerRadius = 45/2
        searchButton.clipsToBounds = true
        searchButton.setImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysTemplate), for: .normal)
        searchButton.imageView?.frame = CGRect(x: searchButton.frame.width/2, y: searchButton.frame.height/2, width: 25, height: 25)
        searchButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        searchButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        searchButton.addTarget(self, action: #selector(onSearchPressed), for: .touchUpInside)
        
        searchTextField.placeholder = "Search"
        searchTextField.borderStyle = UITextField.BorderStyle.line
        searchTextField.backgroundColor = UIColor.lightGray
        searchTextField.layer.borderWidth = 1.0
        searchTextField.layer.masksToBounds = false
        searchTextField.layer.cornerRadius = 10
        searchTextField.clipsToBounds = true
    }
    func setupLayout(){
        view.addSubview(tableView)
        view.addSubview(pageContainer)
        
        pageContainer.addSubview(searchTextField)
        pageContainer.addSubview(searchButton)
        pageContainer.addSubview(pageNumberLabel)
        pageContainer.addSubview(nextButton)
        pageContainer.addSubview(backButton)
        
        tableView.snp.makeConstraints() { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(pageContainer.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        pageContainer.snp.makeConstraints(){make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(85)
        }
        pageNumberLabel.snp.makeConstraints(){make in
            make.top.equalToSuperview()
            make.leading.equalTo(backButton.snp.trailing)
            make.trailing.equalTo(nextButton.snp.leading)
            make.height.equalTo(45)
        }
        nextButton.snp.makeConstraints(){make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(pageContainer.snp.centerX).offset(35)
            make.height.equalTo(45)
        }
        backButton.snp.makeConstraints(){make in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(pageContainer.snp.centerX).offset(-35)
            make.height.equalTo(45)
            
        }
        searchButton.snp.makeConstraints(){make in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(45)
            make.width.equalTo(45)
        }
        searchTextField.snp.makeConstraints(){make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(searchButton.snp.leading).offset(55/2)
            make.height.equalTo(45)
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.shows?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShowTableViewCell
        
        cell.title.text = self.viewModel.shows?[indexPath.row].name
        cell.coverUrl = self.viewModel.shows?[indexPath.row].image?.original ?? ""

        cell.genres.text = self.viewModel.shows?[indexPath.row].genres?.joined(separator: ", ")
        
        let days = self.viewModel.shows?[indexPath.row].schedule?.days?.joined(separator: ", ")
        cell.schedule.text = "\(self.viewModel.shows?[indexPath.row].schedule?.time ?? "") \(days ?? "")"
        cell.showDescription.text = self.viewModel.shows?[indexPath.row].summary?.htmlToString
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example

        let currentCell = tableView.cellForRow(at: indexPath!) as! ShowTableViewCell
        
        let vc = ShowDetailViewController()
        vc.modalPresentationStyle = .fullScreen
        let coverImage = currentCell.cover.image
        let schedule = currentCell.schedule
        let genres = currentCell.genres
        let name = currentCell.title
        let description = currentCell.showDescription
        vc.cover.image = coverImage
        vc.schedule.text = schedule.text
        vc.genres.text = genres.text
        vc.showTitle.text = name.text
        vc.showDescription.text = description.text
        vc.showId = viewModel.shows?[indexPath?.row ?? 0].id
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

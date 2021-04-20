//
//  ViewController.swift
//  afyaTVShows
//
//  Created by administrador on 18/04/21.
//

import UIKit
import SnapKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let viewModel = ShowViewModel()
    private var tableview : UITableView {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        table.backgroundColor = .clear
        table.showsHorizontalScrollIndicator = true
        table.clipsToBounds = true
        table.cellLayoutMarginsFollowReadableWidth = false
         //tableView.separatorStyle = .none
        view.addSubview(table)
        table.snp.makeConstraints() { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        return table
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .overFullScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        viewModel.fetchShows(page: 1)
        view.backgroundColor = .white
        tableview.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        configure()
    }
    
    func configure(){
        
        
    }

     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Kiyo"
        return cell
    }

}


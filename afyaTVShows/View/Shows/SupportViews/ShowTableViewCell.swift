//
//  ShowTableViewCell.swift
//  afyaTVShows
//
//  Created by administrador on 19/04/21.
//

import UIKit
import SnapKit
import Alamofire
import AlamofireImage
class ShowTableViewCell: UITableViewCell {

    var title = UILabel ()
    var genres = UILabel()
    var schedule = UILabel()
    var cover = UIImageView ()
    var coverUrl : String?{
        didSet{
            self.setImage()
        }
    }
    var container = UIView()
    var showDescription = UILabel()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupLayout()
        self.setupElements()
        
    }
    
    func setupElements() {
        
        //Container
        container.backgroundColor = #colorLiteral(red: 0.06141646206, green: 0.06143487245, blue: 0.06141404063, alpha: 1)
        //Title
        title.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //Genres
        genres.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        genres.font = UIFont.systemFont(ofSize: 10)
        //Schedule
        schedule.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        schedule.font = UIFont.systemFont(ofSize: 10)
        schedule.numberOfLines = 0
        //Cover
        cover.layer.borderWidth = 1.0
        cover.layer.masksToBounds = false
        cover.layer.cornerRadius = 10
        cover.clipsToBounds = true
        //Description
        showDescription.numberOfLines = 0
        showDescription.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        showDescription.font = UIFont.systemFont(ofSize: 12)
    }
    
    func setupLayout() {
        
        
        addSubview(container)
        container.addSubview(cover)
        container.addSubview(title)
        container.addSubview(genres)
        container.addSubview(schedule)
        container.addSubview(showDescription)
        
        container.snp.makeConstraints(){ make in
            make.height.equalTo(self.snp.height)
            make.width.equalTo(self.snp.width)
        }
        title.snp.makeConstraints() { make in
            make.top.equalTo(cover.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
        }
        cover.snp.makeConstraints() { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(10)
            make.height.equalTo(container.snp.height).inset(60)
            make.width.equalTo(container.snp.height).inset(60)
            
        }
        genres.snp.makeConstraints(){ make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalTo(container.snp.centerX)
        }
        schedule.snp.makeConstraints(){ make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.leading.equalTo(container.snp.centerX)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(25)
        }
        showDescription.snp.makeConstraints(){ make in
            make.top.equalTo(genres.snp.bottom).offset(15)
            make.height.equalTo(50)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
        }

    }
    
    func setImage(){
        AF.request(coverUrl ?? "").responseImage { response in
            debugPrint(response)
            debugPrint(response.result)

            if case .success(let image) = response.result {
                self.cover.image = image
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(#file) \(#function) not implemented")
    }
    
    override func prepareForReuse() {

        title.text = nil
        super.prepareForReuse()
    }
}

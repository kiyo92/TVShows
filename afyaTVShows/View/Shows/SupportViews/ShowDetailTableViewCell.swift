//
//  ShowDetailTableViewCell.swift
//  afyaTVShows
//
//  Created by administrador on 19/04/21.
//

import UIKit
import SnapKit
import Alamofire
import AlamofireImage
class ShowDetailTableViewCell: UITableViewCell {

    var title = UILabel ()
    var navigationArrow = UIImageView()
    var episodeNumber = Int()
    var seasonNumber = Int()
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
    required init?(coder: NSCoder) {
        fatalError("\(#file) \(#function) not implemented")
    }
    
    func setupElements() {
        
        //Container
        container.backgroundColor = #colorLiteral(red: 0.06141646206, green: 0.06143487245, blue: 0.06141404063, alpha: 1)
        //Title
        title.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //Description
        showDescription.numberOfLines = 0
        showDescription.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        showDescription.font = UIFont.systemFont(ofSize: 12)
        //navigationArrow
        navigationArrow.image = #imageLiteral(resourceName: "arrow").withRenderingMode(.alwaysTemplate)
        navigationArrow.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func setupLayout() {

        addSubview(container)
        container.addSubview(title)
        container.addSubview(navigationArrow)
        
        container.snp.makeConstraints(){ make in
            make.height.equalTo(self.snp.height)
            make.width.equalTo(self.snp.width)
        }
        title.snp.makeConstraints() { make in
            make.centerY.equalTo(container.snp.centerY)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalTo(navigationArrow.snp.leading).inset(-5)
        }
        navigationArrow.snp.makeConstraints() { make in
            make.centerY.equalTo(container.snp.centerY)
            make.height.width.equalTo(30)
            make.trailing.equalToSuperview().inset(15)
        }
    }
    
    func setImage(){
        AF.request(coverUrl ?? "").responseImage { response in
            if case .success(let image) = response.result {
                self.cover.image = image
            }
        }
        
    }
    

    override func prepareForReuse() {

        title.text = nil
        super.prepareForReuse()
    }
}

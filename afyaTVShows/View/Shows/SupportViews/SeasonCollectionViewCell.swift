//
//  SeasonCollectionViewCell.swift
//  afyaTVShows
//
//  Created by administrador on 20/04/21.
//

import UIKit
import SnapKit
class SeasonCollectionViewCell: UICollectionViewCell {
    let cellLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.09575705975, green: 0.09519547969, blue: 0.09619369358, alpha: 1)
        cellLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cellLabel.textAlignment = .center
        addSubview(cellLabel)
        
        cellLabel.snp.makeConstraints(){make in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        cellLabel.text = ""
    }
}

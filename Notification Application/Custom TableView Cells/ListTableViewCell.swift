//
//  ListTableViewCell.swift
//  Notification Application
//
//  Created by Константин Малков on 30.12.2022.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    static let identifier = "ListTableViewCell"
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        label.contentMode = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14,weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(subtitleLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //MARK: - Size settings
    override func layoutSubviews(){
        super.layoutSubviews()
        mainTitleLabel.frame = CGRect(x: 10, y: 2.5, width: contentView.frame.size.width-10, height: contentView.frame.size.height/2-5)
        subtitleLabel.frame = CGRect(x: 10, y: 27.5, width: contentView.frame.size.width-10, height: contentView.frame.size.height/2-5)
        
    }
    //MARK: - Downloading strings
    
    func configureDataToCell(with model: NotificationData){
        mainTitleLabel.text = model.Title
        subtitleLabel.text = model.Subtitle

    }
}

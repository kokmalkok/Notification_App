//
//  MainTableViewCell.swift
//  Notification Application
//
//  Created by Константин Малков on 19.12.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    static let identifier = "MainTableViewCell"
    
    public let imageViewFromGroupView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .systemBlue
        image.tintColor = .systemBackground
        image.contentMode = .center
        return image
    }()
    
    public let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.backgroundColor = .systemBackground
        label.textColor = .black
        label.textAlignment = .left
        label.contentMode = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    public let countLabel: UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.backgroundColor = .systemBackground
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageViewFromGroupView)
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(countLabel)
    }
    //высота ячейки 60
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //MARK: - Size settings
    override func layoutSubviews(){
        super.layoutSubviews()
        imageViewFromGroupView.frame = CGRect(x: 5, y: 5, width: 50, height: 50)
        imageViewFromGroupView.layer.cornerRadius = 0.5 * contentView.frame.size.width
        mainTitleLabel.frame = CGRect(x: 55, y: 5, width: contentView.frame.size.width-110, height: 50)
        countLabel.frame = CGRect(x: 55+mainTitleLabel.frame.size.width+5, y: 5, width: 30, height: 50)
        
    }
    //MARK: - Downloading main data except images
    
    func configureDataToCell(with model: CellData){
        self.imageViewFromGroupView.image = model.Image
        self.imageViewFromGroupView.tintColor = model.Color
        self.mainTitleLabel.text = model.Title
        self.countLabel.text = "\(model.Count)"
    }
}


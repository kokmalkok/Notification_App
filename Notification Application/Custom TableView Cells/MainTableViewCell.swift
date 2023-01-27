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
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    public let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        label.contentMode = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    public let countLabel: UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageViewFromGroupView)
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(countLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewFromGroupView.tintColor = .systemBackground
    }
    //MARK: - Size settings
    override func layoutSubviews(){
        super.layoutSubviews()
        imageViewFromGroupView.frame = CGRect(x: 5, y: 5, width: 50, height: 50)
        imageViewFromGroupView.layer.cornerRadius = 0.5 * imageViewFromGroupView.bounds.width
        mainTitleLabel.frame = CGRect(x: 70, y: 5, width: contentView.frame.size.width-110, height: 50)
        countLabel.frame = CGRect(x: contentView.frame.size.width-40, y: 5, width: 30, height: 50)
    }
    //MARK: - Downloading main data except images
    func configureDataToCell(with model: GroupListEntity, count: Int){
        if let color = UIColor.color(withData: model.color!)  {
            self.imageViewFromGroupView.image = UIImage(data: model.image!)?.withTintColor(color, renderingMode: .alwaysOriginal)
            self.mainTitleLabel.text = model.title
            self.countLabel.text = String(count)
        }
    }
}


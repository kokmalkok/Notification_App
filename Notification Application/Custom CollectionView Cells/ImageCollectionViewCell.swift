//
//  ImageCollectionViewCell.swift
//  Notification Application
//
//  Created by Константин Малков on 16.12.2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ImageCollectionViewCell"
    
    public let iconImageView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        contentView.addSubview(iconImageView)
        contentView.isUserInteractionEnabled = true
        contentView.backgroundColor = .systemBackground
    }
    
    private func setupImageView() {
        addSubview(iconImageView)
        iconImageView.frame = CGRect(x: 5, y: 5, width: contentView.frame.size.width-10, height: contentView.frame.size.height-10)
        iconImageView.layer.cornerRadius = 0.5 * iconImageView.bounds.size.width
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Configure Cell
    func configure(with image: UIImage, imageColor: UIColor) {
        self.iconImageView.image = image
    }
    
}

//
//  ColorCollectionViewCell.swift
//  Notification Application
//
//  Created by Константин Малков on 04.01.2023.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    static let identifier = "ColorCollectionViewCell"
    
    public let colorImageView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .systemRed
        image.contentMode = .center
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        contentView.addSubview(colorImageView)
        contentView.isUserInteractionEnabled = true
        contentView.backgroundColor = .systemBackground
    }
    
    private func setupImageView() {
        addSubview(colorImageView)
        colorImageView.frame = CGRect(x: 5, y: 5, width: contentView.frame.size.width-10, height: contentView.frame.size.height-10)
        colorImageView.layer.cornerRadius = 0.5 * colorImageView.bounds.size.width
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Configure Cell
    func configure(with color: UIColor) {
        self.colorImageView.backgroundColor = color
    }
}

//
//  NewsDetailCollectionViewCell.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/26/21.
//

import UIKit

enum NewsDetailCollectionViewCellType {
    case text
    case image
    case multi
}

class NewsDetailDescriptionLabel: UILabel {
    let inset = UIEdgeInsets(top: -15, left: 0, bottom: 0, right: 0)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: inset))
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicContentSize = super.intrinsicContentSize
        intrinsicContentSize.width += inset.left + inset.right
        intrinsicContentSize.height += inset.top + inset.bottom
        return intrinsicContentSize
    }
    
}

class NewsDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var descriptionLabel: NewsDetailDescriptionLabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    
    
    static let reuseIdentifier: String =  "NewsDetailCell"
    private var type: NewsDetailCollectionViewCellType?
    private var newsItem: NewsItem?
    
    private static let titleLabelTopPadding: CGFloat = 20
    private static let timestampLabelTopPadding: CGFloat = 10
    private static let descriptionLabelTopPadding: CGFloat = 0
    private static let descriptionLabelBottomPadding: CGFloat = 0
    
    override class func awakeFromNib() {

    }
    
    func initCell(type: NewsDetailCollectionViewCellType, newsItem: NewsItem) {
        self.type = type
        self.newsItem = newsItem
        setupUI()
    }

    private func setupUI() {
        guard let type = self.type, let newsItem = self.newsItem else { return }
//        containerView.backgroundColor = .yellow
//        descriptionLabel.backgroundColor = .green
        
        switch type {
        case .text:
            newsImageView.isHidden = true
            titleLabel.isHidden = false
            timestampLabel.isHidden = false
            descriptionLabel.isHidden = false
        case .image:
            newsImageView.isHidden = false
            titleLabel.isHidden = true
            timestampLabel.isHidden = true
            descriptionLabel.isHidden = true
        default:
            break
        }
        
        populateLabels(with: newsItem)
    }
    
    private func populateLabels(with item: NewsItem) {
        titleLabel.text = item.title
        //timestampLabel.text = item.subtitle
        descriptionLabel.text = item.description
    }
    
    public static func getCumulativeCellPadding() -> CGFloat {
        return titleLabelTopPadding + timestampLabelTopPadding + descriptionLabelTopPadding + descriptionLabelBottomPadding
    }
    
    
}

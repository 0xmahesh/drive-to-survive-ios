//
//  DriverDetailViewController.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/14/21.
//

import UIKit

protocol DriverDetailViewControllerDelegate: class {
    func didTapReadMoreButton()
    func didTapShareButton()
}

class DriverDetailButton : UIButton {
    
    private var driver: Driver?
    
    convenience init(with frame: CGRect, driver: Driver?) {
        self.init(frame: frame)
        self.driver = driver
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.cornerRadius = 24.0
        layer.borderWidth = 2.0
        setBorderColor(color: UIColor(hex: "333333"))
        self.setTitleColor(.black, for: .normal)
        self.setTitleColor(.gray, for: .highlighted)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open var isHighlighted: Bool {
        didSet {
           // backgroundColor = isHighlighted ?  UIColor(hex: "002366"): UIColor(hex: "4169E1")
            if isHighlighted {
                backgroundColor = UIColor(hex: driver?.team.color ?? "333333")
                setTitleColors(normal: .white, highlighted: .white)
            } else {
                let metallicGray = UIColor(hex: "333333")
                backgroundColor = .clear
                setTitleColors(normal: metallicGray, highlighted: metallicGray)
            }
        }
    }
    
    private func setBorderColor(color: UIColor) {
        layer.borderColor = color.cgColor
    }
    
    private func setTitleColors(normal: UIColor, highlighted: UIColor) {
        self.setTitleColor(normal, for: .normal)
        self.setTitleColor(highlighted, for: .highlighted)
    }
}

class DriverDetailViewController: UIViewController {
    
    private var driver: Driver?
    
    var closeButton = UIButton(type: .custom)
    var driverImageWrapperView = UIView()
    var driverImageView = UIImageView()
    var driverNameLabel = UILabel()
    var teamNameLabel = UILabel()
    var driverRankView = UIView()
    var driverRankLabel = UILabel()
    var descriptionLabel = UILabel()
    var readMoreButton = DriverDetailButton(type: .custom)
    var shareButton = DriverDetailButton(type: .custom)
    var shareActionSheet = UIView()
 
    weak var delegate: DriverDetailViewControllerDelegate?
    
    init(with driver: Driver) {
        self.driver = driver
        super.init(nibName: nil, bundle: nil)
        createSubviews()
        self.view.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "fbfbfb")
        
    }
    
    private func createSubviews() {
        
        closeButton.frame = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        closeButton.setImage(UIImage(named:"close"), for: .normal)
        closeButton.setImage(UIImage(named:"close"), for: .highlighted)
        closeButton.addTarget(self, action:#selector(closeButtonTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(closeButton)
        
        if let imageUrl = driver?.imageUrl {
            driverImageView.image = UIImage(named: imageUrl)
        }
        
        driverImageView.contentMode = .scaleAspectFit
        driverImageView.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 300))
        driverImageWrapperView.frame = driverImageView.frame
        driverImageWrapperView.addSubview(driverImageView)
        driverImageWrapperView.dropShadow(color: UIColor(hex: driver?.team.color ?? "000000"))
        self.view.addSubview(driverImageWrapperView)
        
        driverNameLabel.frame = CGRect(origin: .zero, size: .zero)
        driverNameLabel.font = UIFont(name: "SFProText-Bold", size: 18.0)
        driverNameLabel.textColor = .black
        driverNameLabel.textAlignment = .center
        if let firstName = self.driver?.firstName, let lastName = self.driver?.lastName {
            driverNameLabel.text = "\(firstName) \(lastName)"
            driverNameLabel.sizeToFit()
        }
        self.view.addSubview(driverNameLabel)
        
        teamNameLabel.frame = CGRect(origin: .zero, size: .zero)
        teamNameLabel.font = UIFont(name: "SFProText-Semibold", size: 16.0)
        teamNameLabel.textColor = .black
        teamNameLabel.textAlignment = .center
        if let teamName = self.driver?.team.name {
            teamNameLabel.text = teamName
            teamNameLabel.sizeToFit()
        }
        self.view.addSubview(teamNameLabel)
       
        descriptionLabel.frame = CGRect(origin: .zero, size: CGSize(width: self.view.frame.width - 2*40, height: 300))
        descriptionLabel.font = UIFont(name: "OpenSans-Regular", size: 16.0)
        descriptionLabel.textColor = UIColor(hex: "333333")
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        if let description = self.driver?.description {
            descriptionLabel.text = description
        }
        self.view.addSubview(descriptionLabel)
        
        driverRankLabel.frame = CGRect(origin: .zero, size: .zero)
        driverRankLabel.font = UIFont(name: "MuktaMahee-Bold", size: 18.0)
        driverRankLabel.textColor = .red
        driverRankLabel.textAlignment = .center
        if let rank = self.driver?.rank {
            driverRankLabel.text = "\(rank)"
            if rank == 0 { //newbie
                driverRankView.isHidden = true
            }
        }
        driverRankView.frame = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        driverRankView.backgroundColor = .yellow
        driverRankView.makeRoundedCorner(radius: driverRankView.frame.height/2)
        
        driverRankLabel.frame = driverRankView.frame
        driverRankView.addSubview(driverRankLabel)
        self.view.addSubview(driverRankView)
        
        readMoreButton = DriverDetailButton(with: CGRect(origin: .zero, size: CGSize(width: self.view.frame.size.width * 0.36, height: 47.0)), driver: self.driver)
        readMoreButton.setTitle("Read More", for: .normal)
        readMoreButton.setTitle("Read More", for: .highlighted)
        readMoreButton.addTarget(self, action:#selector(readMoreButtonTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(readMoreButton)
        
        shareButton = DriverDetailButton(with: CGRect(origin: .zero, size: CGSize(width: self.view.frame.size.width * 0.36, height: 47.0)), driver: self.driver)
        shareButton.setTitle("Share", for: .normal)
        shareButton.setTitle("Share", for: .highlighted)
        shareButton.addTarget(self, action:#selector(shareButtonTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(shareButton)
 
        
      //  createShareActionSheet()
    }

    
    //TODO: - polish share action sheet UI.
    private func createShareActionSheet() {
        shareActionSheet.backgroundColor = UIColor(hex: "333333")
        shareActionSheet.alpha = 0.95
        shareActionSheet.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        shareActionSheet.layer.cornerRadius = 20
        shareActionSheet.clipsToBounds = true
        
        if !UIAccessibility.isReduceTransparencyEnabled {
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.shareActionSheet.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.shareActionSheet.addSubview(blurEffectView)
            self.view.addSubview(shareActionSheet)
        }
        
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 10
        
        let shareLabel = UILabel()
        shareLabel.text = "Share"
        shareLabel.font = UIFont(name: "SFProText-Regular", size: 18)
        shareLabel.textColor = .white
        shareLabel.textAlignment = .center
        shareLabel.sizeToFit()
        
        verticalStackView.addArrangedSubview(shareLabel)
        
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .top
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = 10
        
        let facebookButton = createSocialButton(for: "facebook")
        let instagramButton = createSocialButton(for: "instagram")
        let twitterButton = createSocialButton(for: "twitter")
        let snapchatButton = createSocialButton(for: "snapchat")
        horizontalStackView.addArrangedSubview(facebookButton)
        horizontalStackView.addArrangedSubview(instagramButton)
        horizontalStackView.addArrangedSubview(twitterButton)
        horizontalStackView.addArrangedSubview(snapchatButton)
        
        let closeButtonStackView = UIStackView()
        closeButtonStackView.axis = .horizontal
        closeButtonStackView.alignment = .center
        closeButtonStackView.distribution = .fill
        
        let closeButton = UIButton(type: .custom)
        closeButton.backgroundColor = .blue
        closeButton.setTitle("close", for: .normal)
        closeButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        verticalStackView.frame = shareActionSheet.frame
        verticalStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        shareActionSheet.addSubview(verticalStackView)
        
        horizontalStackView.frame = CGRect(x: 0, y: 0, width: verticalStackView.frame.width - 50, height: 50)
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(closeButton)
        
    }
    
    private func createSocialButton(for name: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: name), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return button
    }
    
    private func layoutSubviews() {
        let contentView = self.view!
        let contentViewFrameSize: CGSize = contentView.frame.size
        
        let closeButtonTrailingPadding: CGFloat = 20.0
        let safeAreaInset: CGFloat =  UIDevice.current.hasNotch ? 47.0 : 0
        let closeButtonTopPadding: CGFloat = 20.0
        closeButton.frame.origin = CGPoint(
            x: contentViewFrameSize.width - (closeButton.bounds.size.width + closeButtonTrailingPadding),
            y: safeAreaInset + closeButtonTopPadding)
        
        let driverImageWrapperViewTopPadding: CGFloat = 30.0
        driverImageWrapperView.center = contentView.center
        driverImageWrapperView.frame.origin.y = closeButton.frame.maxY + driverImageWrapperViewTopPadding
        
        let driverLabelTopPadding: CGFloat = 35.0
        driverNameLabel.center = contentView.center
        driverNameLabel.frame.origin.y = driverImageWrapperView.frame.maxY + driverLabelTopPadding
        
        let driverRankingViewLeftPadding: CGFloat = 5.0
        driverRankView.frame.origin.x = driverNameLabel.frame.maxX + driverRankingViewLeftPadding
        driverRankView.center.y = driverNameLabel.frame.midY
        
        let teamNameTopPadding: CGFloat = 15.0
        teamNameLabel.center = contentView.center
        teamNameLabel.frame.origin.y = driverNameLabel.frame.maxY + teamNameTopPadding
        
        
        let descriptionTopPadding: CGFloat = 30.0
        let descriptionHorizontalPadding: CGFloat = 40.0
        descriptionLabel.frame.size = CGSize(width: contentViewFrameSize.width - 2*descriptionHorizontalPadding , height: descriptionLabel.heightForView())
        descriptionLabel.frame.origin = CGPoint(x: descriptionHorizontalPadding, y: teamNameLabel.frame.maxY + descriptionTopPadding)
        
        let actionButtonsHorizontalPadding: CGFloat = 5.0
        let actionButtonsVerticalPadding: CGFloat = 30.0
        
        readMoreButton.frame.origin = CGPoint(
            x: contentView.center.x - (readMoreButton.frame.size.width + actionButtonsHorizontalPadding),
            y: descriptionLabel.frame.maxY + actionButtonsVerticalPadding)
        
        shareButton.frame.origin = CGPoint(
            x: contentView.center.x + actionButtonsHorizontalPadding,
            y: descriptionLabel.frame.maxY + actionButtonsVerticalPadding)
        
            
        let shareActionSheetHeight: CGFloat = 200.0
        shareActionSheet.frame = CGRect(x: 0, y: self.view.frame.height - shareActionSheetHeight, width: self.view.frame.size.width, height: shareActionSheetHeight)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        layoutSubviews()
    }
    
     override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSubviews()
    }
    
    @objc private func closeButtonTapped(sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func readMoreButtonTapped(sender: Any) {
        delegate?.didTapReadMoreButton()
    }
    
    @objc private func shareButtonTapped(sender: Any) {
        delegate?.didTapShareButton()
    }
    
    private func setupUI() {
        guard let driver = self.driver else { return }
        driverImageView.image = UIImage(named: driver.imageUrl!)
        driverNameLabel.text = "\(driver.firstName) \(driver.lastName)"
        teamNameLabel.text = driver.team.name
    }
    
    @IBAction func readMoreButtonTapped(_ sender: Any) {
        delegate?.didTapReadMoreButton()
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        delegate?.didTapShareButton()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

}

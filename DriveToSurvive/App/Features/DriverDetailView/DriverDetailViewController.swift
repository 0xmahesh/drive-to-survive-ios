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
        if traitCollection.userInterfaceStyle == .dark {
            setBorderColor(color: .white)
            self.setTitleColor(.white, for: .normal)
            self.setTitleColor(.gray, for: .highlighted)
        } else {
            setBorderColor(color: UIColor(hex: "333333"))
            self.setTitleColor(.black, for: .normal)
            self.setTitleColor(.gray, for: .highlighted)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = UIColor(hex: driver?.team.color ?? "333333")
                setTitleColors(normal: .white, highlighted: .white)
            } else {
                let metallicGray = UIColor(hex: "333333")
                backgroundColor = .clear
                if traitCollection.userInterfaceStyle == .dark {
                    setTitleColors(normal: .white, highlighted: .white)
                } else {
                    setTitleColors(normal: metallicGray, highlighted: metallicGray)
                }
                
            }
        }
    }
    
    func setBorderColor(color: UIColor) {
        layer.borderColor = color.cgColor
    }
    
    private func setTitleColors(normal: UIColor, highlighted: UIColor) {
        self.setTitleColor(normal, for: .normal)
        self.setTitleColor(highlighted, for: .highlighted)
    }
}

class DriverDetailViewController: UIViewController {
    
    private var driver: Driver?
    
    var scrollView = UIScrollView()
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
    var shareActionSheet:ShareActionSheetView?
    var vMaskLayer : CAGradientLayer = CAGradientLayer()
    var hasScrolledOnce: Bool = false
    
    var largeView = UIView()
 
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
        scrollView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showConfettiForTop(driver: self.driver)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        adaptUIToInterfaceStyle()
    }
    
    private func showConfettiForTop(driver: Driver?) {
        if let driver = self.driver {
           let rank = driver.rank
            if rank == 1 {
                startConfetti(mainView: self.view)
            }
            
        }
    }
    
    private func addReadMoreGradient() {
        var innerColor: CGColor
        if traitCollection.userInterfaceStyle == .dark {
            innerColor = UIColor(white: 1.0, alpha: 0.8).cgColor
        } else {
            innerColor = UIColor.black.withAlphaComponent(0.8).cgColor
        }
        
        let outerColor = UIColor(white: 1.0, alpha: 0.0).cgColor;

        let colors = [outerColor, innerColor]
        let locations: [NSNumber] = [0.92, 1.0]
        
        vMaskLayer.opacity = 0.6
        vMaskLayer.colors = colors;
        vMaskLayer.locations = locations;
        vMaskLayer.bounds = self.view.bounds;
        vMaskLayer.anchorPoint = .zero;

        self.view.layer.addSublayer(vMaskLayer)
    }
    
    private func createSubviews() {
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false;
        view.addSubview(scrollView)
        
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true;
        self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true;
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true;
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true;
        self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        closeButton.frame = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        if traitCollection.userInterfaceStyle == .dark {
            closeButton.setImage(UIImage(named:"close-white"), for: .normal)
            closeButton.setImage(UIImage(named:"close-white"), for: .highlighted)
        } else {
            closeButton.setImage(UIImage(named:"close-black"), for: .normal)
            closeButton.setImage(UIImage(named:"close-black"), for: .highlighted)
        }
        
        closeButton.addTarget(self, action:#selector(closeButtonTapped(sender:)), for: .touchUpInside)
        self.scrollView.addSubview(closeButton)
        
        if let imageUrl = driver?.imageUrl {
            driverImageView.image = UIImage(named: imageUrl)
        }
        
        driverImageView.contentMode = .scaleAspectFit
        driverImageView.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 300))
        driverImageWrapperView.frame = driverImageView.frame
        driverImageWrapperView.addSubview(driverImageView)
        driverImageWrapperView.dropShadow(color: UIColor(hex: driver?.team.color ?? "000000"))
        self.scrollView.addSubview(driverImageWrapperView)
        
        driverNameLabel.frame = CGRect(origin: .zero, size: .zero)
        driverNameLabel.font = UIFont(name: "Formula1-Display-Bold", size: 20.0)

        driverNameLabel.textAlignment = .center
        if let firstName = self.driver?.firstName, let lastName = self.driver?.lastName {
            driverNameLabel.text = "\(firstName) \(lastName)"
            driverNameLabel.sizeToFit()
        }
        self.scrollView.addSubview(driverNameLabel)
        
        teamNameLabel.frame = CGRect(origin: .zero, size: .zero)
        teamNameLabel.font = UIFont(name: "Formula1-Display-Regular", size: 16.0)

        teamNameLabel.textAlignment = .center
        if let teamName = self.driver?.team.name {
            teamNameLabel.text = teamName
            teamNameLabel.sizeToFit()
        }
        self.scrollView.addSubview(teamNameLabel)
       
        descriptionLabel.frame = CGRect(origin: .zero, size: CGSize(width: self.view.frame.width - 2*40, height: 300))
        descriptionLabel.font = UIFont(name: "Avenir-Roman", size: 16.0)

        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        if let description = self.driver?.description {
            descriptionLabel.text = description
        }
        self.scrollView.addSubview(descriptionLabel)
        
        driverRankLabel.frame = CGRect(origin: .zero, size: .zero)
        driverRankLabel.font = UIFont(name: "MuktaMahee-Bold", size: 18.0)

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
        self.scrollView.addSubview(driverRankView)
        
        readMoreButton = DriverDetailButton(with: CGRect(origin: .zero, size: CGSize(width: self.view.frame.size.width * 0.36, height: 47.0)), driver: self.driver)
        readMoreButton.setTitle("Read More", for: .normal)
        readMoreButton.setTitle("Read More", for: .highlighted)
        readMoreButton.addTarget(self, action:#selector(readMoreButtonTapped(sender:)), for: .touchUpInside)
        self.scrollView.addSubview(readMoreButton)
        
        shareButton = DriverDetailButton(with: CGRect(origin: .zero, size: CGSize(width: self.view.frame.size.width * 0.36, height: 47.0)), driver: self.driver)
        shareButton.setTitle("Share", for: .normal)
        shareButton.setTitle("Share", for: .highlighted)
        shareButton.addTarget(self, action:#selector(shareButtonTapped(sender:)), for: .touchUpInside)
        self.scrollView.addSubview(shareButton)
        
        adaptUIToInterfaceStyle()
    }
    
    private func adaptUIToInterfaceStyle() {
        if traitCollection.userInterfaceStyle == .dark {
            driverNameLabel.textColor = .white
            teamNameLabel.textColor = .white
            descriptionLabel.textColor = UIColor(white: 0.7, alpha: 1)
            driverRankLabel.textColor = .black
            self.view.backgroundColor = .black
            
            shareButton.setTitleColor(.white, for: .normal)
            shareButton.setTitleColor(.white, for: .highlighted)
            
            readMoreButton.setTitleColor(.white, for: .normal)
            readMoreButton.setTitleColor(.white, for: .highlighted)
            
            shareButton.setBorderColor(color:.white)
            readMoreButton.setBorderColor(color:.white)
            
            closeButton.setImage(UIImage(named:"close-white"), for: .normal)
            closeButton.setImage(UIImage(named:"close-gray"), for: .highlighted)
        } else {
            let metallicGrayColor = UIColor(hex: "333333")
            
            driverNameLabel.textColor = .black
            teamNameLabel.textColor = .black
            descriptionLabel.textColor = metallicGrayColor
            driverRankLabel.textColor = .red
            self.view.backgroundColor = UIColor(hex: "fbfbfb")
            
            shareButton.setTitleColor(metallicGrayColor, for: .normal)
            shareButton.setTitleColor(metallicGrayColor, for: .highlighted)
            
            readMoreButton.setTitleColor(metallicGrayColor, for: .normal)
            readMoreButton.setTitleColor(metallicGrayColor, for: .highlighted)
            
            shareButton.setBorderColor(color: metallicGrayColor)
            readMoreButton.setBorderColor(color: metallicGrayColor)
            
            closeButton.setImage(UIImage(named:"close-black"), for: .normal)
            closeButton.setImage(UIImage(named:"close-gray"), for: .highlighted)
        }
    }


    private func createShareActionSheet() {
        shareActionSheet = ShareActionSheetView(frame: CGRect(origin: .zero, size: self.view.frame.size))
        self.view.addSubview(shareActionSheet!)  
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
        
        let driverImageWrapperViewTopPadding: CGFloat = 20.0
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
        
        if(!hasScrolledOnce) {
            let descriptionHeight = getLabelHeight(for: descriptionLabel.text ?? "", in: self.view, font: UIFont(name: "Avenir-Roman", size: 16)!, padding: 2*20)
            if(descriptionHeight > 0.25 * view.frame.height) {
                addReadMoreGradient()
            }
        }
        
        let actionButtonsHorizontalPadding: CGFloat = 5.0
        let actionButtonsVerticalPadding: CGFloat = 30.0
        
        readMoreButton.frame.origin = CGPoint(
            x: contentView.center.x - (readMoreButton.frame.size.width + actionButtonsHorizontalPadding),
            y: descriptionLabel.frame.maxY + actionButtonsVerticalPadding)
        
        shareButton.frame.origin = CGPoint(
            x: contentView.center.x + actionButtonsHorizontalPadding,
            y: descriptionLabel.frame.maxY + actionButtonsVerticalPadding)
        
            
//        let shareActionSheetHeight: CGFloat = 200.0
//        shareActionSheet.frame = CGRect(x: 0, y: self.view.frame.height - shareActionSheetHeight, width: self.view.frame.size.width, height: shareActionSheetHeight)
        
        let contentHeight: CGFloat = closeButtonTopPadding + safeAreaInset + closeButton.frame.height + driverImageWrapperViewTopPadding + driverImageWrapperView.frame.height + driverLabelTopPadding + driverNameLabel.frame.height + teamNameTopPadding + teamNameLabel.frame.height +
            descriptionTopPadding + descriptionLabel.frame.height +
            actionButtonsVerticalPadding + readMoreButton.frame.height + 20
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight)
        scrollView.setContentOffset(.zero, animated: false)
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
        createShareActionSheet()
        delegate?.didTapShareButton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.shareActionSheet?.show()
        })
        
        
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

extension DriverDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !hasScrolledOnce {
            hasScrolledOnce = true
        }
        vMaskLayer.removeFromSuperlayer()
    }
}

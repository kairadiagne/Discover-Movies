//
//  DetailHeaderView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView {
    
    private struct Constants {
        static let PlayButtonSize = CGSize(width: 55, height: 55)
    }
    
    // MARK: - Storyboard
    
    class func loadFromNIB() -> DetailHeaderView {
        return NSBundle.mainBundle().loadNibNamed("DetailHeaderView", owner: self, options: nil).first as! DetailHeaderView
    }
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    // TODO: - Is this neccesarry (Property Observers)
    
    var colors: [CGColor] = [UIColor.backgroundColor().CGColor, UIColor.clearColor().CGColor] {
        didSet {
            self.gradientLayer.colors = colors
        }
    }
    
    var startPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet {
            self.gradientLayer.startPoint = startPoint
        }
    }
    var endPoint: CGPoint = CGPoint(x: 0, y: 0.1) {
        didSet {
            self.gradientLayer.endPoint = endPoint
        }
    }
    
    private var playButtonBackgroundLayer: CAShapeLayer!
    private var gradientLayer: CAGradientLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = frame
        self.gradientLayer.colors = colors
        self.gradientLayer.startPoint = startPoint
        self.gradientLayer.endPoint = endPoint
        self.detailImageView.layer.addSublayer(self.gradientLayer)
        
        self.playButton.tintColor = UIColor.backgroundColor()
        
        let backgroundLayer = CAShapeLayer()

        backgroundLayer.frame.size = CGSize(width: 20, height: 20)
        let centerX = playButton.bounds.width / 2 - backgroundLayer.frame.size.width / 2
        let centerY = playButton.bounds.height / 2 - backgroundLayer.frame.size.height / 2
        let centerPoint = CGPoint(x: centerX, y: centerY)
        
        backgroundLayer.frame.origin = centerPoint
        backgroundLayer.backgroundColor = UIColor.whiteColor().CGColor
        self.playButton.layer.addSublayer(backgroundLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Update the size of the gradient layer
        // Turns off the default animation of CALayer to prevent a noticeable lag.
        // CATransaction class implements transition animations for a layer, and allows us
        // to override default animation properties that are set for animateable properties.
        CATransaction.begin()
        // Actions triggered as a result of property changes made within this transaction group are supressed.
        CATransaction.setDisableActions(true)
        self.gradientLayer.frame = self.bounds
        // Commit all changes made during the current transaction
        CATransaction.commit()
    }
    
}

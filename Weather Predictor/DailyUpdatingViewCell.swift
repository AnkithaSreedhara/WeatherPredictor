//
//  DailyUpdatingViewCell.swift
//  Weather Predictor
//
//  Created by Anki on 15/01/16.
//  Copyright © 2016 Anki. All rights reserved.
//

import UIKit

class DailyUpdatingViewCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgViewForForecastType: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    //    @IBOutlet weak var lblMaxTemp: UILabel!
    //    @IBOutlet weak var lblMinTemp: UILabel!
    //    @IBOutlet weak var imgViewAirElement: UIImageView!
    //    @IBOutlet weak var imgViewWindSpeed: UILabel!
    //    @IBOutlet weak var lblDirection: UILabel!
    @IBOutlet weak var imgBackGround: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgBackGround.layer.cornerRadius = 5.0
        self.imgBackGround.layer.borderWidth = 1.0
        self.imgBackGround.layer.borderColor = UIColor.darkGrayColor().CGColor
        
        let view: UIView = UIView(frame: CGRectMake(20.0, 170.0, 15, 60.0))
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        
        gradient.colors = [UIColor(red: 70/255.0, green: 226/255.0, blue: 255/255.0, alpha: 1).CGColor, UIColor(red: 230/255.0, green: 81/255.0, blue: 255/255.0, alpha: 1).CGColor]
        view.layer.insertSublayer(gradient, atIndex: 0)
        view.layer.cornerRadius = 5.0
        
        self.addSubview(view)
    }
    
}

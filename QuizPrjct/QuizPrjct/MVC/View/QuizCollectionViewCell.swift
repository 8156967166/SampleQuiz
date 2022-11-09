//
//  QuizCollectionViewCell.swift
//  QuizPrjct
//
//  Created by Bimal@AppStation on 07/06/22.
//

import UIKit

class QuizCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelInCell: UILabel?
    @IBOutlet weak var imgaeViewInCell: UIImageView?
    
    func setModel(setQuizModel: Quiz) {
        self.labelInCell?.text = setQuizModel.title
        self.imgaeViewInCell?.image = UIImage(named: setQuizModel.setimage ?? "")
    }
}

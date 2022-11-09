//
//  QuizViewController.swift
//  QuizPrjct
//
//  Created by Bimal@AppStation on 07/06/22.
//

import UIKit

class QuizViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionview: UICollectionView!
    var quizArray = [Quiz]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setModelQuiz()
        // Do any additional setup after loading the view.
    }
    
    func setModelQuiz(){
        let gkModel = Quiz(strTitle: "GK", image: "knowledge")
        let scienceModel = Quiz(strTitle: "Science", image: "science")
        let sportsModel = Quiz(strTitle: "Sports ", image: "sports")
        let mythologyModel = Quiz(strTitle: "Mythology", image: "zeus")
        let geogrphyModel = Quiz(strTitle: "Geography", image: "mountain")
        let histryModel = Quiz(strTitle: "History", image: "history")
        quizArray = [gkModel, scienceModel, sportsModel, mythologyModel, geogrphyModel, histryModel]
        
    }
}
extension QuizViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellmodel = quizArray[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! QuizCollectionViewCell
        cell.setModel(setQuizModel: cellmodel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.size.width/2)-13.0, height: 200.0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let vc = storyBoard.instantiateViewController(withIdentifier: "QuizApi") as! QuizApiViewController
         self.navigationController?.pushViewController(vc, animated: true)
    }
}

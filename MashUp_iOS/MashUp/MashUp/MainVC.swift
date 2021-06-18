//
//  ViewController.swift
//  MashUp
//
//  Created by Hyun on 2021/06/08.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    let categorySet = [UIImage(named: "0"),
                       UIImage(named: "1"),
                       UIImage(named: "2"),
                       UIImage(named: "3"),
                       UIImage(named: "4"),
                       UIImage(named: "5"),
                       UIImage(named: "6"),
                       UIImage(named: "7"),
                       UIImage(named: "8"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
    }


}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorySet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! categoryCell
        
        cell.categoryImg.image = categorySet[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let cellSelect = storyboard.instantiateViewController(identifier: "BoardsView") as? BoardsVC {
            cellSelect.selectedCategorty = indexPath.row
            self.navigationController?.pushViewController(cellSelect, animated: true)
        }
    }
    
    // CollectionView Cell의 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3.0
    }
    
    // CollectionView Cell의 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    // CollectionView Cell의 크기 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = categoryCollectionView.frame.width / 3 - 2.0
        let height: CGFloat = width * 1.3
        return CGSize(width: width, height: height)
    }
}

class categoryCell: UICollectionViewCell {
    @IBOutlet weak var categoryImg: UIImageView!
}


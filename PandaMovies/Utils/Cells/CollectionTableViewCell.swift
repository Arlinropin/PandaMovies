//
//  CollectionTableViewCell.swift
//  PandaMovies
//
//  Created by Arlin Ropero on 19/06/21.
//

import UIKit

class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var heigthCollection: NSLayoutConstraint!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var backwardButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    var movies: [Movie] = []
    var backwardCallback: (()->Void)?
    var forwardCallback: (()->Void)?
    var movieCallback: ((Movie)->Void)?
    
    func initWithData(page: Int, movies: [Movie], height: CGFloat)  {
        pageLabel.text = "Page " + "\(page)"
        self.movies = movies
        heigthCollection.constant = height - 55
        collection.reloadData()
        backwardButton.isHidden = page == 1
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: CellType.POSTER_CELL.rawValue, bundle: Bundle.main),forCellWithReuseIdentifier: CellType.POSTER_CELL.rawValue)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let obj = movies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.POSTER_CELL.rawValue, for: indexPath) as! PosterCollectionViewCell
        cell.initWithData(image: obj.poster_image, label:  obj.title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieCallback!(movies[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 30) / 2
        let height = width * 7 / 5
        return CGSize( width: width, height: height)

    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    
    @IBAction func backwardAndForward(_ sender: UIButton) {
        switch (sender.titleLabel?.text)! {
        case "forward":
            forwardCallback!()
        default:
            backwardCallback!()
        }
    }
}

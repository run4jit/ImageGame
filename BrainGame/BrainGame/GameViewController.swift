//
//  GameViewController
//  BrainGame
//
//  Created by ranjeetkumar on 17/01/17.
//  Copyright © 2017 ranjeetkumar. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var gameCollectionView: UICollectionView!
    internal var flickrCard: [FlickrCardType]?
    static let identifire = "FlickrCardCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup Views
        setupViews();
        featchFlickrCard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupViews() {
        let nibName = GameViewController.identifire;
        let nib = UINib(nibName: nibName, bundle: Bundle.main)
        gameCollectionView.register(nib, forCellWithReuseIdentifier: GameViewController.identifire)
    }

    func featchFlickrCard() {
       self.flickrCard = FlickrService.imageListService()
    }
}

extension GameViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return flickrCard?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameViewController.identifire, for: indexPath)
        
        guard let flickrCell = cell as? FlickrCardCollectionCell else {
           return UICollectionViewCell();
        }
        
        let card = flickrCard?[indexPath.row]
        flickrCell.cardViewUpdateOrReset(flickr: card)
        
        return flickrCell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        // Only one section
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 106, height: 126)
    }
    
    func loadImage()
    {
        //load image
    }
}

extension GameViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}

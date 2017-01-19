//
//  GameViewController
//  BrainGame
//
//  Created by ranjeetkumar on 17/01/17.
//  Copyright © 2017 ranjeetkumar. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameViewModelDelegates {
    @IBOutlet weak var counterLabel: UILabel!

    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var guessImageView: UIImageView!
    @IBOutlet weak var counter: UILabel!
    static let identifire = "FlickrCardCollectionCell"
    var gameViewModel: GameViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup Views
        setupViews();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
        askUserToStartGame()

    }
    
    func setupViews() {
        self.gameViewModel = {()-> GameViewModel in
            return GameViewModel(delegate: self)
        }()
        let nibName = GameViewController.identifire;
        let nib = UINib(nibName: nibName, bundle: Bundle.main)
        gameCollectionView.register(nib, forCellWithReuseIdentifier: GameViewController.identifire)
    }
    func askUserToStartGame() {
        let alert = UIAlertController(title: "Game Start!", message: "All Image is getting downloaded.\nYou have to remember the image with sequence number.\nClick Okay to start game", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Start", style: UIAlertActionStyle.cancel) { (_) in
            self.gameViewModel?.startGame();
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action);
        self.present(alert, animated: true, completion: nil)
    }
    // Mark: GameViewModelDelegates
    func getCollectionView() -> UICollectionView?
    {
        guard let collection = gameCollectionView else {
            return nil;
        }
        return collection
    }

    func getGuessCardImageView() -> UIImageView?
    {
        guard let imageView = guessImageView else {
            return nil;
        }
        return imageView
    }

    func updateCountDown(count: String) -> Void {
        self.counterLabel.text = count
    }

    func gameOver()
    {
        let alert = UIAlertController(title: "Game Over", message: "Congratulation you have win the game", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Reset", style: UIAlertActionStyle.default) { (_) in
            self.gameViewModel?.restartGame();
        }
        let cancelAlert = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action);
        alert.addAction(cancelAlert);
        self.present(alert, animated: true, completion: nil)
    }
}


extension GameViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.gameViewModel?.flickrCards.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameViewController.identifire, for: indexPath)
        
        guard let flickrCell = cell as? FlickrCardCollectionCell else {
           return UICollectionViewCell();
        }
        
        let card = self.gameViewModel?.flickrCards[indexPath.row]
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
}

extension GameViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.gameViewModel?.userTapped(index: indexPath.row)
    }
    
}

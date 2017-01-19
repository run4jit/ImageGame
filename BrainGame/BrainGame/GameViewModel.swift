
//
//  GameViewModel.swift
//  BrainGame
//
//  Created by ranjeetkumar on 18/01/17.
//  Copyright © 2017 ranjeetkumar. All rights reserved.
//

import Foundation
import UIKit
let maxCardCount = 9

protocol GameViewModelDelegates: class {
    func getCollectionView() -> UICollectionView?
    func getGuessCardImageView() -> UIImageView?
    func gameOver()
    func updateCountDown(count: String) -> Void
}

class GameViewModel {
    private static let maxWaitingInterval: UInt32 = 15
    static var flipCardView = false

    weak var gameDelegate: GameViewModelDelegates?
    private var count: UInt32 = 0;
    private var indexs = [Int]()
    private var counterTimer: Timer?
    var flickrCards = [FlickrCardType]()
    
    init(delegate: GameViewModelDelegates) {
        self.gameDelegate = delegate;
        
        self.featchFlickrCard()
        FlickrImageDownloader.sharedInstance.notify = allImageDownloaded;
        
    }
    private func allImageDownloaded() -> Void {
        // Just to not receive call back for any other image download
        FlickrImageDownloader.sharedInstance.notify = nil;

    }
    func startGame() {
        startCounterTimer();
    }
    private func startCounterTimer() {
        self.stopCounterTimer();
        self.counterTimer = Timer.scheduledTimer(withTimeInterval: 1,
                                                 repeats: true,
                                                 block:updateCounter)
        self.counterTimer?.fire()
    }
    
    private func stopCounterTimer() {
        self.counterTimer?.invalidate()
        self.counterTimer = nil
    }
    
    private func featchFlickrCard() {
        FlickrService.imageListService(callBack: {[unowned self] (cards) in
            self.flickrCards = cards
            self.gameInitialized();
        })
    }

    private func flipAllCard()
    {
        GameViewModel.flipCardView = !GameViewModel.flipCardView

        for flickrCard in self.flickrCards
        {
            let card: FlickrCard = flickrCard as! FlickrCard
            let index = card.getCardIndex()
            if index >= 0
            {
                let indexPath = IndexPath(row: index, section: 0)
                if let cell = self.gameDelegate?.getCollectionView()?.cellForItem(at: indexPath) as? FlickrCardCollectionCell
                {
                    UIView.animate(withDuration: 0.25, animations: {
                        cell.cardView.alpha = GameViewModel.flipCardView ? 0 : 1
                        cell.numberLabel.alpha = GameViewModel.flipCardView ? 1 : 0
                    })
                }
                
            }
        }
    }
    
    private func gameInitialized()
    {
        count = 0
        indexs.removeAll()
        self.gameDelegate?.getCollectionView()?.reloadData();
        self.gameDelegate?.getGuessCardImageView()?.isHidden = true
    }
    
    func restartGame() -> Void {
        count = 0
        indexs.removeAll()
        self.flipAllCard()
        self.gameDelegate?.getGuessCardImageView()?.isHidden = true
        self.startCounterTimer()
    }
    
    private func isGameOver() -> Bool {
        return indexs.count >= (maxCardCount-1)
    }
    
    func userTapped(index: Int) -> Void {
        guard let guessIndex = indexs.last else {
            return
        }
        let userSelectedCard = self.flickrCards[index]
        let guessCard = self.flickrCards[guessIndex]
        if guessCard == userSelectedCard as! FlickrCard
        {
            if isGameOver() {
                self.gameDelegate?.gameOver();
            }
            else
            {
                getRandomImageToShow();
            }
        }
    }
    
    private func getRandomImageToShow() {
        var index: Int = 0
        repeat
        {
            index = Int(arc4random()) % maxCardCount
        } while indexs.contains(index)
        if self.flickrCards.count > index
        {
            
            guard let url = self.flickrCards[index].imageUrl else {
                return
            }
            guard let imageView = self.gameDelegate?.getGuessCardImageView() else {
                return
            }
            imageView.af_setImage(withURL: url, placeholderImage: FlickrImageDownloader.placeholderImage, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: false) {(image) in
                imageView.image = image.result.value
            }

        }
        
        indexs.append(index);
    }
    
    private func updateCounter(timer: Timer) -> Void {
        self.gameDelegate?.updateCountDown(count: "\(count+1)")
        if count >= GameViewModel.maxWaitingInterval {
            self.stopCounterTimer()
            self.flipAllCard()
            self.gameDelegate?.getGuessCardImageView()?.isHidden = false
            self.getRandomImageToShow()
        }
        count += 1;
    }
}

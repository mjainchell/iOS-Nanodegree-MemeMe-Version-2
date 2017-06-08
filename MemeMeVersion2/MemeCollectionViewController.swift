//
//  MemeCollectionViewController.swift
//  MemeMeVersion2
//
//  Created by Mark Jainchell on 6/7/17.
//  Copyright © 2017 Mark Jainchell. All rights reserved.
//

import UIKit

private let reuseIdentifier = "memeCollectionViewCell"

class MemeCollectionViewController: UICollectionViewController {

    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    //MARK: Properties
    
    // memes property has been changed based on code review
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    var finishedMemeToSend: UIImage!
    var memeIndexToSend: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Code for using flowLayout is largely based on code provided in Udacity Lesson
    override func viewWillAppear(_ animated: Bool) {
        flowLayout.minimumInteritemSpacing = 1.5
        flowLayout.minimumLineSpacing = 1.5
        flowLayout.itemSize = CGSize(width: determineLandscapeOrPortrait(), height: determineLandscapeOrPortrait() * 1.5)
    }
    
    func determineLandscapeOrPortrait() -> CGFloat {
        let cellSpacing:CGFloat = 1.5
        var cellDimensions: CGFloat! = 0.0
        let setWidthDimensionPortrait = (view.frame.size.width - (2 * cellSpacing)) / 3.0
        let setWidthDimensionLandscape = (view.frame.size.width - (2 * cellSpacing)) / 6.0
        
        if view.frame.size.width < view.frame.size.height {
            cellDimensions = setWidthDimensionPortrait
        } else if view.frame.size.height < view.frame.size.width {
            cellDimensions = setWidthDimensionLandscape
        }
        
        return cellDimensions
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "ShowDetailFromCollectionViewSegue" {
            let viewController = segue.destination as! MemeDetailViewController
            let indexPath = sender as! IndexPath
            let meme = memes[indexPath.item]
            // Shruti Choksi provided assistance regarding how to use the Meme object in this context.
            viewController.meme = meme
            viewController.memeIndexToReceive = memeIndexToSend
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
 
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.item]
        cell.memeCollectionViewCellImageView.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        finishedMemeToSend = memes[indexPath.item].memedImage
        memeIndexToSend = memes.index { (targetMeme) -> Bool in
            targetMeme.memedImage == finishedMemeToSend
        }
        self.performSegue(withIdentifier: "ShowDetailFromCollectionViewSegue", sender: indexPath)
    }
    
}

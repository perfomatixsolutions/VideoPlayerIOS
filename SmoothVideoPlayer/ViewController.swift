//
//  ViewController.swift
//  SmoothVideoPlayer
//
//  Created by Manu on 10/09/20.
//  Copyright © 2020 perfomatix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let videos = ["http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4" ,
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
     "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
         self.collectionView.setContentOffset(.zero, animated: false)
        // Do any additional setup after loading the view.
    }

    func setupCollectionView() {
          collectionView.delegate = self
          collectionView.dataSource = self
          collectionView.showsHorizontalScrollIndicator = false
          collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.black
          
          let mainLayout = UICollectionViewFlowLayout()
          mainLayout.scrollDirection = .vertical
     
          mainLayout.minimumLineSpacing = 0
          mainLayout.minimumInteritemSpacing = 0
          collectionView.collectionViewLayout = mainLayout
          collectionView.isPagingEnabled = true
      }
}

extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if let cell = cell as? PlayVideoCollectionViewCell {
                 let vidUrl = videos[indexPath.row]
                        
                                   let Vurl = URL(string: vidUrl)
                                   cell.set(url: Vurl!)
                                   cell.play()
               }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayVideoCollectionViewCell.identifier, for: indexPath) as! PlayVideoCollectionViewCell
        cell.makeAnimate()
       
         
        return cell
    }
     func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
          if let cell = cell as? PlayVideoCollectionViewCell {
             cell.stopVideo()
        }
    }
    
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
}

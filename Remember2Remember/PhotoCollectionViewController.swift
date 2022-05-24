//
//  PhototCollectionViewController.swift
//  Remember2Remember
//
//  Created by Chris Boshoff on 2022/05/11.
//

import UIKit



private let reuseIdentifier = "Cell"

class PhotoCollectionViewController: UICollectionViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = .systemBlue
       collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tabBarController?.navigationItem.title = "Photo's"
//    }


    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        cell.backgroundColor = .systemRed
        return cell
    }
    
//    @IBAction func addButtonTapped(_ sender: UIButton) {
//
//
//    }

}



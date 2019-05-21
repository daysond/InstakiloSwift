//
//  ViewController.swift
//  InstakiloSwift
//
//  Created by Dayson Dong on 2019-05-20.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: Property
    @IBOutlet weak var imageColletionView: UICollectionView!
    var flowLayout = UICollectionViewFlowLayout.init()
    var dataSource:[[String]] = []
    var dataSourceByRange:[[String]] = []
    var dataSourceByRole:[[String]] = []
    var section:[String] = []
    var selectedImageName = ""
    var source = 0
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSourceByRange = [["Blitzcrank","Fizz","Zed"],["Lux","Brand","Teemo","Kayle","Morgana","Kaisa","Annie"]]
        self.dataSourceByRole = [["Lux","Brand","Morgana","Fizz","Annie","Teemo"],["Kaisa","Zed"],["Blitzcrank","Kayle"]]
        dataSource(source: self.source)
        setupFlowLayout()
        
    }
    
    //MARK: Setups
    
    func setupFlowLayout() {
        
        self.flowLayout = self.imageColletionView.collectionViewLayout as! UICollectionViewFlowLayout
        self.flowLayout.minimumInteritemSpacing = 10
        self.flowLayout.itemSize.width = (self.view.frame.width - 10) / 2
        self.flowLayout.itemSize.height = (self.view.frame.width - 10) / 2 * (3.0/4.0)
        
    }
    
    func dataSource(source:Int) {
        self.source = source

        switch source {
        case 0:
            self.section = ["Meele","Ranged"]
            self.dataSource = dataSourceByRange
        case 1:
            self.section = ["AP","AD","Hybird"]
            self.dataSource = dataSourceByRole
        default:
            return
        }
        
        print(self.section)
        
        
    }
    
    //MARK: IBAction
    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        self.dataSource(source: sender.selectedSegmentIndex)
        self.imageColletionView.reloadData()
        
    }
    
    @objc func deleteImage(sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            
            let cell = sender.view as! ImagelCollectionViewCell
            if let indexPath = self.imageColletionView.indexPath(for: cell) {
                
                let imageName = self.dataSource[indexPath.section][indexPath.row]
                self.dataSource[indexPath.section] = self.dataSource[indexPath.section].filter{$0 != imageName}
                
                for i in 0..<dataSourceByRange.count {
                    if dataSourceByRange[i].contains(imageName) {
                        dataSourceByRange[i] = dataSourceByRange[i].filter{$0 != imageName}
                    }
                }
                for i in 0..<dataSourceByRole.count {
                    if dataSourceByRole[i].contains(imageName) {
                        dataSourceByRole[i] = dataSourceByRole[i].filter{$0 != imageName}
                    }
                }
            }
            self.imageColletionView.reloadData()
        }

        
        
    }
    

    
    //MARK: Collection View Delegates
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ImagelCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImagelCollectionViewCell
        cell.imageView.image = UIImage.init(named: self.dataSource[indexPath.section][indexPath.item])
        
        let press = UILongPressGestureRecognizer.init(target: self, action:#selector(deleteImage) )
        press.minimumPressDuration = 0.5
        cell.addGestureRecognizer(press)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var headerView = HeaderCollectionReusableView.init()
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderCollectionReusableView
            
        }
        
        headerView.headerLabel.text = self.section[indexPath.section]
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedImageName = self.dataSource[indexPath.section][indexPath.item]
        performSegue(withIdentifier: "toDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            let dvc: DetailViewController = segue.destination as! DetailViewController
            dvc.imageName = self.selectedImageName

        
    }


}


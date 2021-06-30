//
//  FetchPhotosViewController.swift
//  CaseStudy
//
//  Created by Usman Piracha on 29/06/2021.
//

import UIKit

class FetchPhotosViewController: UIViewController {
    
    var presenter: FetchPhotosPresenter!
    var configurator: FetchPhotosConfigurator!
    
    @IBOutlet weak var selectedPhotoImageView:CacheImageView!
    @IBOutlet weak var photosCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let fetchPhotosViewController = FetchPhotosViewController()
        configurator = FetchPhotosConfig()
        fetchPhotosViewController.configurator = configurator
        configurator.configure(fetchPhotosVC: self)
        
        presenter.fetchPhotos()
    }
    
    func show(selected photo:GalleryImageViewDetails){
        self.selectedPhotoImageView.loadImage(using: photo.webformatURL)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}


extension FetchPhotosViewController: FetchPhotosView {
    func reloadPhotos() {
        photosCollection.reloadData()
        if let photo = presenter.photos.first  {
            self.show(selected: photo)
            let indexPath:IndexPath = IndexPath(row: 0, section: 0)
            photosCollection?.selectItem(at: indexPath, animated: false, scrollPosition: .top)

        }
        
    }
    
    func showError(title: String, message: String) {
        // show alert
    }
}

//MARK: - CollectionView Data source
extension FetchPhotosViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return presenter.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = presenter.photos[indexPath.row]
        cell.photoImage.loadImage(using: photo.previewURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let photo = presenter.photos[indexPath.row]
        self.show(selected: photo)
        
    }
    
}


//MARK: - CollectionView Flow Layout
extension FetchPhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width / 3.2
        return CGSize(width: width, height: width)
    }
}

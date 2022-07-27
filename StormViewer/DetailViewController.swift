//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Mario Jackson on 7/21/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet private var imageView: UIImageView!
    var selectedImage: String?
    var selectedImageIndex: Int?
    var totalAmountOfImages: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Since we know the pictures are there for sure, we can force unwrap
        // even though it's not the best solution. (It's just tutorial)
        title = "Picture \(selectedImageIndex! + 1) of \(totalAmountOfImages!)"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareTapped)
        )
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let viewController = UIActivityViewController(activityItems: [image] , applicationActivities: [])
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(viewController, animated: true)
    }
}

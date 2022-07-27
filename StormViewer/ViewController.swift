//
//  ViewController.swift
//  StormViewer
//
//  Created by Mario Jackson on 7/13/22.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareStormViewer)
        )
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        pictures.sort()
    }
        
    /**
    Return the number of pictures found.
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    /**
     Set the picture's title for the cell and return it.
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    /**
     Set the selected image.
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            viewController.selectedImage = pictures[indexPath.row]
            viewController.selectedImageIndex = indexPath.row
            viewController.totalAmountOfImages = pictures.count
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @objc func shareStormViewer() {
        let viewController = UIActivityViewController(activityItems: [self.title ?? "Storm Viewer"], applicationActivities: [])
        
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(viewController, animated: true)
    }
}


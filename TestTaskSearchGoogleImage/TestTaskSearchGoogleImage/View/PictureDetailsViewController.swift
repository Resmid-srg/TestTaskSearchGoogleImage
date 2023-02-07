//
//  PictureDetailsViewController.swift
//  TestTaskSearchGoogleImage
//
//  Created by Serov Dmitry on 07.02.23.
//

import UIKit

class PictureDetailsViewController: UIViewController {
    
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var openSourceButton: UIButton!
    
    var currentPicture: Int = -1
    var pictures: [Picture] = []
        
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
    }
    
    @IBAction func prevButtonTapped(_ sender: Any) {
    }
    
    @IBAction func openSourceButtonTapped(_ sender: Any) {
    }
    
}

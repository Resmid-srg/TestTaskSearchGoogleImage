//
//  PictureDetailsViewController.swift
//  TestTaskSearchGoogleImage
//
//  Created by Serov Dmitry on 07.02.23.
//

import UIKit

class PictureDetailsViewController: UIViewController {
    
    var currentPictureIndex: Int = -1
    var pictures: [Picture] = []
    
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var openSourceButton: UIButton!
            
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setups
        imageSetupsAndAnimationLoading()
    }
    
    //MARK: - Button actions
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if (currentPictureIndex + 1) < pictures.count {
            currentPictureIndex += 1
        } else {
            currentPictureIndex = 0
        }
        self.pictureView.pushUpTransitionLeft(0.2)
        imageSetupsAndAnimationLoading()
    }
    
    @IBAction func prevButtonTapped(_ sender: Any) {
        if (currentPictureIndex - 1) >= 0 {
            currentPictureIndex -= 1
        } else {
            currentPictureIndex = pictures.count - 1
        }
        self.pictureView.pushUpTransitionRight(0.2)
        imageSetupsAndAnimationLoading()
    }
    
    @IBAction func openSourceButtonTapped(_ sender: Any) {
        let webVC = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        webVC.pictureSourceURL = pictures[currentPictureIndex].link
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    //MARK: - Setups
        
    private func imageSetupsAndAnimationLoading() {
        
        //Аlag to track the display of the image
        var flagAnim = false
        
        //Delay to start animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if flagAnim == false {
                self.view.activityStartAnimating()
            }
        }
        
        //Load picture and stop animation loading
        pictureView.sd_setImage(with: URL(string: pictures[currentPictureIndex].original)) { [weak self] (pic, error, cache, url) in
            if let error = error {
                print(error.localizedDescription)
                guard let currentPictureIndex = self?.currentPictureIndex else { return }
                guard let urlThumbnail = self?.pictures[currentPictureIndex].thumbnail else { return }
                self?.pictureView.sd_setImage(with: URL(string: urlThumbnail))
                self?.view.activityStopAnimating()
                flagAnim = true
            }
            
            if let _ = pic {
                self?.view.activityStopAnimating()
                flagAnim = true
            }
        }
    }
}

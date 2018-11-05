//
//  ViewController.swift
//  LoveApp
//
//  Created by Anila Elisabetta Hoxha on 10/29/18.
//  Copyright © 2018 Anila Elisabetta Hoxha. All rights reserved.
//

import UIKit
import AVFoundation
//MARK: Properties
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
   
{
    @IBOutlet weak var imagetolove: UIImageView!
    var audioPlayer = AVAudioPlayer()
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var label: UITextField!
    //MARK:Functions
    func animateImage(){
        let bounds = self.imagetolove.bounds
        //shrink our image to love by 60 pixels
        self.imagetolove.bounds = CGRect(x: self.imagetolove.bounds.origin.x + 60, y: self.imagetolove.bounds.origin.y + 60, width: self.imagetolove.bounds.size.width - 60, height: self.imagetolove.bounds.size.height - 60)
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: {self.imagetolove.bounds = bounds}, completion: nil )
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imagetolove.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    //MARK: Actions
    
    @IBAction func librarypressed(_ sender: UIButton) {
    imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        // Can we load in the file soundName?
        if let sound = NSDataAsset(name: soundName) {
            // check if sound.data is a sound file
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                // if sound.data is not a valid audio file
                print("ERROR: data in \(soundName) couldn't be played as a sound.")
            }
        } else {
            // if reading in the NSDataAsset didn't work, tell the user / report the error.
            print("ERROR: file \(soundName) didn't load")
        }
    }
    
    @IBAction func imagetapped(_ sender: UITapGestureRecognizer) {
        animateImage()
        playSound(soundName:"heartbeatsound", audioPlayer: &audioPlayer)
    }
    
    
}


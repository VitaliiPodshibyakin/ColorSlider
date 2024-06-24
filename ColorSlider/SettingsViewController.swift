//
//  ViewController.swift
//  ColorSlider
//
//  Created by Виталий Подшибякин on 07.06.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var viewToColor: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewToColor.layer.cornerRadius = 10
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        setColor()
        
    }
    

    @IBAction func rgbSlider(_ sender: UISlider) {
        
        setColor()
        
        switch sender {
        case redSlider:
            redLabel.text = setLabel(from: redSlider)
        case greenSlider:
            greenLabel.text =  setLabel(from: greenSlider)
        default:
            blueLabel.text =  setLabel(from: blueSlider)
        }
    }
    
    
    
    private func setColor () {
        viewToColor.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }

    private func setLabel (from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}


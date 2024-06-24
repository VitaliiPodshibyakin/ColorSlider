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
    
    @IBOutlet weak var redTF: UITextField!
    @IBOutlet weak var greenTF: UITextField!
    @IBOutlet weak var blueTF: UITextField!
    
    
    var delegate: SettingsViewControllerDelegate!
    var colorView: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewToColor.layer.cornerRadius = 10
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        setSlidersValue(from: colorView)
        setLabelsValue(for: redLabel, greenLabel, blueLabel)
        setTFsValue(for: redTF, greenTF, blueTF)
        
        viewToColor.backgroundColor = colorView

    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        
        setColor()
        
        switch sender {
        case redSlider:
            redLabel.text = setValue(from: redSlider)
            redTF.text = setValue(from: redSlider)
        case greenSlider:
            greenLabel.text =  setValue(from: greenSlider)
            greenTF.text = setValue(from: greenSlider)
        default:
            blueLabel.text =  setValue(from: blueSlider)
            blueTF.text = setValue(from: blueSlider)
        }
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setColor(for: viewToColor.backgroundColor ?? .black)
        dismiss(animated: true)
    }
}

// MARK: - Private Methods
extension SettingsViewController {
    
    private func setColor () {
        viewToColor.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }

    private func setValue (from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setSlidersValue (from viewColor: UIColor) {
        let ciColor = CIColor(color: viewColor)
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    private func setLabelsValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = setValue(from: redSlider)
            case greenLabel:
                greenLabel.text = setValue(from: greenSlider)
            default:
                blueLabel.text = setValue(from: blueSlider)
            }
        }
    }
    
    private func setTFsValue(for TFs: UITextField...) {
        TFs.forEach { TF in
            switch TF {
            case redTF:
                redTF.text = setValue(from: redSlider)
            case greenTF:
                greenTF.text = setValue(from: greenSlider)
            default:
                blueTF.text = setValue(from: blueSlider)
            }
        }
    }
    @objc private func didTapDone() {
        view.endEditing(true)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

}
// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            switch textField {
            case redTF:
                redSlider.setValue(currentValue, animated: true)
                setLabelsValue(for: redLabel)
            case greenTF:
                greenSlider.setValue(currentValue, animated: true)
                setLabelsValue(for: greenLabel)
            default:
                blueSlider.setValue(currentValue, animated: true)
                setLabelsValue(for: blueLabel)
            }
            
            setColor()
            return
        }
        
        showAlert(title: "Wrong format!", message: "Please enter correct value")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
}

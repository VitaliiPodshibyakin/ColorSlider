//
//  ColorViewController.swift
//  ColorSlider
//
//  Created by Виталий Подшибякин on 24.06.2024.
//

import UIKit

protocol SettingsViewControllerDelegate{
    func setColor(for view: UIColor)
}
                                            
                                            
class ColorViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.colorView = view.backgroundColor
    }

}

extension ColorViewController: SettingsViewControllerDelegate {
    func setColor(for viewBackgroundColor: UIColor) {
        view.backgroundColor = viewBackgroundColor
    }
}

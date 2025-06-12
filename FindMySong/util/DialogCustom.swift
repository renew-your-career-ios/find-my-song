//
//  DialogCustom.swift
//  FindMySong
//
//  Created by accenture.valves on 12/06/25.
//

import UIKit

extension UIViewController {
    func showConfirmationDialog(
        title: String,
        message: String,
        confirmTitle: String = "Sim",
        cancelTitle: String = "Não",
        onConfirm: @escaping () -> Void,
        onCancel: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            onConfirm()
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
            onCancel?()
        }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
}

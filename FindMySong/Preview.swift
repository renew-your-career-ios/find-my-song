//
//  Preview.swift
//  FindMySong
//
//  Created by accenture.valves on 09/06/25.
//


#if DEBUG
import SwiftUI

struct ViewControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        HomeViewController()
}

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Nada a atualizar por enquanto
    }
}

#Preview {
    ViewControllerPreview()
}
#endif

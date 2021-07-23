//
//  SearchNavigationView.swift
//  SwiftySeatGeek
//
//  Reference: https://yugantarjain.medium.com/implement-native-search-bar-in-swiftui-664a6b944538
//

import SwiftUI

struct SearchNavigationView<Content: View>: UIViewControllerRepresentable {
    @Binding var text: String
    
    var search: () -> Void
    var cancel: () -> Void
    var content: () -> Content

    func makeUIViewController(context: Context) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: context.coordinator.rootViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        context.coordinator.searchController.searchBar.delegate = context.coordinator
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        context.coordinator.update(content: content())
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(content: content(), searchText: $text, searchAction: search, cancelAction: cancel)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        let rootViewController: UIHostingController<Content>
        let searchController = UISearchController(searchResultsController: nil)
        var search: () -> Void
        var cancel: () -> Void
        
        init(content: Content, searchText: Binding<String>, searchAction: @escaping () -> Void, cancelAction: @escaping () -> Void) {
            rootViewController = UIHostingController(rootView: content)
            searchController.searchBar.autocapitalizationType = .none
            searchController.searchBar.barStyle = .black
            searchController.searchBar.isTranslucent = true
            searchController.obscuresBackgroundDuringPresentation = false
            
            let textField = searchController.searchBar.searchTextField
            textField.textColor = .white
            textField.backgroundColor = .black
            textField.tintColor = .white
            
            if let glassIconView = textField.leftView as? UIImageView {
                glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
                glassIconView.tintColor = .gray
            }
            
            if let clearButton = textField.value(forKey: "clearButton") as? UIButton {
                clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                clearButton.tintColor = .gray
            }
            
            rootViewController.navigationItem.searchController = searchController
            rootViewController.navigationItem.backButtonTitle = ""
            
            _text = searchText
            search = searchAction
            cancel = cancelAction
        }
        
        func update(content: Content) {
            rootViewController.rootView = content
            rootViewController.view.setNeedsDisplay()
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            search()
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            cancel()
        }
    }
}

//
//  ProductViewModel.swift
//  Shopping App
//
//  Created by Berkay YAY on 2.11.2022.
//

import Foundation
import Moya
import FakeUrlAPI


protocol ProductViewModelDelegate: AnyObject{
    func didErrorOccurred(_ error: Error)
    func didFetchProducts()
}

protocol ProductViewModelProtocol{
    var delegate: ProductViewModelDelegate? { get set}
    var numberOfRows: Int { get }
    func fetchProducts()
    func productForIndexPath(_ indexPath: IndexPath) -> Product?
    
}

final class ProductViewModel:ProductViewModelProtocol {
    
    
    var numberOfRows: Int = .zero
    
    weak var delegate: ProductViewModelDelegate?
    private var products = [Product]() {
        didSet{
            delegate?.didFetchProducts()
        }
    }
    
    func fetchProducts(){
        fakeStoreServiceProvider.request(.getProducts) { result in
            switch result {
            case .failure(let error):
                self.delegate?.didErrorOccurred(error)
            case .success(let response):
                do{
                    let products = try JSONDecoder().decode([Product].self, from:response.data)
                    self.products = products
                    self.numberOfRows = self.products.count
                } catch {
                    self.delegate?.didErrorOccurred(error)
                }
               
            }
        }
    }
    func productForIndexPath(_ indexPath: IndexPath) -> Product? {
        return products[indexPath.row]
    }
}


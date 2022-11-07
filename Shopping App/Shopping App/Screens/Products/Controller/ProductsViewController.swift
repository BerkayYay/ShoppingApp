//
//  ProductsViewController.swift
//  Shopping App
//
//  Created by Berkay YAY on 31.10.2022.
//

import UIKit
import FakeUrlAPI
import AlamofireImage

class ProductsViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet private weak var collectionView: UICollectionView!
    private var viewModel : ProductViewModelProtocol
    
    //MARK: - Init
    
    init(viewModel: ProductViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        
        
        let nibCell = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "cell")
    
        
        viewModel.delegate = self
        viewModel.fetchProducts()
    }
}

//MARK: - ProductViewModelDelegate
extension ProductsViewController: ProductViewModelDelegate{
    
    func didErrorOccurred(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchProducts() {
        print("PRODUCTS FETCHED!")
    }
    
    
}
extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCollectionViewCell
        guard let product = viewModel.productForIndexPath(indexPath) else{
            fatalError("fetch error")
        }
        cell .productRate.text = "\(product.rating?.rate)"
        cell.productPrice.text = "\(product.price)"
        cell.productTitle.text = "\(product.title)"
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

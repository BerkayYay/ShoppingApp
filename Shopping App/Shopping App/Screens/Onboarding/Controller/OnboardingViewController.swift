//
//  OnboardingViewController.swift
//  Shopping App
//
//  Created by Berkay YAY on 27.10.2022.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    private let pageWidth: CGFloat = UIScreen.main.bounds.width
    private let authView = AuthViewModel()
    private let authScreen = AuthViewController(viewModel: AuthViewModel())
    
    
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var prevButton: UIButton!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var skipButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var contentView: UIView!
    
    var currentPageNumber: Int = .zero {
        didSet {
            if currentPageNumber == onboardingViews.count - 1 {
                nextButton.setTitle("Done", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
            
            if currentPageNumber == .zero {
                prevButton.isHidden = true
            } else {
                prevButton.isHidden = false
            }
            
            pageControl.currentPage = currentPageNumber
            updateScrollViewContentOffset(with: currentPageNumber)
        }
    }
    
    var onboardingViews = [OnboardingView]() {
        didSet {
            let numberOfPages = onboardingViews.count
                    
            scrollView.contentSize.width = CGFloat(numberOfPages) * pageWidth
            
            pageControl.numberOfPages = numberOfPages
            
            guard let onboardingView = onboardingViews.last else {
                fatalError("OnboardingView not found.")
            }
            contentView.addSubview(onboardingView)
            onboardingView.translatesAutoresizingMaskIntoConstraints = false
            
            if onboardingViews.count == 1 {
                NSLayoutConstraint.activate([
                    onboardingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    onboardingView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    onboardingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                    onboardingView.widthAnchor.constraint(equalToConstant: pageWidth)
                ])
            } else {
                NSLayoutConstraint.activate([
                    onboardingView.leadingAnchor.constraint(equalTo: onboardingViews.first!.trailingAnchor),
                    onboardingView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    onboardingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                    onboardingView.widthAnchor.constraint(equalToConstant: pageWidth),
                    onboardingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                ])
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self

        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let firstOnboardingView = OnboardingView()
        firstOnboardingView.image = UIImage(named: "onboard1")
        firstOnboardingView.text = "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet."
        onboardingViews.append(firstOnboardingView)
        
        
        let secondOnboardingView = OnboardingView()
        secondOnboardingView.image = UIImage(named: "onboard2")
        secondOnboardingView.text = "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet."
        onboardingViews.append(secondOnboardingView)
    }
    
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        if currentPageNumber < onboardingViews.count - 1 {
                    currentPageNumber += 1
                } else {
                    goToAuth()
                }
    }
    
    @IBAction func didPageControlValueChanged(_ sender: UIPageControl) {
        updateScrollViewContentOffset(with: sender.currentPage)
    }
    @IBAction func didTapPrevButton(_ sender: UIButton) {
        if currentPageNumber > 0 {
                   currentPageNumber -= 1
               }
    }
    @IBAction func didTapSkipButton(_ sender: UIButton) {
        goToAuth()
        
    }
    private func updateScrollViewContentOffset(with pageNumber: Int) {
        let contentOffset = CGPoint(x: pageWidth * CGFloat(pageNumber), y: .zero)
        scrollView.setContentOffset(contentOffset, animated: true)
    }

    private func goToAuth() {
        navigationController?.pushViewController(authScreen, animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / pageWidth)
        currentPageNumber = currentPage
    }
}


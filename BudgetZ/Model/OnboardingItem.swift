//
//  OnboardingItem.swift
//  BudgetZ
//
//  Created by Arunkumar Chandrasekar on 19/01/23.
//

import Foundation
import Lottie

struct OnBoardingItem: Identifiable, Equatable {
    var id: UUID = .init()
    var title: String
    var subTitle: String
    var lottieView: LottieAnimationView = .init()
}


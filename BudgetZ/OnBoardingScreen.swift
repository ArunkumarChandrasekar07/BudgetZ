//
//  OnBoardingScreen.swift
//  BudgetZ
//
//  Created by Arunkumar Chandrasekar on 19/01/23.
//

import SwiftUI
import Lottie
import SwiftUINavigation

struct OnBoardingScreen: View {
    
    @State var destination: Destination?
    
    @State var onboardingItems: [OnBoardingItem] = [
        .init(title: "All your accounts.\nAll in one place.", subTitle: "See it all at a glance when you link your cash accounts, credit cards, investments, and bills.", lottieView: .init(name: "Investment")),
        
            .init(title: "Keep your cashflow\ncrystal clear", subTitle: "Effortlessly track your cashflow and gain insights that’ll help you see easy opportunities to save.", lottieView: .init(name: "Finance")),
        
            .init(title: "Bill Negotiation", subTitle: "Join the other Minters who’ve already racked up a combined $2M+ in savings.2", lottieView: .init(name: "Tracking"))
    ]
    
    @State var currentIndex: Int = 0
    
    var body: some View {
        NavigationStack {
            GeometryReader {
                let size = $0.size
                HStack(spacing: 0) {
                    ForEach($onboardingItems) { $item in
                        let isLastSlide = currentIndex == onboardingItems.count - 1
                        VStack {
                            HStack {
                                Button {
                                    if currentIndex > 0 {
                                        currentIndex -= 1
                                        playAnimation()
                                    }
                                } label: {
                                    Text("Back")
                                        .opacity(currentIndex > 0 ? 1 : 0)
                                        .animation(.easeInOut, value: currentIndex)
                                }
                                
                                Spacer(minLength: 0)
                                
                                Button {
                                    if currentIndex < onboardingItems.count - 1 {
                                        currentIndex = onboardingItems.count - 1
                                        playAnimation()
                                    }
                                } label: {
                                    Text("Skip")
                                        .opacity(isLastSlide ? 0 : 1)
                                        .animation(.easeInOut, value: currentIndex)
                                }
                            }
                            .font(.customAppFont(type: .bold, size: 18))
                            .foregroundColor(.white)
                            
                            let offset = -CGFloat(currentIndex) * size.width
                            
                            ResizableLottieView(onboardingItem: $item)
                                .frame(height: size.width)
                                .onAppear {
                                    if currentIndex == getIndex(of: item) {
                                        item.lottieView.play(toProgress: 0.8)
                                    }
                                }
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5), value: currentIndex)
                            
                            VStack(spacing: 15) {
                                Text(item.title)
                                    .font(.customAppFont(type: .extrabold, size: 25))
                                    .multilineTextAlignment(.center)
                                    .offset(x: offset)
                                    .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
                                
                                Text(item.subTitle)
                                    .font(.customAppFont(type: .medium, size: 20))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.gray)
                                    .offset(x: offset)
                                    .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
                            }
                            
                            Spacer(minLength: 0)
                            
                            VStack {
                                Text(isLastSlide ? "Explore" : "Next")
                                    .font(.customAppFont(type: .bold, size: 23))
                                    .foregroundColor(.black)
                                    .padding(.vertical, 15)
                                    .frame(maxWidth: .infinity)
                                    .background {
                                        Capsule()
                                            .fill(.white)
                                    }
                                    .padding(.horizontal, isLastSlide ? 30 : 100)
                                    .onTapGesture {
                                        if currentIndex < onboardingItems.count - 1 {
                                            onboardingItems[currentIndex].lottieView.pause()
                                            currentIndex += 1
                                            playAnimation()
                                        }
                                        
                                        if isLastSlide {
                                            self.destination = .initial
                                        }
                                    }
                                    .navigationDestination(unwrapping: $destination, case: /Destination.initial) { _ in
                                        InitialScreen()
                                            .navigationBarBackButtonHidden()
                                            .navigationBarTitleDisplayMode(.inline)
                                    }
                                HStack {
                                    Text("Terms of Service")
                                    
                                    Text("Privacy Policy")
                                }
                                .font(.customAppFont(type: .regular, size: 18))
                                .foregroundColor(.white)
                                .underline(true, color: .white)
                                .offset(y: 5)
                            }
                        }
                        .animation(.easeInOut, value: currentIndex)
                        .padding(15)
                        .frame(width: size.width, height: size.height)
                    }
                }
                .frame(width: size.width * CGFloat(onboardingItems.count), alignment: .leading)
            }
        }
    }
    
    private func playAnimation() {
        onboardingItems[currentIndex].lottieView.currentProgress = 0
        onboardingItems[currentIndex].lottieView.play(toProgress: 0.8)
    }
    
    private func getIndex(of item: OnBoardingItem) -> Int {
        if let index = onboardingItems.firstIndex(of: item) {
            return index
        }
        return 0
    }
}

struct OnBoardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingScreen()
    }
}


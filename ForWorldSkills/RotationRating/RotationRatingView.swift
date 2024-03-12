//
//  RotationRatingView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 03.02.2024.
//

import SwiftUI
import CoreMotion

final class MotionMonitor {
    static let instance = MotionMonitor()
    
    @Published var angle: Double = 0
    
    private let motionManager = CMMotionManager()
    
    init() {
        motionManager.deviceMotionUpdateInterval = 0.5
        motionManager.startDeviceMotionUpdates(to: .main) { motion, error in
            guard let motion else { return }
            
            let angle = motion.attitude.roll
            
            DispatchQueue.main.async {
                self.angle = angle / 180 * .pi
            }
        }
    }
}

struct RotationRatingView: View {
    
    @State private var angle: Double = 0
    @State private var star: Int = 0
    
    @State private var can: Bool = false
    
    var body: some View {
        VStack {
            Text("\(angle)")
            HStack {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: "star.fill")
                        .foregroundStyle(Color.gray)
                        .font(.title)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                self.star = index
                            }
                        }
                }
            }
            .overlay {
                GeometryReader { geo in
                    Rectangle()
                        .fill(Color.yellow)
                        .frame(width: geo.size.width / 5 * CGFloat(star))
                        .allowsHitTesting(false)
                }
                .mask {
                    HStack {
                        ForEach(1...5, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundStyle(Color.gray)
                                .font(.title)
                        }
                    }
                }
            }
        }
        .onReceive(MotionMonitor.instance.$angle, perform: { value in
            self.angle = value
            
            if value > 60 && can && star < 5 {
                star += 1
                can = false
            }
            
            if value < -60 && can && star > 0 {
                star -= 1
                can = false
            }
            
            if !can && value < 60 && value > -60 {
                can = true
            }
        })
    }
}

#Preview {
    RotationRatingView()
}

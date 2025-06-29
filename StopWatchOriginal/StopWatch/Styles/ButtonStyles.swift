//
//  ButtonStyles.swift
//  StopWatch
//
//  Created by 落合遼梧 on 2025/06/29.
//

import SwiftUI

public struct GradientCircleButtonStyle: ButtonStyle {
  public let gradient: LinearGradient
  public let size: CGFloat
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.system(size: size * 0.5))
      .foregroundColor(.white)
      .frame(width: size, height: size)
      .background(
        gradient.opacity(configuration.isPressed ? 0.8 : 1)
      )
      .clipShape(Circle())
      .shadow(
        color: .black.opacity(0.3),
        radius: configuration.isPressed ? 2 : 6,
        x: 0, y: configuration.isPressed ? 1 : 4
      )
      .scaleEffect(configuration.isPressed ? 0.95 : 1)
      .animation(
        .spring(response: 0.3, dampingFraction: 0.6),
        value: configuration.isPressed
      )
  }
}

public struct CapsuleButtonStyle: ButtonStyle {
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.system(size: 18, weight: .medium, design: .rounded))
      .foregroundColor(.white)
      .padding(.vertical, 12)
      .padding(.horizontal, 24)
      .background(
        LinearGradient(
          colors: [Color.orange, Color.yellow],
          startPoint: .leading, endPoint: .trailing
        )
        .opacity(configuration.isPressed ? 0.8 : 1)
      )
      .clipShape(Capsule())
      .shadow(
        color: .black.opacity(0.2),
        radius: configuration.isPressed ? 1 : 4,
        x: 0, y: configuration.isPressed ? 1 : 3
      )
      .scaleEffect(configuration.isPressed ? 0.98 : 1)
      .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
  }
}

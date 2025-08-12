import SwiftUI
import VisionUI

@available(visionOS 1.0, *)
struct GestureInteractionsExample: View {
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Angle = .zero
    @State private var offset: CGSize = .zero

    var body: some View {
        Circle()
            .fill(.blue)
            .frame(width: 200 * scale, height: 200 * scale)
            .rotationEffect(rotation)
            .offset(offset)
            .gesture(MagnificationGesture().onChanged { value in
                scale = max(0.5, min(2.0, value))
            })
            .gesture(RotationGesture().onChanged { value in
                rotation = value
            })
            .gesture(DragGesture().onChanged { value in
                offset = value.translation
            })
            .padding(40)
    }
}

#Preview(available: visionOS 1.0) {
    GestureInteractionsExample()
}


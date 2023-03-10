//
//  NoobView.swift
//  NoobLight
//
//  Created by Abhishek Agarwal on 10/03/23.
//

import SwiftUI


//MARK: - NoobViewShape
public enum NoobViewShape {
    case rounded
    case circle
    case rectangle
}


//MARK: - NoobViewProperties
public struct NoobViewProperties {
    public let shape: NoobViewShape
    public let radius: CGFloat
    public let anchor: Anchor<CGRect>
    public let content: AnyView
}


//MARK: - ViewBoundsPref
struct ViewBoundsPref: PreferenceKey {
    static var defaultValue: [Int : NoobViewProperties] = [:]
    
    static func reduce(value: inout [Int : NoobViewProperties], nextValue: () -> [Int : NoobViewProperties]) {
        value.merge(nextValue()) {$1}
    }
}


//MARK: - Public Functions
extension View {
    
    @ViewBuilder
    public func addNoobLightWith<V: View>(_ id: Int, lightShape: NoobViewShape = .rectangle, radius: CGFloat = .zero, @ViewBuilder content: @escaping (Anchor<CGRect>) -> V ) -> some View {
        self
            .anchorPreference(key: ViewBoundsPref.self, value: .bounds) { anchor in
                return [id: NoobViewProperties(shape: lightShape,
                                               radius: radius,
                                               anchor: anchor,
                                               content: AnyView(content(anchor)))]
            }
    }
    
    @ViewBuilder
    public func addNoobLight(showing: Binding<Bool>, currentShowing: Binding<Int>) -> some View {
        self.addNoobOverlay(show: showing, currentShowing: currentShowing) {
            if #available(iOS 15, *) {
                Rectangle()
                    .fill(.ultraThinMaterial)
            } else {
                Rectangle()
                    .fill(Color.black.opacity(0.4))
            }
        }
    }
    
    @ViewBuilder
    public func addNoobLight<V: View>(showing: Binding<Bool>, currentShowing: Binding<Int>, @ViewBuilder content: @escaping () -> V ) -> some View  {
        self
            .addNoobOverlay(show: showing, currentShowing: currentShowing, content: content)
    }
}


//MARK: - Private Functions
extension View {
    
    @ViewBuilder
    private func addNoobOverlay<V: View>(show: Binding<Bool>, currentShowing: Binding<Int>,  @ViewBuilder content: @escaping () -> V) -> some View {
        self
            .overlayPreferenceValue(ViewBoundsPref.self) { value in
                GeometryReader { proxy in
                    
                    if let pref = value.first(where: {
                        $0.key == currentShowing.wrappedValue
                    }) {
                        let rect = proxy[pref.value.anchor]
                        
                        content()
                            .mask(
                                Rectangle()
                                    .overlay(
                                        NoobMaskView(prop: pref.value, rect: rect),
                                        alignment: .topLeading)
                            )
                            .overlay(pref.value.content, alignment: .topLeading)
                            .onTapGesture {
                                if currentShowing.wrappedValue < value.values.count - 1 {
                                    currentShowing.wrappedValue += 1
                                } else {
                                    show.wrappedValue = false
                                }
                            }
                            .opacity(show.wrappedValue ? 1 : 0)
                    }
                    
                }
                .edgesIgnoringSafeArea(.all)
                .animation(.easeInOut, value: show.wrappedValue)
                .animation(.easeInOut, value: currentShowing.wrappedValue)
            }
    }
    
    private func NoobMaskView(prop: NoobViewProperties, rect: CGRect) -> some View {
        let radius = prop.shape == .circle ? rect.width/2 : (prop.shape == .rectangle ? 0 : prop.radius)
        
        return RoundedRectangle(cornerRadius: radius)
            .offset(x: rect.minX, y: rect.minY)
            .frame(width: rect.width, height: rect.height)
            .blendMode(.destinationOut)
    }
}

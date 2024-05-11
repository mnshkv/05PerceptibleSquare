import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.white, .pink, .yellow, .black]
    @State var lastPostion: CGSize = .init(width: 0, height: 0)
    @State var position: CGSize = .init(width: 0, height: 0)
    
    var body: some View {
        GeometryReader { rootGeo in 
            VStack(spacing: .zero) {
                ForEach(0..<4) { index in
                    GeometryReader { geo in 
                        VStack {
                            Rectangle()
                                .fill(index.isMultiple(of: 2) ? .black : .white)
                                .frame(width: 100, height: 100)
                                .position(x: lastPostion.width + position.width + geo.frame(in: .global).minX, y: lastPostion.height + position.height - geo.frame(in: .global).minY)
                                .gesture(DragGesture(minimumDistance: 0).onChanged({ value in
                                    print(value.translation)
                                    position = value.translation
                                }).onEnded({ end in
                                    position = .zero
                                    lastPostion.width += end.translation.width
                                    lastPostion.height += end.translation.height
                                }))
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                        .background(colors[index])
                        .clipped()
                    }
                }
            }
            .onAppear(perform: {
                lastPostion = .init(width: rootGeo.size.width / 2, height: (rootGeo.size.height  ) / 2) 
            })
        }
    }
}

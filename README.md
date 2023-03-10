
# NoobLight - Lightweight Coach Marks for SwiftUI

NoobLight is a Swift library for adding coach marks to your SwiftUI app. With NoobLight, you can easily create custom shapes and styles for your coach marks and customize the contents to fit your app's design.

NoobLight is highly customizable and lightweight, with a minimum supported iOS version of iOS 13. It's perfect for developers who want to add coach marks to their SwiftUI app without adding a lot of extra weight or complexity.




## Features

- Customizable shapes: choose from rounded, circle, or rectangle shapes for your coach marks
- Customizable content: add any SwiftUI view as the content for your coach marks
- Lightweight: NoobLight is small and fast, with a minimum supported iOS version of iOS 13



## Installation

To use NoobLight in your project, simply add it as a dependency in your Swift Package Manager manifest:

```swift
  dependencies: [
    .package(url: "https://github.com/ABHI165/NoobLight.git", from: "1.0.0")
]
```
    
## Usage

To use NoobLight in your app, follow these steps:

1. Import NoobLight in your view file:
```swift
import NoobLight
```

2. Use the addNoobLightWith modifier to add a coach mark to a view:
```swift
.addNoobLightWith(id: 1, lightShape: .rounded, radius: 10) { anchor in
    RoundedRectangle(cornerRadius: 20)
        .foregroundColor(.red)
}
```
- id: An integer to identify the coach mark.
- lightShape: A NoobViewShape value that determines the shape of the coach mark (.rounded, .circle, or .rectangle).
- radius: A CGFloat value that determines the corner radius of the coach mark (only applicable if lightShape is .rounded or .rectangle).
- content: A closure that takes an Anchor<CGRect> and returns a View to be used as the coach mark.

3. Use the addNoobLight modifier to show the coach marks:
```swift
.addNoobLight(showing: $showCoachMarks, currentShowing: $currentCoachMark)
```

- showing: A binding that controls whether the coach marks should be shown.
- currentShowing: A binding to the current coach mark being shown.

4. Optionally, you can use the addNoobLight modifier with a closure to provide a custom view for the background:
```swift
.addNoobLight(showing: $showCoachMarks, currentShowing: $currentCoachMark) {
     ZStack(alignment: .center) {
                Rectangle()
                    .fill(Color.black.opacity(0.4))
                
                Button("Skip") {
                    shoew = false
                }
            }
}
```



## License
NoobLight is available under the MIT license. See the LICENSE file for more info.

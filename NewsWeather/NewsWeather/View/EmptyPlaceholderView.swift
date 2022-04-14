
import SwiftUI

struct EmptyPlaceholderView: View {
    let text:String
    let image: Image?
    var body: some View {
        VStack(spacing:8){
            Spacer()
            if let image = image{
                image
                    .imageScale(.large)
                    .font(.system(size: 52))
            }
            Text(text)
            Spacer()
        }
    }
}


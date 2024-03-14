import SwiftUI

struct ContentView: View {
        
        @ObservedObject var identifier = SentimentIdentifier()
        @State private var input = ""
        @State private var bounce = false
        
        var body: some View {

            VStack(alignment: .center, spacing: 40) {
                Spacer()
                    Text(self.identifier.prediction == "0" ? "😠" : "☺️")
                        .font(.system(size: 120))
                        .scaleEffect(bounce ? 1.5 : 1.0)
                    
                TextField("What are you thinking?", text: $input, onEditingChanged: { changed in
                    bounce = false
                }, onCommit: {
                    self.identifier.predict(input)
                    withAnimation(.default) {
                        self.bounce.toggle()
                    }
                })
                .font(.title)
                .multilineTextAlignment(.center)
                
                Spacer()
            }
        }
}

#Preview {
    ContentView()
}

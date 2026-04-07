import SwiftUI

struct EntryCard: View {
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "sun.max.fill")
                .foregroundColor(.yellow)
            
            Text(text)
                .font(.system(size: 16, weight: .medium))
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.15))
        )
        .shadow(color: .black.opacity(0.2), radius: 6)
    }
}

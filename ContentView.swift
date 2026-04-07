import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var savedItems: [String] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                LinearGradient(
                    colors: [
                        Color(red: 0.15, green: 0.35, blue: 0.95),
                        Color(red: 0.55, green: 0.25, blue: 0.95),
                        Color.black.opacity(0.2)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    // Title
                    Text("Daily Focus")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.top, 40)

                    
                    // Input Field
                    TextField("Enter today's focus...", text: $inputText)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    
                    // Save Button
                    Button(action: saveItem) {
                            Text("Save")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.blue)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    
                    // List of Entries
                    if savedItems.isEmpty {
                        Text("No focus yet.\nStart your day with intention.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.7))
                            .padding()
                    } else {
                        List {
                            ForEach(savedItems, id: \.self) { item in
                                EntryCard(text: item)
                                    .scaleEffect(1.0)
                                    .animation(.easeInOut, value: savedItems)
                                    .listRowBackground(Color.clear)
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            if let index = savedItems.firstIndex(of: item) {
                                                deleteItem(at: IndexSet(integer: index))
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .onAppear(perform: loadItems)
        }
    }
    
    // Save Function (Persistent Data)
    func saveItem() {
        guard !inputText.isEmpty else { return }
        
        withAnimation {
            savedItems.append(inputText)
        }
        
        inputText = ""
        UserDefaults.standard.set(savedItems, forKey: "SavedItems")
    }
    
    // Load Saved Data
    func loadItems() {
        if let items = UserDefaults.standard.stringArray(forKey: "SavedItems") {
            savedItems = items
        }
    }
    
    // Delete Item
    func deleteItem(at offsets: IndexSet) {
        savedItems.remove(atOffsets: offsets)
        UserDefaults.standard.set(savedItems, forKey: "SavedItems")
    }
}

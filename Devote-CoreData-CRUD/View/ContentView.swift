//
//  ContentView.swift
//  Devote-CoreData-CRUD
//
//  Created by Drashti on 19/12/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - Properties
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State var task: String = ""
    @State private var showNewTaskItem: Bool = false
    
    
    // MARK: - FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // MARK: - Functions
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                
                // MARK: - MainView
                VStack {
                    // MARK: - Header
                    
                    HStack(spacing: 10){
                        // Title
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        // EditButton
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(width: 70, height: 24)
                            .background(
                                Capsule()
                                    .stroke(Color.white, lineWidth: 2)
                                    
                            )
                        // Appearance Button
                        Button(action: {
                            // TOGGLE APPEARANCE
                            isDarkMode.toggle()
                            playSound(sound: "sound-tap", type: "mp3")
                            feedback.notificationOccurred(.success)
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        })
                        
                    }//:HStack
                    .padding()
                    .foregroundStyle(.white)
                    
                    Spacer(minLength: 80)
                    // MARK: - NewTaskButton
                    Button(action: {
                        showNewTaskItem = true
                        playSound(sound: "sound-ding", type: "mp3")
                        feedback.notificationOccurred(.success)
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        
                        Text("New Task")
                            .font(.system(size: 24, weight: .semibold, design: .rounded))
                    })
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
                            .clipShape(Capsule())
                    )
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8)
                    // MARK: - Tasks
                    List {
                        ForEach(items) { item in
                            ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    }//: List
                    .scrollContentBackground(.hidden) // this code used to remove background from list
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(idealWidth: 640)
                }//: Vstack
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: 0.5)
                // MARK: - NewTaskItem
                if showNewTaskItem{
                    BlankView(backgroundColor: isDarkMode ? Color.black : Color.gray, backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                        .onTapGesture {
                            withAnimation {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            }//: Zstack
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = UIColor.clear
                UITableViewCell.appearance().backgroundColor = UIColor.clear
            })
            .navigationTitle("Daily Tasks")
            .toolbar(.hidden)
            .navigationBarTitleDisplayMode(.large)
            /*.toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                /*ToolbarItem(placement: .topBarTrailing) {
                 Button(action: addItem) {
                 Label("Add Item", systemImage: "plus")
                 }
                 }*/
            }//: Toolbar*/
            .background(
                BackgroundImageView()
                    .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: 0.5)
            )
            .background(backgroundGradient.ignoresSafeArea(.all))
        }//: navigation
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

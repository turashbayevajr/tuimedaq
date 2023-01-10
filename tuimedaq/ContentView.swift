import SwiftUI
import AVKit

var notifications=["Everything will be ok",
                               "You can do it!",
                               "You are best!",
"You are a hard worker and deserve all the success in life"]
struct HomeView: View{
    @State private var showDetails = false
    @State var textValue: String = (notifications.randomElement() ?? " ")

    var body: some View{
        NavigationView{
            VStack{
                Label(textValue, systemImage: "heart")
            }
            
            .navigationTitle("Home")
           
        }
    }
}
var counter = 0
class SoundManager{
    static let instanse = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playSound(){
        guard let url = Bundle.main.url(forResource: "emergency-sound", withExtension: ".mp3") else {return}
        if player?.isPlaying == true{
            player?.stop()
            counter = 0
        }
        else{
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch let error{
                print("Error playing sound. \(error.localizedDescription)")
            }
        }
    }
}

struct HelpView: View{
    @State var textl: String = ("Double tap to activate sos button")
    
    var body: some View{
        NavigationView{
            VStack{
                Button("Play sound") {
                    if(counter==2){
                        SoundManager.instanse.playSound()
                    }
                }
                Label(textl, systemImage: "music.note")
                    .frame(height: 190)
                    .onTapGesture(count: 2){
                    counter = 2
                }
                
                .navigationTitle("Help")
            }
        }
    }
    
}
struct ChecklistItem: Identifiable {
  let id = UUID()
  var name: String
  var isChecked: Bool = false
}

struct ExerciseView: View{
    @State var checklistItems = [
        ChecklistItem(name: "Walk the dog"),
        ChecklistItem(name: "Brush my teeth"),
        ChecklistItem(name: "Learn iOS development"),
        ChecklistItem(name: "Soccer practice"),
        ChecklistItem(name: "Eat ice cream"),
    ]
    
//    func deleteListItem(whichElement: IndexSet) {
//        checklistItems.remove(atOffsets: whichElement)
//    }
    
    func moveListItem(whichElement: IndexSet, destination: Int) {
        checklistItems.move(fromOffsets: whichElement, toOffset: destination)
    }
    var body: some View{
        NavigationView {
            List {
                ForEach(checklistItems) { checklistItem in
                    HStack {
                        Text(checklistItem.name)
                        Spacer()
                        Text(checklistItem.isChecked ? "✅" : "🔲")
                    }
                    .background(Color.white) // This makes the entire row clickable
                    .onTapGesture {
                        if let matchingIndex =
                            self.checklistItems.firstIndex(where: { $0.id == checklistItem.id }) {
                            self.checklistItems[matchingIndex].isChecked.toggle()
                        }
                        
                    }
                }
//                .onDelete(perform: deleteListItem)
                .onMove(perform: moveListItem)
            }
            .navigationBarItems(trailing: EditButton())
            
            .navigationTitle("Exercises")
        }
    }
    
}
struct NewsView: View{
    
    var body: some View{
        NavigationView{
            VStack{
       
                }
                .navigationTitle("News")
            }
        }
    }
    

    
    struct ContentView: View {
        var body: some View {
            TabView{
                HomeView()
                    .tabItem{
                        Text("Home")
                        Image(systemName: "house")
                    }
                
                HelpView()
                    .tabItem{
                        Image(systemName: "heart")
                        Text("Help")
                    }
                ExerciseView()
                    .tabItem{
                        Image(systemName: "checkmark.rectangle")
                        Text("Exercise")
                    }
                NewsView()
                    .tabItem{
                        Image(systemName: "newspaper")
                        Text("News")
                    }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }


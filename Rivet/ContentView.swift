import SwiftUI

enum SkyBluePalette: String, CaseIterable {
    case SkyGlow
    case SummerSky
    case ClearWater
    case CoastalTeal
    
    var color: Color {
        switch self {
        case .SkyGlow:
            return Color(red: 188/255, green: 230/255, blue: 255/255)
        case .SummerSky:
            return Color(red: 124/255, green: 208/255, blue: 255/255)
        case .ClearWater:
            return Color(red: 66/255,  green: 178/255, blue: 236/255)
        case .CoastalTeal:
            return Color(red: 26/255,  green: 149/255, blue: 205/255)
        }
    }
}
enum MidnightNavyPalette: String, CaseIterable {
    case AbyssalBlack
    case MidnightNavy
    case DeepMariner
    case GlowingCobalt
    
    var color: Color {
        switch self {
        case .AbyssalBlack:
            return Color(red: 3/255, green: 11/255, blue: 30/255)
        case .MidnightNavy:
            return Color(red: 13/255, green: 31/255, blue: 77/255)
        case .DeepMariner:
            return Color(red: 26/255, green: 53/255, blue: 124/255)
        case .GlowingCobalt:
            return Color(red: 44/255, green: 82/255, blue: 178/255)
        }
    }
}
enum IceWhitePalette: String, CaseIterable {
    case PureSnow
    case GlacierFrost
    case PowderIce
    case ArcticBreeze
    
    var color: Color {
        switch self {
        case .PureSnow:
            return Color(red: 255/255, green: 255/255, blue: 255/255)
        case .GlacierFrost:
            return Color(red: 244/255, green: 249/255, blue: 252/255)
        case .PowderIce:
            return Color(red: 227/255, green: 239/255, blue: 245/255)
        case .ArcticBreeze:
            return Color(red: 197/255, green: 220/255, blue: 232/255)
        }
    }
}
enum OceanBluePalette: String, CaseIterable {
    case DeepNavy
    case OceanBlue
    case ScubaCyan
    case Seafoam
    
    var color: Color {
        switch self {
        case .DeepNavy:
            return Color(red: 11/255, green: 45/255, blue: 114/255)
        case .OceanBlue:
            return Color(red: 9/255, green: 146/255, blue: 194/255)
        case .ScubaCyan:
            return Color(red: 10/255, green: 196/255, blue: 224/255)
        case .Seafoam:
            return Color(red: 235/255, green: 244/255, blue: 246/255)
        }
    }
}

// tasks saved on the phone w appstorage
// each task is name:::description, tasks joined w |||
func getTasks(_ raw: String) -> [String] {
    if raw == "" {
        return []
    }
    return raw.components(separatedBy: "|||")
}

func makeTasksRaw(_ list: [String]) -> String {
    list.joined(separator: "|||")
}

func getTaskName(_ packed: String) -> String {
    let parts = packed.components(separatedBy: ":::")
    if parts.count >= 1 {
        return parts[0]
    }
    return packed
}

func getTaskDescription(_ packed: String) -> String {
    let parts = packed.components(separatedBy: ":::")
    if parts.count >= 2 {
        return parts[1]
    }
    // old tasks that were just one string
    return packed
}

func makePackedTask(_ name: String, _ description: String) -> String {
    name + ":::" + description
}

// which tasks have the X — indexes as strings
func getDoneIndexes(_ raw: String) -> [Int] {
    if raw == "" {
        return []
    }
    var result: [Int] = []
    for part in raw.components(separatedBy: "|||") {
        if let n = Int(part) {
            result.append(n)
        }
    }
    return result
}

func makeDoneRaw(_ list: [Int]) -> String {
    var parts: [String] = []
    for n in list {
        parts.append(String(n))
    }
    return parts.joined(separator: "|||")
}

let startingTasks = "Finish design brief:::Review feedback and ship the brief|||Reply to team messages:::Catch up on Slack and email|||15-min walk outside:::Take a short walk to reset|||Review feedback notes:::Go through notes from design review|||Draft revised homepage:::Update the homepage layout|||Send to Jordan for review:::Send the latest draft over"

struct ContentView: View {
    static let Background1 = LinearGradient(colors: [OceanBluePalette.DeepNavy.color,OceanBluePalette.OceanBlue.color, OceanBluePalette.ScubaCyan.color, OceanBluePalette.Seafoam.color], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let Background2 = LinearGradient(colors: [IceWhitePalette.PureSnow.color,IceWhitePalette.GlacierFrost.color, IceWhitePalette.PowderIce.color, IceWhitePalette.ArcticBreeze.color], startPoint: .topTrailing, endPoint: .bottomLeading)
    static let Background3 = LinearGradient(colors: [MidnightNavyPalette.AbyssalBlack.color,MidnightNavyPalette.MidnightNavy.color, MidnightNavyPalette.DeepMariner.color, MidnightNavyPalette.GlowingCobalt.color], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let Background4 = LinearGradient(colors: [SkyBluePalette.SkyGlow.color,SkyBluePalette.SummerSky.color, SkyBluePalette.ClearWater.color, SkyBluePalette.CoastalTeal.color], startPoint: .topTrailing, endPoint: .bottomLeading)
    // which tab is open
    @AppStorage("tab") var tab = 0
    var body: some View {
        // bottom 3 things are real tabs now
        TabView(selection: $tab) {
            NavigationStack {
                Dashboard()
            }
            .tabItem {
                Text("Dashboard")
                Text("icon")
            }
            .tag(0)
            
            NavigationStack {
                TasksPage()
            }
            .tabItem {
                Text("Tasks")
                Text("icon")
            }
            .tag(1)
            
            NavigationStack {
                SettingsPage()
            }
            .tabItem {
                Text("Settings")
                Text("icon")
            }
            .tag(2)
        }
        .background(ContentView.Background3)
        
    }
}

#Preview {
    ContentView()
}

// settings tab for now
struct SettingsPage: View {
    // which look mode they picked
    @AppStorage("lookMode") var lookMode = "full colors"
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Settings")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                .padding(.top, 40)
            
            Spacer()
            
            // just the word simplify
            Button {
                lookMode = "simplify"
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 55)
                        .foregroundStyle(lookMode == "simplify" ? MidnightNavyPalette.MidnightNavy.color : IceWhitePalette.PureSnow.color)
                    Text("simplify")
                        .font(.headline)
                        .foregroundStyle(lookMode == "simplify" ? IceWhitePalette.PureSnow.color : MidnightNavyPalette.MidnightNavy.color)
                }
            }
            .padding(.horizontal, 25)
            
            Button {
                lookMode = "increased contrast"
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 55)
                        .foregroundStyle(lookMode == "increased contrast" ? MidnightNavyPalette.MidnightNavy.color : IceWhitePalette.PureSnow.color)
                    Text("increased contrast")
                        .font(.headline)
                        .foregroundStyle(lookMode == "increased contrast" ? IceWhitePalette.PureSnow.color : MidnightNavyPalette.MidnightNavy.color)
                }
            }
            .padding(.horizontal, 25)
            
            Button {
                lookMode = "full colors"
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 55)
                        .foregroundStyle(lookMode == "full colors" ? MidnightNavyPalette.MidnightNavy.color : IceWhitePalette.PureSnow.color)
                    Text("full colors")
                        .font(.headline)
                        .foregroundStyle(lookMode == "full colors" ? IceWhitePalette.PureSnow.color : MidnightNavyPalette.MidnightNavy.color)
                }
            }
            .padding(.horizontal, 25)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ContentView.Background2)
    }
}

// little app box
struct AppUsageCard: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 80, height: 100)
                .foregroundStyle(IceWhitePalette.PureSnow.color)
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 30, height: 30)
                    .foregroundStyle(ContentView.Background3)
                Text("Instagram")
                    .font(.caption2)
                    .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                // screentime number later
                Text("placeholder")
                    .font(.caption2)
                    .foregroundStyle(.red)
            }
        }
    }
}

// one task row u can check and also tap
struct TaskRow: View {
    var index: Int
    @AppStorage("tasks") var tasksRaw = startingTasks
    @AppStorage("doneIndexes") var doneRaw = ""
    
    var body: some View {
        let tasks = getTasks(tasksRaw)
        let dones = getDoneIndexes(doneRaw)
        let isChecked = dones.contains(index)
        
        HStack(alignment: .top) {
            // check circle
            Button {
                var newDones = dones
                if isChecked {
                    newDones.removeAll { $0 == index }
                } else {
                    newDones.append(index)
                }
                doneRaw = makeDoneRaw(newDones)
            } label: {
                ZStack {
                    Circle()
                        .stroke(OceanBluePalette.OceanBlue.color, lineWidth: 2)
                        .frame(width: 18, height: 18)
                    if isChecked {
                        Text("X")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(OceanBluePalette.OceanBlue.color)
                    }
                }
            }
            .padding(.top, 2)
            
            // tap text goes to detail — name + description under it
            if index < tasks.count {
                NavigationLink(destination: TaskDetailPage(index: index)) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(getTaskName(tasks[index]))
                            .font(.headline)
                            .foregroundStyle(isChecked ? .gray : MidnightNavyPalette.MidnightNavy.color)
                            .lineLimit(1)
                        // full description under the name
                        Text(getTaskDescription(tasks[index]))
                            .font(.caption)
                            .foregroundStyle(isChecked ? .gray : MidnightNavyPalette.DeepMariner.color)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(IceWhitePalette.PureSnow.color)
        )
        .padding(.horizontal, 20)
        .padding(.vertical, 4)
    }
}

struct Dashboard: View {
    @AppStorage("tasks") var tasksRaw = startingTasks
    @AppStorage("lookMode") var lookMode = "full colors"
    
    var isSimplify: Bool {
        lookMode == "simplify"
    }
    
    var isContrast: Bool {
        lookMode == "increased contrast"
    }
    
    var body: some View {
        let tasks = getTasks(tasksRaw)
        VStack(spacing: 0) {
            // top dark header
            ZStack(alignment: .top) {
                if isContrast {
                    RoundedRectangle(cornerRadius: 60)
                        .foregroundStyle(MidnightNavyPalette.AbyssalBlack.color)
                } else {
                    RoundedRectangle(cornerRadius: 60)
                        .foregroundStyle(ContentView.Background3)
                }
                VStack {
                    if isSimplify {
                        // only big Dashboard + start focus
                        Text("Dashboard")
                            .font(.system(size: 56, weight: .bold))
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                            .padding(.top, 60)
                        
                        NavigationLink(destination: FocusSetupPage()) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(height: 55)
                                    .foregroundStyle(isContrast ? IceWhitePalette.PureSnow.color : OceanBluePalette.OceanBlue.color)
                                Text("Start Focus session")
                                    .font(.headline)
                                    .foregroundStyle(isContrast ? MidnightNavyPalette.AbyssalBlack.color : IceWhitePalette.PureSnow.color)
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 30)
                        .padding(.bottom, 25)
                    } else {
                        HStack{
                            Text("Dashboard")
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(IceWhitePalette.PureSnow.color)
                            Spacer()
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 100, height: 36)
                                    .foregroundStyle(isContrast ? IceWhitePalette.PureSnow.color : MidnightNavyPalette.DeepMariner.color)
                                Text("placeholder")
                                    .font(.caption)
                                    .foregroundStyle(isContrast ? MidnightNavyPalette.AbyssalBlack.color : IceWhitePalette.PureSnow.color)
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 50)
                        
                        // screentime
                        Text("placeholder")
                            .font(.system(size: 56, weight: .bold))
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                            .padding(.top, 20)
                        
                        Text("SCREEN TIME TODAY")
                            .font(.caption)
                            .foregroundStyle(isContrast ? IceWhitePalette.PureSnow.color : SkyBluePalette.SummerSky.color)
                        
                        // goes to focus setup
                        NavigationLink(destination: FocusSetupPage()) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(height: 55)
                                    .foregroundStyle(isContrast ? IceWhitePalette.PureSnow.color : OceanBluePalette.OceanBlue.color)
                                Text("Start Focus session")
                                    .font(.headline)
                                    .foregroundStyle(isContrast ? MidnightNavyPalette.AbyssalBlack.color : IceWhitePalette.PureSnow.color)
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 25)
                        .padding(.bottom, 20)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(edges: .top)
            
            
            // app cards — hidden in simplify so tasks sit higher
            if !isSimplify {
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundStyle(isContrast ? IceWhitePalette.PureSnow.color : ContentView.Background2)
                    HStack(spacing: 12){
                        AppUsageCard()
                        AppUsageCard()
                        AppUsageCard()
                        AppUsageCard()
                    }
                }
                .frame(height: 120)
                .padding(.top, 4)
                .padding(.horizontal, 10)
            }
            
            // tasks — only this list scrolls
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundStyle(isContrast ? IceWhitePalette.PureSnow.color : IceWhitePalette.GlacierFrost.color)
                
                VStack{
                    if !isSimplify {
                        HStack {
                            
                            Text("TODAY'S TASKS")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                                .padding(.leading, 20)
                            
                            Spacer()
                            NavigationLink(destination: NewTaskPage()) {
                                Text("+ Add task")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundStyle(isContrast ? MidnightNavyPalette.AbyssalBlack.color : OceanBluePalette.OceanBlue.color)
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.top, 15)
                    }
                    
                    List {
                        ForEach(0..<tasks.count, id: \.self) { i in
                            TaskRow(index: i)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .padding(.top, isSimplify ? 8 : 0)
                    
                }
            }
            .frame(maxHeight: .infinity)
            
            
        }
        .background(isContrast ? IceWhitePalette.PureSnow.color : Color.clear)
    }
}
#Preview {
    Dashboard()
}

struct TasksPage: View {
    @AppStorage("tasks") var tasksRaw = startingTasks
    @AppStorage("doneIndexes") var doneRaw = ""
    @AppStorage("lookMode") var lookMode = "full colors"
    
    var isSimplify: Bool {
        lookMode == "simplify"
    }
    
    var isContrast: Bool {
        lookMode == "increased contrast"
    }
    
    var body: some View {
        let tasks = getTasks(tasksRaw)
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                if isContrast {
                    RoundedRectangle(cornerRadius: 60)
                        .foregroundStyle(MidnightNavyPalette.AbyssalBlack.color)
                } else {
                    RoundedRectangle(cornerRadius: 60)
                        .foregroundStyle(ContentView.Background3)
                }
                VStack {
                    if isSimplify {
                        // just big Tasks + add task
                        Text("Tasks")
                            .font(.system(size: 56, weight: .bold))
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                            .padding(.top, 60)
                        
                        NavigationLink(destination: NewTaskPage()) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(height: 55)
                                    .foregroundStyle(isContrast ? IceWhitePalette.PureSnow.color : ContentView.Background1)
                                Text("Add Task")
                                    .font(.headline)
                                    .foregroundStyle(isContrast ? MidnightNavyPalette.AbyssalBlack.color : IceWhitePalette.PureSnow.color)
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 30)
                        .padding(.bottom, 25)
                    } else {
                        HStack{
                            Text("Tasks")
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(IceWhitePalette.PureSnow.color)
                            Spacer()
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 100, height: 36)
                                    .foregroundStyle(isContrast ? IceWhitePalette.PureSnow.color : MidnightNavyPalette.DeepMariner.color)
                                Text("placeholder")
                                    .font(.caption)
                                    .foregroundStyle(isContrast ? MidnightNavyPalette.AbyssalBlack.color : IceWhitePalette.PureSnow.color)
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 50)
                        
                        Text("placeholder")
                            .font(.system(size: 72, weight: .bold))
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                            .padding(.top, 20)
                        
                        Text("TASKS REMAINING")
                            .font(.caption)
                            .foregroundStyle(isContrast ? IceWhitePalette.PureSnow.color : SkyBluePalette.SummerSky.color)
                        
                        NavigationLink(destination: NewTaskPage()) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(height: 55)
                                    .foregroundStyle(isContrast ? IceWhitePalette.PureSnow.color : ContentView.Background1)
                                Text("Add Task")
                                    .font(.headline)
                                    .foregroundStyle(isContrast ? MidnightNavyPalette.AbyssalBlack.color : IceWhitePalette.PureSnow.color)
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 25)
                        .padding(.bottom, 20)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(edges: .top)
            
            // remove button under the blue header — clears tasks with an X
            Button {
                var newTasks: [String] = []
                let dones = getDoneIndexes(doneRaw)
                for i in 0..<tasks.count {
                    if !dones.contains(i) {
                        newTasks.append(tasks[i])
                    }
                }
                tasksRaw = makeTasksRaw(newTasks)
                doneRaw = ""
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(height: 50)
                        .foregroundStyle(isContrast ? MidnightNavyPalette.AbyssalBlack.color : MidnightNavyPalette.MidnightNavy.color)
                    Text("Remove")
                        .font(.headline)
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                }
            }
            .padding(.horizontal, 25)
            .padding(.top, 4)
            .padding(.bottom, 8)
            
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundStyle(isContrast ? IceWhitePalette.PureSnow.color : IceWhitePalette.GlacierFrost.color)
                
                // only the tasks scroll
                List {
                    ForEach(0..<tasks.count, id: \.self) { i in
                        TaskRow(index: i)
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .frame(maxHeight: .infinity)
        }
        .background(isContrast ? IceWhitePalette.PureSnow.color : Color.clear)
    }
}

#Preview {
    TasksPage()
}

struct NewTaskPage: View {
    @AppStorage("tasks") var tasksRaw = startingTasks
    @AppStorage("tab") var tab = 0
    @Environment(\.dismiss) var dismiss
    @State var taskName = ""
    @State var taskText = ""
    // 1 easy 10 hard
    @State var difficulty = 5
    
    var difficultyLabel: String {
        if difficulty <= 3 {
            return "Easy"
        } else if difficulty <= 7 {
            return "Medium"
        } else {
            return "Hard"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // task name
            TextField("Task name", text: $taskName)
                .font(.title2)
                .bold()
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 16)
            
            // description
            TextField("Describe what you need to get done.", text: $taskText)
                .font(.title3)
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            
            Text("TASK")
                .font(.caption)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            Divider()
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 50)
                    .foregroundStyle(SkyBluePalette.SkyGlow.color)
                HStack {
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                    Text(difficultyLabel)
                        .font(.body)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
            
            Text("DIFFICULTY")
                .font(.caption)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            
            // balls 1-10 left easy right hard
            HStack(spacing: 8) {
                ForEach(1...10, id: \.self) { n in
                    Button {
                        difficulty = n
                    } label: {
                        Circle()
                            .frame(width: 28, height: 28)
                            .foregroundStyle(n <= difficulty ? (n <= 3 ? SkyBluePalette.SkyGlow.color : (n <= 7 ? OceanBluePalette.OceanBlue.color : MidnightNavyPalette.MidnightNavy.color)) : IceWhitePalette.ArcticBreeze.color)
                    }
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            NavigationLink(destination: BreakdownPage()) {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(height: 55)
                        .foregroundStyle(ContentView.Background1)
                    Text("AI: Break it down")
                        .font(.headline)
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .background(IceWhitePalette.PureSnow.color)
        .navigationTitle("New Task")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // save then go right to dashboard
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    if taskName != "" || taskText != "" {
                        var tasks = getTasks(tasksRaw)
                        let name = taskName != "" ? taskName : "New Task"
                        tasks.append(makePackedTask(name, taskText))
                        tasksRaw = makeTasksRaw(tasks)
                        taskName = ""
                        taskText = ""
                    }
                    tab = 0
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        NewTaskPage()
    }
}

// page when u click a task
struct TaskDetailPage: View {
    var index: Int
    @AppStorage("tasks") var tasksRaw = startingTasks
    @State var name = ""
    @State var text = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // edit the name
            TextField("Task name", text: $name)
                .font(.title2)
                .bold()
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 16)
            
            // edit the description
            TextField("Describe what you need to get done.", text: $text)
                .font(.title3)
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                .padding(.horizontal, 20)
            
            Spacer()
        }
        .background(IceWhitePalette.PureSnow.color)
        .navigationTitle("Task")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    var tasks = getTasks(tasksRaw)
                    if index < tasks.count {
                        tasks[index] = makePackedTask(name, text)
                        tasksRaw = makeTasksRaw(tasks)
                    }
                }
            }
        }
        .onAppear {
            let tasks = getTasks(tasksRaw)
            if index < tasks.count {
                name = getTaskName(tasks[index])
                text = getTaskDescription(tasks[index])
            }
        }
    }
}

#Preview {
    TaskDetailPage(index: 0)
}

struct BreakdownPage: View {
    @AppStorage("lookMode") var lookMode = "full colors"
    
    var isSimplify: Bool {
        lookMode == "simplify"
    }
    
    var isContrast: Bool {
        lookMode == "increased contrast"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                if isContrast {
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundStyle(MidnightNavyPalette.AbyssalBlack.color)
                } else if isSimplify {
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundStyle(ContentView.Background3)
                } else {
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundStyle(ContentView.Background4)
                }
                VStack(alignment: .leading, spacing: 12) {
                    if isSimplify {
                        Text("Breakdown")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                            .padding(.top, 50)
                        
                        Text("Super hard task")
                            .font(.title2)
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 130, height: 32)
                                .foregroundStyle(isContrast ? IceWhitePalette.PureSnow.color : OceanBluePalette.OceanBlue.color)
                            Text("PLAN READY")
                                .font(.caption)
                                .bold()
                                .foregroundStyle(isContrast ? MidnightNavyPalette.AbyssalBlack.color : IceWhitePalette.PureSnow.color)
                        }
                        .padding(.top, 50)
                        
                        Text("AI broke this into focused steps")
                            .font(.subheadline)
                            .foregroundStyle(isContrast ? IceWhitePalette.PureSnow.color : MidnightNavyPalette.DeepMariner.color)
                        
                        Text("Super hard task")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(isContrast ? IceWhitePalette.PureSnow.color : MidnightNavyPalette.MidnightNavy.color)
                        
                        HStack(spacing: 12) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 18)
                                    .frame(height: 50)
                                    .foregroundStyle(IceWhitePalette.PureSnow.color)
                                Text("breakdown: placeholder")
                                    .font(.caption)
                                    .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 18)
                                    .frame(height: 50)
                                    .foregroundStyle(IceWhitePalette.PureSnow.color)
                                Text("estimated: placeholder")
                                    .font(.caption)
                                    .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                            }
                        }
                    }
                }
                .padding(.horizontal, 25)
                .padding(.bottom, isSimplify ? 25 : 0)
            }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(edges: .top)
            
            ScrollView {
                VStack(spacing: 12) {
                    BreakdownStepCard(text: "Define the goal clearly so the next steps are obvious")
                    BreakdownStepCard(text: "Gather the materials and notes you already have")
                    BreakdownStepCard(text: "Break the hard parts into smaller actions")
                    BreakdownStepCard(text: "Do the first focused push without switching apps")
                    BreakdownStepCard(text: "Review what got done and lock the next move")
                }
                .padding(.top, 20)
            }
            
            NavigationLink(destination: TasksPage()) {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(height: 55)
                        .foregroundStyle(isContrast ? MidnightNavyPalette.AbyssalBlack.color : ContentView.Background1)
                    Text("Add Task")
                        .font(.headline)
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .padding(.bottom, isSimplify ? 30 : 10)
            
            if !isSimplify {
                NavigationLink(destination: NewTaskPage()) {
                    Text("Back")
                        .font(.body)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                }
                .padding(.top, 12)
                .padding(.bottom, 30)
            }
        }
        .background(isContrast ? IceWhitePalette.PureSnow.color : ContentView.Background2)
    }
}

#Preview {
    BreakdownPage()
}

struct BreakdownStepCard: View {
    var text: String
    @AppStorage("lookMode") var lookMode = "full colors"
    
    var isContrast: Bool {
        lookMode == "increased contrast"
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(IceWhitePalette.PureSnow.color)
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(isContrast ? MidnightNavyPalette.AbyssalBlack.color : OceanBluePalette.OceanBlue.color)
                    Text("placeholder")
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.white)
                }
                Text(text)
                    .font(.subheadline)
                    .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                Spacer()
                if lookMode != "simplify" {
                    Text("placeholder")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            .padding()
        }
        .padding(.horizontal, 20)
    }
}

// bottom for all apps mode
struct FocusSetupAllAppsBottom: View {
    @AppStorage("tasks") var tasksRaw = startingTasks
    @AppStorage("lookMode") var lookMode = "full colors"
    
    var isSimplify: Bool {
        lookMode == "simplify"
    }
    
    var body: some View {
        let tasks = getTasks(tasksRaw)
        VStack(alignment: .leading, spacing: 16) {
            if !isSimplify {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 90)
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                    VStack(spacing: 6) {
                        Text("All apps blocked")
                            .font(.headline)
                            .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                        Text("Distracting apps stay locked until you're done")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Text("UNTIL DONE")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Spacer()
                    Text("placeholder")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal, 20)
            }
            
            ForEach(0..<tasks.count, id: \.self) { i in
                TaskRow(index: i)
            }
        }
    }
}

// bottom for select apps mode
struct FocusSetupSelectAppsBottom: View {
    @AppStorage("lookMode") var lookMode = "full colors"
    
    var isSimplify: Bool {
        lookMode == "simplify"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if !isSimplify {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 44)
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                    HStack {
                        Text("Search apps...")
                            .font(.body)
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.horizontal, 20)
            }
            
            AppSelectRow(name: "Amazon")
            AppSelectRow(name: "Calendar")
            AppSelectRow(name: "Chrome")
            AppSelectRow(name: "Discord")
            AppSelectRow(name: "FaceTime")
            
            if !isSimplify {
                Text("BREAKS")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                
                HStack(spacing: 0) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(height: 40)
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                        Text("placeholder")
                            .font(.subheadline)
                            .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(height: 40)
                            .foregroundStyle(OceanBluePalette.OceanBlue.color)
                        Text("placeholder")
                            .font(.subheadline)
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(height: 40)
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                        Text("placeholder")
                            .font(.subheadline)
                            .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct AppSelectRow: View {
    var name: String
    @AppStorage("lookMode") var lookMode = "full colors"
    
    var isContrast: Bool {
        lookMode == "increased contrast"
    }
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 36, height: 36)
                .foregroundStyle(isContrast ? MidnightNavyPalette.AbyssalBlack.color : ContentView.Background3)
            Text(name)
                .font(.body)
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
            Spacer()
            Circle()
                .stroke(isContrast ? MidnightNavyPalette.AbyssalBlack.color : OceanBluePalette.OceanBlue.color, lineWidth: isContrast ? 3 : 2)
                .frame(width: 22, height: 22)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

struct FocusSetupPage: View {
    // switches the bottom half
    @State var showSelectApps = false
    @AppStorage("lookMode") var lookMode = "full colors"
    
    var isSimplify: Bool {
        lookMode == "simplify"
    }
    
    var isContrast: Bool {
        lookMode == "increased contrast"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                if isContrast {
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundStyle(MidnightNavyPalette.AbyssalBlack.color)
                } else {
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundStyle(ContentView.Background3)
                }
                VStack(alignment: .leading, spacing: 8) {
                    if isSimplify {
                        Text("Focus Setup")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                            .padding(.top, 50)
                        
                        Text("Finish design brief")
                            .font(.title2)
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                            .padding(.bottom, 20)
                    } else {
                        HStack {
                            Text("Focus Setup")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(IceWhitePalette.PureSnow.color)
                            Spacer()
                        }
                        .padding(.top, 50)
                        
                        Text(showSelectApps ? "FOCUSING ON" : "STARTING WITH")
                            .font(.caption)
                            .foregroundStyle(isContrast ? IceWhitePalette.PureSnow.color : SkyBluePalette.SummerSky.color)
                            .padding(.top, 20)
                        
                        Text("Finish design brief")
                            .font(.title)
                            .bold()
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                        
                        Text("placeholder")
                            .font(.caption)
                            .foregroundStyle(isContrast ? IceWhitePalette.PureSnow.color : SkyBluePalette.SkyGlow.color)
                    }
                }
                .padding(.horizontal, 25)
            }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(edges: .top)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if !isSimplify {
                        Text("WHAT TO BLOCK")
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                    }
                    
                    // these just flip the bottom
                    HStack(spacing: 0) {
                        Button {
                            showSelectApps = false
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(height: 44)
                                    .foregroundStyle(showSelectApps ? IceWhitePalette.PureSnow.color : (isContrast ? MidnightNavyPalette.AbyssalBlack.color : OceanBluePalette.OceanBlue.color))
                                Text("All apps")
                                    .font(.subheadline)
                                    .foregroundStyle(showSelectApps ? MidnightNavyPalette.MidnightNavy.color : IceWhitePalette.PureSnow.color)
                            }
                        }
                        
                        Button {
                            showSelectApps = true
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(height: 44)
                                    .foregroundStyle(showSelectApps ? (isContrast ? MidnightNavyPalette.AbyssalBlack.color : OceanBluePalette.OceanBlue.color) : IceWhitePalette.PureSnow.color)
                                Text("Select apps")
                                    .font(.subheadline)
                                    .foregroundStyle(showSelectApps ? IceWhitePalette.PureSnow.color : MidnightNavyPalette.MidnightNavy.color)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, isSimplify ? 16 : 0)
                    
                    if showSelectApps {
                        FocusSetupSelectAppsBottom()
                    } else {
                        FocusSetupAllAppsBottom()
                    }
                }
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: 55)
                    .foregroundStyle(isContrast ? MidnightNavyPalette.AbyssalBlack.color : OceanBluePalette.OceanBlue.color)
                Text("Start Focus Session")
                    .font(.headline)
                    .foregroundStyle(IceWhitePalette.PureSnow.color)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .background(isContrast ? IceWhitePalette.PureSnow.color : IceWhitePalette.GlacierFrost.color)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FocusSetupPage()
}

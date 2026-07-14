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
// joined w ||| so its just one string
func getTasks(_ raw: String) -> [String] {
    if raw == "" {
        return []
    }
    return raw.components(separatedBy: "|||")
}

func makeTasksRaw(_ list: [String]) -> String {
    list.joined(separator: "|||")
}

let startingTasks = "Finish design brief|||Reply to team messages|||15-min walk outside|||Review feedback notes|||Draft revised homepage|||Send to Jordan for review"

struct ContentView: View {
    static let Background1 = LinearGradient(colors: [OceanBluePalette.DeepNavy.color,OceanBluePalette.OceanBlue.color, OceanBluePalette.ScubaCyan.color, OceanBluePalette.Seafoam.color], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let Background2 = LinearGradient(colors: [IceWhitePalette.PureSnow.color,IceWhitePalette.GlacierFrost.color, IceWhitePalette.PowderIce.color, IceWhitePalette.ArcticBreeze.color], startPoint: .topTrailing, endPoint: .bottomLeading)
    static let Background3 = LinearGradient(colors: [MidnightNavyPalette.AbyssalBlack.color,MidnightNavyPalette.MidnightNavy.color, MidnightNavyPalette.DeepMariner.color, MidnightNavyPalette.GlowingCobalt.color], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let Background4 = LinearGradient(colors: [SkyBluePalette.SkyGlow.color,SkyBluePalette.SummerSky.color, SkyBluePalette.ClearWater.color, SkyBluePalette.CoastalTeal.color], startPoint: .topTrailing, endPoint: .bottomLeading)
    var body: some View {
        // bottom 3 things are real tabs now
        TabView {
            NavigationStack {
                Dashboard()
            }
            .tabItem {
                Text("Dashboard")
                Text("icon")
            }
            
            NavigationStack {
                TasksPage()
            }
            .tabItem {
                Text("Tasks")
                Text("icon")
            }
            
            NavigationStack {
                SettingsPage()
            }
            .tabItem {
                Text("Settings")
                Text("icon")
            }
        }
        .background(ContentView.Background3)
        
    }
}

#Preview {
    ContentView()
}

// settings tab for now
struct SettingsPage: View {
    var body: some View {
        ZStack {
            ContentView.Background2
            Text("Settings")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
        }
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
    @State var isChecked = false
    
    var body: some View {
        let tasks = getTasks(tasksRaw)
        HStack {
            // check circle
            Button {
                isChecked.toggle()
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
            
            // tap text goes to detail
            if index < tasks.count {
                NavigationLink(destination: TaskDetailPage(index: index)) {
                    Text(tasks[index])
                        .font(.subheadline)
                        .foregroundStyle(isChecked ? .gray : MidnightNavyPalette.MidnightNavy.color)
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
    }
}

struct Dashboard: View {
    @AppStorage("tasks") var tasksRaw = startingTasks
    
    var body: some View {
        let tasks = getTasks(tasksRaw)
        VStack(spacing: 0) {
            // top dark header
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 60)
                    .foregroundStyle(ContentView.Background3)
                VStack {
                    HStack{
                        Text("Dashboard")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 100, height: 36)
                                .foregroundStyle(MidnightNavyPalette.DeepMariner.color)
                            Text("placeholder")
                                .font(.caption)
                                .foregroundStyle(IceWhitePalette.PureSnow.color)
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
                        .foregroundStyle(SkyBluePalette.SummerSky.color)
                    
                    // goes to focus setup
                    NavigationLink(destination: FocusSetupPage()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .frame(height: 55)
                                .foregroundStyle(OceanBluePalette.OceanBlue.color)
                            Text("Start Focus session")
                                .font(.headline)
                                .foregroundStyle(IceWhitePalette.PureSnow.color)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 25)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 350)
            .ignoresSafeArea(edges: .top)
            
            
            // app cards
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .frame(maxWidth: .infinity, maxHeight: 150)
                    .foregroundStyle(ContentView.Background2)
                    .padding(.bottom, 15)
                HStack(spacing: 12){
                    AppUsageCard()
                    AppUsageCard()
                    AppUsageCard()
                    AppUsageCard()
                }
            }
            
            // tasks
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundStyle(IceWhitePalette.GlacierFrost.color)
                
                VStack{
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
                                .foregroundStyle(OceanBluePalette.OceanBlue.color)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 15)
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(0..<tasks.count, id: \.self) { i in
                                TaskRow(index: i)
                            }
                        }
                    }
                    
                }
            }
            
            
        }
    }
}
#Preview {
    Dashboard()
}

struct TasksPage: View {
    @AppStorage("tasks") var tasksRaw = startingTasks
    
    var body: some View {
        let tasks = getTasks(tasksRaw)
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 60)
                    .foregroundStyle(ContentView.Background3)
                VStack {
                    HStack{
                        Text("Tasks")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 100, height: 36)
                                .foregroundStyle(MidnightNavyPalette.DeepMariner.color)
                            Text("placeholder")
                                .font(.caption)
                                .foregroundStyle(IceWhitePalette.PureSnow.color)
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
                        .foregroundStyle(SkyBluePalette.SummerSky.color)
                    
                    NavigationLink(destination: NewTaskPage()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .frame(height: 55)
                                .foregroundStyle(ContentView.Background1)
                            Text("Add Task")
                                .font(.headline)
                                .foregroundStyle(IceWhitePalette.PureSnow.color)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 25)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 350)
            .ignoresSafeArea(edges: .top)
            
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundStyle(IceWhitePalette.GlacierFrost.color)
                
                VStack {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(0..<tasks.count, id: \.self) { i in
                                TaskRow(index: i)
                            }
                        }
                        .padding(.top, 20)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    TasksPage()
}

struct NewTaskPage: View {
    @AppStorage("tasks") var tasksRaw = startingTasks
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
            HStack {
                NavigationLink(destination: Dashboard()) {
                    Text("Back")
                        .font(.body)
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                }
                Spacer()
                Text("New Task")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                Spacer()
                // save adds it then u can hit back
                Button {
                    if taskText != "" {
                        var tasks = getTasks(tasksRaw)
                        tasks.append(taskText)
                        tasksRaw = makeTasksRaw(tasks)
                        taskText = ""
                    }
                } label: {
                    Text("Save")
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(SkyBluePalette.SkyGlow.color)
                        .cornerRadius(20)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 30)
            
            // type here
            TextField("Describe what you need to get done.", text: $taskText)
                .font(.title2)
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
    }
}

#Preview {
    NewTaskPage()
}

// page when u click a task
struct TaskDetailPage: View {
    var index: Int
    @AppStorage("tasks") var tasksRaw = startingTasks
    @State var text = ""
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                NavigationLink(destination: Dashboard()) {
                    Text("Back")
                        .font(.body)
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                }
                Spacer()
                Text("Task")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                Spacer()
                // save the edited text
                Button {
                    var tasks = getTasks(tasksRaw)
                    if index < tasks.count {
                        tasks[index] = text
                        tasksRaw = makeTasksRaw(tasks)
                    }
                } label: {
                    Text("Save")
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(SkyBluePalette.SkyGlow.color)
                        .cornerRadius(20)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 30)
            
            // their description
            TextField("Describe what you need to get done.", text: $text)
                .font(.title2)
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                .padding(.horizontal, 20)
            
            Spacer()
        }
        .background(IceWhitePalette.PureSnow.color)
        .onAppear {
            let tasks = getTasks(tasksRaw)
            if index < tasks.count {
                text = tasks[index]
            }
        }
    }
}

#Preview {
    TaskDetailPage(index: 0)
}

struct BreakdownPage: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundStyle(ContentView.Background4)
                VStack(alignment: .leading, spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 130, height: 32)
                            .foregroundStyle(OceanBluePalette.OceanBlue.color)
                        Text("PLAN READY")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                    }
                    .padding(.top, 50)
                    
                    Text("AI broke this into focused steps")
                        .font(.subheadline)
                        .foregroundStyle(MidnightNavyPalette.DeepMariner.color)
                    
                    Text("Super hard task")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                    
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
                .padding(.horizontal, 25)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 280)
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
                        .foregroundStyle(ContentView.Background1)
                    Text("Add Task")
                        .font(.headline)
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            NavigationLink(destination: NewTaskPage()) {
                Text("Back")
                    .font(.body)
                    .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
            }
            .padding(.top, 12)
            .padding(.bottom, 30)
        }
        .background(ContentView.Background2)
    }
}

#Preview {
    BreakdownPage()
}

struct BreakdownStepCard: View {
    var text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(IceWhitePalette.PureSnow.color)
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                    Text("placeholder")
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.white)
                }
                Text(text)
                    .font(.subheadline)
                    .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                Spacer()
                Text("placeholder")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding()
        }
        .padding(.horizontal, 20)
    }
}

// bottom for all apps mode
struct FocusSetupAllAppsBottom: View {
    @AppStorage("tasks") var tasksRaw = startingTasks
    
    var body: some View {
        let tasks = getTasks(tasksRaw)
        VStack(alignment: .leading, spacing: 16) {
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
            
            ForEach(0..<tasks.count, id: \.self) { i in
                TaskRow(index: i)
            }
        }
    }
}

// bottom for select apps mode
struct FocusSetupSelectAppsBottom: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
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
            
            AppSelectRow(name: "Amazon")
            AppSelectRow(name: "Calendar")
            AppSelectRow(name: "Chrome")
            AppSelectRow(name: "Discord")
            AppSelectRow(name: "FaceTime")
            
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

struct AppSelectRow: View {
    var name: String
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 36, height: 36)
                .foregroundStyle(ContentView.Background3)
            Text(name)
                .font(.body)
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
            Spacer()
            Circle()
                .stroke(OceanBluePalette.OceanBlue.color, lineWidth: 2)
                .frame(width: 22, height: 22)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

struct FocusSetupPage: View {
    // switches the bottom half
    @State var showSelectApps = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundStyle(ContentView.Background3)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        NavigationLink(destination: Dashboard()) {
                            Text("Back")
                                .font(.body)
                                .foregroundStyle(IceWhitePalette.PureSnow.color)
                        }
                        Spacer()
                        Text("Focus Setup")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                        Spacer()
                        Text("Back")
                            .font(.body)
                            .foregroundStyle(.clear)
                    }
                    .padding(.top, 50)
                    
                    Text(showSelectApps ? "FOCUSING ON" : "STARTING WITH")
                        .font(.caption)
                        .foregroundStyle(SkyBluePalette.SummerSky.color)
                        .padding(.top, 20)
                    
                    Text("Finish design brief")
                        .font(.title)
                        .bold()
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                    
                    Text("placeholder")
                        .font(.caption)
                        .foregroundStyle(SkyBluePalette.SkyGlow.color)
                }
                .padding(.horizontal, 25)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .ignoresSafeArea(edges: .top)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("WHAT TO BLOCK")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    
                    // these just flip the bottom
                    HStack(spacing: 0) {
                        Button {
                            showSelectApps = false
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(height: 44)
                                    .foregroundStyle(showSelectApps ? IceWhitePalette.PureSnow.color : OceanBluePalette.OceanBlue.color)
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
                                    .foregroundStyle(showSelectApps ? OceanBluePalette.OceanBlue.color : IceWhitePalette.PureSnow.color)
                                Text("Select apps")
                                    .font(.subheadline)
                                    .foregroundStyle(showSelectApps ? IceWhitePalette.PureSnow.color : MidnightNavyPalette.MidnightNavy.color)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
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
                    .foregroundStyle(OceanBluePalette.OceanBlue.color)
                Text("Start Focus Session")
                    .font(.headline)
                    .foregroundStyle(IceWhitePalette.PureSnow.color)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .background(IceWhitePalette.GlacierFrost.color)
    }
}

#Preview {
    FocusSetupPage()
}

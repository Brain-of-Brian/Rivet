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
struct ContentView: View {
    static let Background1 = LinearGradient(colors: [OceanBluePalette.DeepNavy.color,OceanBluePalette.OceanBlue.color, OceanBluePalette.ScubaCyan.color, OceanBluePalette.Seafoam.color], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let Background2 = LinearGradient(colors: [IceWhitePalette.PureSnow.color,IceWhitePalette.GlacierFrost.color, IceWhitePalette.PowderIce.color, IceWhitePalette.ArcticBreeze.color], startPoint: .topTrailing, endPoint: .bottomLeading)
    static let Background3 = LinearGradient(colors: [MidnightNavyPalette.AbyssalBlack.color,MidnightNavyPalette.MidnightNavy.color, MidnightNavyPalette.DeepMariner.color, MidnightNavyPalette.GlowingCobalt.color], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let Background4 = LinearGradient(colors: [SkyBluePalette.SkyGlow.color,SkyBluePalette.SummerSky.color, SkyBluePalette.ClearWater.color, SkyBluePalette.CoastalTeal.color], startPoint: .topTrailing, endPoint: .bottomLeading)
    var body: some View {
        NavigationStack {
            Dashboard()
        }
        .background(ContentView.Background3)
        
    }
}

#Preview {
    ContentView()
}

// bottom bar w the 3 tabs
struct TabBarPlaceholder: View {
    var body: some View {
        HStack {
            NavigationLink(destination: Dashboard().toolbar(.hidden, for: .navigationBar)) {
                VStack {
                    Text("Dashboard")
                        .font(.caption)
                    Text("icon")
                        .font(.caption2)
                }
            }
            .frame(maxWidth: .infinity)
            
            NavigationLink(destination: TasksPage().toolbar(.hidden, for: .navigationBar)) {
                VStack {
                    Text("Tasks")
                        .font(.caption)
                    Text("icon")
                        .font(.caption2)
                }
            }
            .frame(maxWidth: .infinity)
            
            VStack {
                Text("Settings")
                    .font(.caption)
                Text("icon")
                    .font(.caption2)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
        .background(IceWhitePalette.PureSnow.color)
    }
}

// little app usage box on dashboard
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

// one subtask u can check off, puts an x when done
struct SubTaskRow: View {
    @State var isChecked = false
    var body: some View {
        Button {
            isChecked.toggle()
        } label: {
            HStack {
                ZStack {
                    Circle()
                        .stroke(OceanBluePalette.OceanBlue.color, lineWidth: 2)
                        .frame(width: 18, height: 18)
                    // x only shows if u finished it
                    if isChecked {
                        Text("X")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(OceanBluePalette.OceanBlue.color)
                    }
                }
                Text("Review feedback notes")
                    .font(.subheadline)
                    .strikethrough(isChecked)
                    .foregroundStyle(isChecked ? .gray : MidnightNavyPalette.MidnightNavy.color)
                Spacer()
            }
        }
        .buttonStyle(.plain)
    }
}

struct SubTaskRow2: View {
    @State var isChecked = false
    var body: some View {
        Button {
            isChecked.toggle()
        } label: {
            HStack {
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
                Text("Draft revised homepage")
                    .font(.subheadline)
                    .strikethrough(isChecked)
                    .foregroundStyle(isChecked ? .gray : MidnightNavyPalette.MidnightNavy.color)
                Spacer()
            }
        }
        .buttonStyle(.plain)
    }
}

struct SubTaskRow3: View {
    @State var isChecked = false
    var body: some View {
        Button {
            isChecked.toggle()
        } label: {
            HStack {
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
                Text("Send to Jordan for review")
                    .font(.subheadline)
                    .strikethrough(isChecked)
                    .foregroundStyle(isChecked ? .gray : MidnightNavyPalette.MidnightNavy.color)
                Spacer()
            }
        }
        .buttonStyle(.plain)
    }
}

// task card opened w the little steps under it
struct TaskCardExpanded: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(IceWhitePalette.PureSnow.color)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                    Text("Finish design brief")
                        .font(.headline)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                    Spacer()
                    // like 1/3 done type thing
                    Text("placeholder")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                SubTaskRow()
                SubTaskRow2()
                SubTaskRow3()
            }
            .padding()
        }
        .padding(.horizontal, 20)
    }
}

// just the closed task card
struct TaskCardCollapsed: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(IceWhitePalette.PureSnow.color)
            HStack {
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundStyle(OceanBluePalette.ScubaCyan.color)
                VStack(alignment: .leading) {
                    Text("Reply to team messages")
                        .font(.headline)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                    Text("placeholder")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                Spacer()
                Text(">")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding()
        }
        .padding(.horizontal, 20)
    }
}

struct TaskCardCollapsed2: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(IceWhitePalette.PureSnow.color)
            HStack {
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundStyle(OceanBluePalette.ScubaCyan.color)
                VStack(alignment: .leading) {
                    Text("15-min walk outside")
                        .font(.headline)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                    Text("placeholder")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                Spacer()
                Text(">")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding()
        }
        .padding(.horizontal, 20)
    }
}

// one of the ai breakdown step rows
struct BreakdownStepCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(IceWhitePalette.PureSnow.color)
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                    // step number
                    Text("placeholder")
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.white)
                }
                Text("Define the goal clearly so the next steps are obvious")
                    .font(.subheadline)
                    .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                Spacer()
                // the time estimate
                Text("placeholder")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding()
        }
        .padding(.horizontal, 20)
    }
}

struct BreakdownStepCard2: View {
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
                Text("Gather the materials and notes you already have")
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

struct BreakdownStepCard3: View {
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
                Text("Break the hard parts into smaller actions")
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

struct BreakdownStepCard4: View {
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
                Text("Do the first focused push without switching apps")
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

struct BreakdownStepCard5: View {
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
                Text("Review what got done and lock the next move")
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

// row for picking an app to block
struct AppSelectRow: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 36, height: 36)
                .foregroundStyle(ContentView.Background3)
            Text("Amazon")
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

struct AppSelectRow2: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 36, height: 36)
                .foregroundStyle(ContentView.Background3)
            Text("Calendar")
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

struct AppSelectRow3: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 36, height: 36)
                .foregroundStyle(ContentView.Background3)
            Text("Chrome")
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

struct AppSelectRow4: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 36, height: 36)
                .foregroundStyle(ContentView.Background3)
            Text("Discord")
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

struct AppSelectRow5: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 36, height: 36)
                .foregroundStyle(ContentView.Background3)
            Text("FaceTime")
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

// color circle for new task
struct ColorDot: View {
    var body: some View {
        Circle()
            .frame(width: 36, height: 36)
            .foregroundStyle(OceanBluePalette.OceanBlue.color)
    }
}

struct Dashboard: View {
    var body: some View {
        VStack(spacing: 0) {
            // top dark header blob
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
                        // streak pill, number later
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
                    
                    // screentime big number
                    Text("placeholder")
                        .font(.system(size: 56, weight: .bold))
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                        .padding(.top, 20)
                    
                    Text("SCREEN TIME TODAY")
                        .font(.caption)
                        .foregroundStyle(SkyBluePalette.SummerSky.color)
                    
                    // blue button -> focus setup
                    NavigationLink(destination: FocusSetupPage().toolbar(.hidden, for: .navigationBar)) {
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
            
            
            // the app usage cards row
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
            
            // todays tasks section
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
                        NavigationLink(destination: NewTaskPage().toolbar(.hidden, for: .navigationBar)) {
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
                            TaskCardExpanded()
                            TaskCardCollapsed()
                            TaskCardCollapsed2()
                        }
                    }
                    
                    TabBarPlaceholder()
                }
            }
            
            
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}
#Preview {
    Dashboard()
}

struct TasksPage: View {
    var body: some View {
        VStack(spacing: 0) {
            // same vibe as dashboard header but for tasks
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
                        // time remaining thing
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
                    
                    // how many tasks left
                    Text("placeholder")
                        .font(.system(size: 72, weight: .bold))
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                        .padding(.top, 20)
                    
                    Text("TASKS REMAINING")
                        .font(.caption)
                        .foregroundStyle(SkyBluePalette.SummerSky.color)
                    
                    // add task blue button
                    NavigationLink(destination: NewTaskPage().toolbar(.hidden, for: .navigationBar)) {
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
                            TaskCardExpanded()
                            TaskCardCollapsed()
                            TaskCardCollapsed2()
                        }
                        .padding(.top, 20)
                    }
                    
                    TabBarPlaceholder()
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    TasksPage()
}

struct NewTaskPage: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0) {
            // top bar back / title / save
            HStack {
                Button {
                    dismiss()
                } label: {
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
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 70, height: 36)
                        .foregroundStyle(SkyBluePalette.SkyGlow.color)
                    Text("Save")
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 30)
            
            Text("Describe what you need to get done.")
                .font(.title2)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
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
            
            // priority box
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 50)
                    .foregroundStyle(SkyBluePalette.SkyGlow.color)
                HStack {
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                    Text("Medium")
                        .font(.body)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
            
            Text("COLOR")
                .font(.caption)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            
            HStack(spacing: 16) {
                ColorDot()
                ColorDot()
                ColorDot()
                ColorDot()
                ColorDot()
                ColorDot()
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            // ai break it down button -> breakdown page
            NavigationLink(destination: BreakdownPage().toolbar(.hidden, for: .navigationBar)) {
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
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NewTaskPage()
}

struct BreakdownPage: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0) {
            // light blue header
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
                    
                    // little stats cards, numbers later
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
                    BreakdownStepCard()
                    BreakdownStepCard2()
                    BreakdownStepCard3()
                    BreakdownStepCard4()
                    BreakdownStepCard5()
                }
                .padding(.top, 20)
            }
            
            // add the task
            NavigationLink(destination: TasksPage().toolbar(.hidden, for: .navigationBar)) {
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
            
            Button {
                dismiss()
            } label: {
                Text("Back")
                    .font(.body)
                    .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
            }
            .padding(.top, 12)
            .padding(.bottom, 30)
        }
        .background(ContentView.Background2)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    BreakdownPage()
}

// bottom half when "all apps" is picked
struct FocusSetupAllAppsBottom: View {
    var body: some View {
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
            
            TaskCardExpanded()
            TaskCardCollapsed()
        }
    }
}

// bottom half when "select apps" is picked
struct FocusSetupSelectAppsBottom: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // search bar fake
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
            
            VStack(spacing: 4) {
                AppSelectRow()
                AppSelectRow2()
                AppSelectRow3()
                AppSelectRow4()
                AppSelectRow5()
            }
            
            Text("BREAKS")
                .font(.caption)
                .foregroundStyle(.gray)
                .padding(.horizontal, 20)
                .padding(.top, 8)
            
            // break count buttons, numbers later
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

struct FocusSetupPage: View {
    @Environment(\.dismiss) var dismiss
    // flips the bottom content, doesnt leave the page
    @State var showSelectApps = false
    var body: some View {
        VStack(spacing: 0) {
            // dark header again
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundStyle(ContentView.Background3)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
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
                        // spacer so title stays centered
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
                    
                    // these 2 just switch the bottom, no navigation
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
            
            // start focus
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
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    FocusSetupPage()
}

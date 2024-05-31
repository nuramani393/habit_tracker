class Habit {
  int? id;
  String? title;
  String? desc;
  String? category;
  String? date;
  String? time;
  int? remind;
  int? streaks;
  String? repeat;
  int? isCompleted;
  String? lastUpdated;
  int? isSkipped;

  Habit({
    this.id,
    this.title,
    this.desc,
    this.category,
    this.date,
    this.time,
    this.remind,
    this.streaks,
    this.repeat,
    this.isCompleted,
    this.isSkipped,
    this.lastUpdated,
  });

  Habit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    category = json['category'];
    date = json['date']?.toString();
    time = json['time'];
    lastUpdated = json['lastUpdated']?.toString(); // Ensure it is a String
    remind = json['remind'];
    streaks = json['streaks'] ?? 0;
    repeat = json['repeat'];
    isCompleted = json['isCompleted'];
    isSkipped = json['isSkipped'];
    // id ??= 0;
  }

  Map<String, Object?> toJson() {
    final Map<String, dynamic> data = <String, Object?>{};

    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    data['category'] = category;
    data['date'] = date;
    data['time'] = time;
    data['lastUpdated'] = lastUpdated;
    data['remind'] = remind;
    data['streaks'] = streaks;
    data['repeat'] = repeat;
    data['isCompleted'] = isCompleted;
    data['isSkipped'] = isSkipped;
    return data;
  }
}

// 

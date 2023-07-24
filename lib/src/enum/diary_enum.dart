enum DiaryCategories { category1, category2, category3 }

extension DiaryCategoriesX on DiaryCategories {
  String get category {
    switch (this) {
      case DiaryCategories.category1:
        return 'Category 1';
      case DiaryCategories.category2:
        return 'Category 2';
      case DiaryCategories.category3:
        return 'Category 3';
    }
  }
}

enum DiaryEvents { event1, event2, event3 }

extension DiaryEventsX on DiaryEvents {
  String get event {
    switch (this) {
      case DiaryEvents.event1:
        return 'Event 1';
      case DiaryEvents.event2:
        return 'Event 2';
      case DiaryEvents.event3:
        return 'Event 3';
    }
  }
}

enum DiaryAreas { area1, area2, area3 }

extension DiaryAreasX on DiaryAreas {
  String get event {
    switch (this) {
      case DiaryAreas.area1:
        return 'Area 1';
      case DiaryAreas.area2:
        return 'Area 2';
      case DiaryAreas.area3:
        return 'Area 3';
    }
  }
}

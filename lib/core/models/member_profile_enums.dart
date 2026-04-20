// 孩子性格
enum ChildPersonality { lion, dolphin, cat }
extension ChildPersonalityExt on ChildPersonality {
  String get label {
    switch (this) {
      case ChildPersonality.lion: return '成就驅動';
      case ChildPersonality.dolphin: return '關係驅動';
      case ChildPersonality.cat: return '好奇驅動';
    }
  }
}

// 家長類型
enum ParentStyle { goalkeeper, manager, coach, sponsor }
extension ParentStyleExt on ParentStyle {
  String get label {
    switch (this) {
      case ParentStyle.goalkeeper: return '守門員型 (低時/高控/家務)';
      case ParentStyle.manager: return '經理型 (高時/高控/規矩)';
      case ParentStyle.coach: return '教練型 (高時/低控/探索)';
      case ParentStyle.sponsor: return '贊助商型 (低時/低控/放養)';
    }
  }
}

// 孩子年齡段
enum AgeGroup { stage1, stage2, stage3, stage4, stage5 }
extension AgeGroupExt on AgeGroup {
  String get label {
    switch (this) {
      case AgeGroup.stage1: return '2-4 歲';
      case AgeGroup.stage2: return '4-6 歲';
      case AgeGroup.stage3: return '6-9 歲';
      case AgeGroup.stage4: return '9-12 歲';
      case AgeGroup.stage5: return '12 歲以上';
    }
  }
}